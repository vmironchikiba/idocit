import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Добавьте этот импорт
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/injection_container.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:idocit/idocit/lib/api.dart';

class MarkdownWebViewPage extends StatefulWidget {
  final KnowledgeData knowledge;
  const MarkdownWebViewPage({super.key, required this.knowledge});

  @override
  State<MarkdownWebViewPage> createState() => _MarkdownWebViewPageState();
}

class _MarkdownWebViewPageState extends State<MarkdownWebViewPage> {
  late final WebViewController _webViewController;
  final test = locator<DocumentBloc>().state.documentResponse?.document.properties.text;
  final String _originalMarkdownData =
      locator<DocumentBloc>().state.documentResponse?.document.properties.text.replaceAll('\n\n', '\n') ??
      ''; //MarkdownTestMoc.originalMarkdownData;
  late String _currentSearchQuery = '';
  bool _isLoading = true;
  double _scrollPosition = 0;
  final List<SearchMatch> _matches = [];
  String _htmlTemplate = ''; // Для хранения загруженного шаблона

  // Для хранения состояния прокрутки
  final Map<String, double> _scrollPositions = {};

  @override
  void initState() {
    super.initState();

    // Инициализация WebView контроллера
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() => _isLoading = false);
              // После загрузки применяем поиск, если есть
              if (_currentSearchQuery.isNotEmpty) {
                _scrollToFirstMatch();
              }
            }
          },
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            LoggerService.logDebug('WebView error: ${error.description}');
          },
        ),
      );

    // Загружаем шаблон и затем обрабатываем поиск
    _loadTemplateAndProcessSearch();
  }

  /// Загружает HTML шаблон и затем обрабатывает поиск
  Future<void> _loadTemplateAndProcessSearch() async {
    try {
      // Загружаем HTML шаблон из assets
      _htmlTemplate = await rootBundle.loadString('assets/templates/document_template.html');
      LoggerService.logDebug('✅ HTML шаблон загружен (${_htmlTemplate.length} символов)');

      // Обрабатываем поисковый запрос
      await _processSearchAndLoad();
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка загрузки шаблона: $e');
      // Используем fallback шаблон в случае ошибки
      _htmlTemplate = _getFallbackTemplate();
      await _processSearchAndLoad();
    }
  }

  /// Основная функция: обработка поиска и загрузка контента
  Future<void> _processSearchAndLoad() async {
    // Получаем поисковый запрос
    // final query = removeFirstTwoLines(MarkdownTestMoc.query).trim();
    final query = removeFirstTwoLines(widget.knowledge.text).trim();
    _currentSearchQuery = query;

    LoggerService.logDebug('🔍 Поисковый запрос: "$query"');
    LoggerService.logDebug('🔍 Длина запроса: ${query.length}');

    if (query.isEmpty) {
      // Загружаем Markdown без выделений
      await _loadMarkdownWithoutHighlights();
      return;
    }

    // Подготавливаем регулярное выражение
    final escapedQuery = escapeRegexLiterals(query);
    final regex = RegExp(escapedQuery, caseSensitive: false, dotAll: true);

    // Ищем все совпадения в исходном Markdown
    final allMatches = regex.allMatches(_originalMarkdownData).toList();

    if (allMatches.isEmpty) {
      LoggerService.logDebug('🔍 Совпадений не найдено');
      await _loadMarkdownWithoutHighlights();
      return;
    }

    LoggerService.logDebug('🔍 Найдено совпадений: ${allMatches.length}');
    LoggerService.logDebug('🔍 Первое совпадение: "${allMatches.first.group(0)?.substring(0, 50)}..."');

    // Обрабатываем Markdown, добавляя HTML теги для выделений
    final markedMarkdown = _markMatchesInMarkdown(allMatches);

    // Конвертируем в HTML и загружаем
    await _loadMarkdownWithHighlights(markedMarkdown);
  }

  /// Помечает совпадения HTML тегами в Markdown тексте
  String _markMatchesInMarkdown(List<RegExpMatch> matches) {
    _matches.clear(); // Очищаем список совпадений

    final result = StringBuffer();
    int lastEnd = 0;
    int matchCounter = 0;

    for (final match in matches) {
      // Текст до совпадения
      result.write(_originalMarkdownData.substring(lastEnd, match.start));

      // Текст совпадения
      final matchedText = match.group(0)!;

      // Создаем уникальный ID
      final id = 'match-${DateTime.now().millisecondsSinceEpoch}-$matchCounter';

      // Сохраняем информацию о совпадении
      _matches.add(SearchMatch(id: id, text: matchedText, position: match.start, index: matchCounter));

      // Вставляем HTML тег прямо в Markdown
      result.write('<mark class="search-match" id="$id" data-match-index="$matchCounter">');
      result.write(matchedText);
      result.write('</mark>');

      lastEnd = match.end;
      matchCounter++;
    }

    // Остаток текста после последнего совпадения
    result.write(_originalMarkdownData.substring(lastEnd));

    LoggerService.logDebug('📝 Создано тегов <mark>: ${_matches.length}');

    return result.toString();
  }

  /// Загружает Markdown без выделений
  Future<void> _loadMarkdownWithoutHighlights() async {
    final htmlContent = md.markdownToHtml(_originalMarkdownData, extensionSet: md.ExtensionSet.gitHubFlavored);

    await _loadHtmlToWebView(htmlContent, hasHighlights: false);
  }

  /// Загружает Markdown с выделениями
  Future<void> _loadMarkdownWithHighlights(String markedMarkdown) async {
    // Конвертируем Markdown в HTML
    final htmlContent = md.markdownToHtml(markedMarkdown, extensionSet: md.ExtensionSet.gitHubFlavored);

    // Для отладки: проверяем наличие тегов <mark>
    final markCount = htmlContent.split('<mark').length - 1;
    LoggerService.logDebug('🔍 Тегов <mark> в HTML: $markCount');

    if (markCount == 0) {
      LoggerService.logDebug('⚠️ ВНИМАНИЕ: Теги <mark> не обнаружены в HTML!');
      LoggerService.logDebug('📄 Первые 500 символов HTML: ${htmlContent.substring(0, 500)}');
    }

    await _loadHtmlToWebView(htmlContent, hasHighlights: markCount > 0);
  }

  /// Загружает HTML в WebView, используя шаблон
  Future<void> _loadHtmlToWebView(String htmlContent, {bool hasHighlights = false}) async {
    if (_htmlTemplate.isEmpty) {
      LoggerService.logDebug('⚠️ HTML шаблон не загружен, использую fallback');
      _htmlTemplate = _getFallbackTemplate();
    }

    // Создаем финальную HTML страницу из шаблона
    final htmlPage = _buildHtmlFromTemplate(htmlContent, hasHighlights);

    await _webViewController.loadHtmlString(htmlPage, baseUrl: Uri.parse('https://localhost/').toString());

    // Настраиваем канал для обмена сообщениями с JavaScript
    _setupJavaScriptChannel();
  }

  /// Строит HTML страницу из шаблона
  String _buildHtmlFromTemplate(String htmlContent, bool hasHighlights) {
    // Заменяем плейсхолдер контентом
    var result = _htmlTemplate.replaceFirst('<!-- CONTENT_PLACEHOLDER -->', htmlContent);

    // Создаем HTML для навигационной панели
    final navHtml = hasHighlights
        ? '<div id="matches-nav" class="matches-nav">Найдено: <span id="match-count">0</span></div>'
        : '';

    // Заменяем плейсхолдер навигации
    result = result.replaceFirst('<!-- NAVIGATION_PLACEHOLDER -->', navHtml);

    // Для отладки: добавляем информацию о загрузке
    result = result.replaceFirst('</body>', '''
      <div class="debug-info" id="page-info" style="display: none;">
        Загружено: ${DateTime.now().toLocal()}<br>
        Совпадений: ${_matches.length}<br>
        Поиск: "${_currentSearchQuery.substring(0, 50)}"
      </div>
      <script>
        // Показываем отладочную информацию при двойном клике
        document.addEventListener('dblclick', function() {
          const info = document.getElementById('page-info');
          if (info) {
            info.style.display = info.style.display === 'none' ? 'block' : 'none';
          }
        });
      </script>
      </body>
      ''');

    return result;
  }

  /// Fallback шаблон на случай, если не удалось загрузить файл
  String _getFallbackTemplate() {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: sans-serif; padding: 20px; }
        mark.search-match { background: yellow; padding: 2px; }
        mark.search-match.current-match { background: orange; border: 2px solid red; }
    </style>
</head>
<body>
    <!-- CONTENT_PLACEHOLDER -->
    <!-- NAVIGATION_PLACEHOLDER -->
    <script>
        let currentMatchIndex = 0;
        let allMatches = [];
        
        document.addEventListener('DOMContentLoaded', function() {
            allMatches = Array.from(document.querySelectorAll('mark.search-match'));
            if (allMatches.length > 0) {
                setTimeout(() => {
                    allMatches[0].classList.add('current-match');
                    allMatches[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
                }, 300);
            }
        });
        
        window.scrollToFirstMatch = function() {
            if (allMatches.length > 0) {
                allMatches[0].scrollIntoView({ behavior: 'smooth', block: 'center' });
                return true;
            }
            return false;
        };
    </script>
</body>
</html>''';
  }

  /// Настройка JavaScript канала для общения
  void _setupJavaScriptChannel() {
    _webViewController.addJavaScriptChannel(
      'FlutterChannel',
      onMessageReceived: (JavaScriptMessage message) {
        try {
          final data = jsonDecode(message.message);
          final event = data['event'];
          final payload = data['payload'];

          switch (event) {
            case 'scroll_position':
              _scrollPosition = (payload as num).toDouble();
              LoggerService.logDebug('📊 Текущая позиция скролла: $_scrollPosition');
              break;
            case 'highlight_position':
              final position = (payload as num).toDouble();
              LoggerService.logDebug('📍 Позиция выделения: $position');
              _scrollPositions[_currentSearchQuery] = position;
              break;
            case 'match_navigated':
              final currentIndex = payload['currentIndex'] as int;
              final totalMatches = payload['totalMatches'] as int;
              LoggerService.logDebug('🎯 Совпадение ${currentIndex + 1} из $totalMatches');
              break;
          }
        } catch (e) {
          LoggerService.logDebug('⚠️ Ошибка обработки сообщения от JavaScript: $e');
        }
      },
    );

    // Канал для отладки
    _webViewController.addJavaScriptChannel(
      'DebugChannel',
      onMessageReceived: (JavaScriptMessage message) {
        LoggerService.logDebug('🔍 DEBUG: ${message.message}');
      },
    );
  }

  /// Прокрутка к первому совпадению
  Future<void> _scrollToFirstMatch() async {
    if (_matches.isEmpty) {
      LoggerService.logDebug('🔍 Нет совпадений для прокрутки');
      return;
    }

    try {
      final result = await _webViewController.runJavaScriptReturningResult('''
        if (window.scrollToFirstMatch) {
          const result = window.scrollToFirstMatch();
          JSON.stringify(result);
        }
      ''');

      final data = jsonDecode(result as String);
      if (data['success'] == true) {
        LoggerService.logDebug('✅ Прокрутка к первому совпадению выполнена');
      } else {
        LoggerService.logDebug('❌ Не удалось прокрутить: ${data['message']}');
      }
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка при прокрутке: $e');
    }
  }

  /// Навигация к следующему совпадению
  Future<void> _goToNextMatch() async {
    if (_matches.isEmpty) return;

    try {
      final result = await _webViewController.runJavaScriptReturningResult('''
        if (window.goToNextMatch) {
          const result = window.goToNextMatch();
          JSON.stringify(result);
        }
      ''');

      final data = jsonDecode(result as String);
      if (data['success'] == true) {
        LoggerService.logDebug('➡️ Совпадение ${data['currentIndex'] + 1}/${data['total']}');
      }
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка навигации: $e');
    }
  }

  /// Навигация к предыдущему совпадению
  Future<void> _goToPreviousMatch() async {
    if (_matches.isEmpty) return;

    try {
      final result = await _webViewController.runJavaScriptReturningResult('''
        if (window.goToPreviousMatch) {
          const result = window.goToPreviousMatch();
          JSON.stringify(result);
        }
      ''');

      final data = jsonDecode(result as String);
      if (data['success'] == true) {
        LoggerService.logDebug('⬅️ Совпадение ${data['currentIndex'] + 1}/${data['total']}');
      }
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка навигации: $e');
    }
  }

  /// Получение информации о совпадениях
  Future<void> _getMatchesInfo() async {
    try {
      final result = await _webViewController.runJavaScriptReturningResult('''
        if (window.getMatchesInfo) {
          JSON.stringify(window.getMatchesInfo());
        }
      ''');

      final info = jsonDecode(result as String);
      LoggerService.logDebug('📊 Всего совпадений: ${info['total']}');
      LoggerService.logDebug('📌 Текущий индекс: ${info['currentIndex']}');
      if (info['matches'] is List && info['matches'].length > 0) {
        LoggerService.logDebug('🔍 Первые 3 совпадения:');
        for (final match in (info['matches'] as List).take(3)) {
          LoggerService.logDebug('  - [${match['index']}] "${match['text']}"');
        }
      }
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка получения информации: $e');
    }
  }

  /// Отладочная информация
  Future<void> _getDebugInfo() async {
    try {
      final result = await _webViewController.runJavaScriptReturningResult('''
        if (window.debugInfo) {
          JSON.stringify(window.debugInfo());
        }
      ''');

      final info = jsonDecode(result as String);
      LoggerService.logDebug('🐛 Отладочная информация:');
      LoggerService.logDebug('   URL: ${info['url']}');
      LoggerService.logDebug('   Совпадений: ${info['matchesCount']}');
      LoggerService.logDebug('   Прокрутка: ${info['scrollY']}px');
      LoggerService.logDebug('   Высота окна: ${info['windowHeight']}px');
      LoggerService.logDebug('   Высота документа: ${info['documentHeight']}px');
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка получения отладочной информации: $e');
    }
  }

  /// Обновление поиска (при изменении данных в MarkdownTestMoc)
  void _refreshSearch() {
    LoggerService.logDebug('🔄 Обновление поиска...');
    _processSearchAndLoad();
  }

  /// Убирает первые две строки (для поискового запроса)
  String removeFirstTwoLines(String input) {
    final lines = input.split('\n');
    return lines.length <= 2 ? '' : lines.sublist(2).join('\n').trim();
  }

  /// Экранирует специальные символы для регулярных выражений
  String escapeRegexLiterals(String? input) {
    final text = input ?? '';
    final replacedNbsp = text.replaceAll('\u00A0', ' ');
    return replacedNbsp.replaceAllMapped(RegExp(r'([.*+?^${}()|\[\]\\])'), (match) => '\\${match[0]}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.knowledge.docName.split('\n').isNotEmpty ? widget.knowledge.docName.split('\n').first : ''),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_matches.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(child: Text('${_matches.length} совпад.', style: const TextStyle(fontSize: 14))),
            ),
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshSearch, tooltip: 'Обновить поиск'),
          IconButton(icon: const Icon(Icons.bug_report), onPressed: _getDebugInfo, tooltip: 'Отладочная информация'),
        ],
      ),

      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),

          if (_isLoading)
            Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),

      floatingActionButton: _matches.isNotEmpty
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Навигация по совпадениям
                FloatingActionButton(
                  onPressed: _goToPreviousMatch,
                  tooltip: 'Предыдущее совпадение',
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                ),

                const SizedBox(height: 16),

                FloatingActionButton(
                  onPressed: _goToNextMatch,
                  tooltip: 'Следующее совпадение',
                  backgroundColor: Colors.blue,
                  child: const Icon(Icons.arrow_downward, color: Colors.white),
                ),

                const SizedBox(height: 16),

                // Информация о совпадениях
                FloatingActionButton(
                  onPressed: _getMatchesInfo,
                  tooltip: 'Информация о совпадениях',
                  backgroundColor: Colors.green,
                  mini: true,
                  child: const Icon(Icons.info, color: Colors.white, size: 20),
                ),

                const SizedBox(height: 16),

                // Прокрутка к первому
                FloatingActionButton(
                  onPressed: _scrollToFirstMatch,
                  tooltip: 'К первому совпадению',
                  backgroundColor: Colors.orange,
                  mini: true,
                  child: const Icon(Icons.first_page, color: Colors.white, size: 20),
                ),

                const SizedBox(height: 16),

                // В начало документа
                FloatingActionButton(
                  onPressed: () async {
                    await _webViewController.runJavaScript('window.scrollTo({top: 0, behavior: "smooth"});');
                    LoggerService.logDebug('⬆️ Прокрутка в начало');
                  },
                  tooltip: 'В начало',
                  backgroundColor: Colors.purple,
                  mini: true,
                  child: const Icon(Icons.vertical_align_top, color: Colors.white, size: 20),
                ),
              ],
            )
          : FloatingActionButton(
              onPressed: _refreshSearch,
              tooltip: 'Обновить поиск',
              backgroundColor: Colors.blue,
              child: const Icon(Icons.search, color: Colors.white),
            ),
    );
  }
}

/// Класс для хранения информации о совпадении
class SearchMatch {
  final String id;
  final String text;
  final int position;
  final int index;

  SearchMatch({required this.id, required this.text, required this.position, required this.index});

  @override
  String toString() {
    return 'SearchMatch{id: $id, index: $index, position: $position, text: "${text.substring(0, 50)}..."}';
  }
}
