import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/constants/strings.dart';
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
  final String _originalMarkdownData =
      locator<DocumentBloc>().state.documentResponse?.document.properties.text.replaceAll('\n\n', '\n') ?? '';
  late String _currentSearchQuery = '';
  bool _isLoading = true;
  double _scrollPosition = 0;
  final List<SearchMatch> _matches = [];
  String _htmlTemplate = '';
  String _fallbackTemplate = ''; // Добавьте это поле

  final Map<String, double> _scrollPositions = {};

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() => _isLoading = false);
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

    _loadTemplatesAndProcessSearch(); // Измените название метода
  }

  /// Загружает оба шаблона (основной и fallback) и обрабатывает поиск
  Future<void> _loadTemplatesAndProcessSearch() async {
    try {
      // Загружаем основной шаблон
      _htmlTemplate = await rootBundle.loadString('assets/templates/document_template.html');
      LoggerService.logDebug('✅ Основной HTML шаблон загружен (${_htmlTemplate.length} символов)');
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка загрузки основного шаблона: $e');
      // Пробуем загрузить fallback шаблон
      await _loadFallbackTemplate();
    }

    // Обрабатываем поисковый запрос
    await _processSearchAndLoad();
  }

  /// Загружает fallback шаблон из файла
  Future<void> _loadFallbackTemplate() async {
    try {
      _htmlTemplate = await rootBundle.loadString('assets/templates/fallback_template.html');
      LoggerService.logDebug('✅ Fallback шаблон загружен из файла');
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка загрузки fallback шаблона из файла: $e');
      // Используем встроенный fallback
      _htmlTemplate = _getBuiltInFallbackTemplate();
      LoggerService.logDebug('✅ Использован встроенный fallback шаблон');
    }
  }

  /// Встроенный fallback шаблон (на случай, если файл тоже не загрузится)
  String _getBuiltInFallbackTemplate() => StringsConstants.fallbackHtmlTemplate;

  /// Основная функция: обработка поиска и загрузка контента
  Future<void> _processSearchAndLoad() async {
    final query = removeFirstTwoLines(widget.knowledge.text).trim();
    _currentSearchQuery = query;

    LoggerService.logDebug('🔍 Поисковый запрос: "$query"');
    LoggerService.logDebug('🔍 Длина запроса: ${query.length}');

    if (query.isEmpty) {
      await _loadMarkdownWithoutHighlights();
      return;
    }

    final escapedQuery = escapeRegexLiterals(query);
    final regex = RegExp(escapedQuery, caseSensitive: false, dotAll: true);
    final allMatches = regex.allMatches(_originalMarkdownData).toList();

    if (allMatches.isEmpty) {
      LoggerService.logDebug('🔍 Совпадений не найдено');
      await _loadMarkdownWithoutHighlights();
      return;
    }

    LoggerService.logDebug('🔍 Найдено совпадений: ${allMatches.length}');
    if (allMatches.isNotEmpty) {
      LoggerService.logDebug('🔍 Первое совпадение: "${allMatches.first.group(0)?.substring(0, 50)}..."');
    }

    final markedMarkdown = _markMatchesInMarkdown(allMatches);
    await _loadMarkdownWithHighlights(markedMarkdown);
  }

  /// Помечает совпадения HTML тегами в Markdown тексте
  String _markMatchesInMarkdown(List<RegExpMatch> matches) {
    _matches.clear();

    final result = StringBuffer();
    int lastEnd = 0;
    int matchCounter = 0;

    for (final match in matches) {
      result.write(_originalMarkdownData.substring(lastEnd, match.start));
      final matchedText = match.group(0)!;
      final id = 'match-${DateTime.now().millisecondsSinceEpoch}-$matchCounter';

      _matches.add(SearchMatch(id: id, text: matchedText, position: match.start, index: matchCounter));

      result.write('<mark class="search-match" id="$id" data-match-index="$matchCounter">');
      result.write(matchedText);
      result.write('</mark>');

      lastEnd = match.end;
      matchCounter++;
    }

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
    final htmlContent = md.markdownToHtml(markedMarkdown, extensionSet: md.ExtensionSet.gitHubFlavored);
    final markCount = htmlContent.split('<mark').length - 1;
    LoggerService.logDebug('🔍 Тегов <mark> в HTML: $markCount');

    if (markCount == 0) {
      LoggerService.logDebug('⚠️ ВНИМАНИЕ: Теги <mark> не обнаружены в HTML!');
    }

    await _loadHtmlToWebView(htmlContent, hasHighlights: markCount > 0);
  }

  /// Загружает HTML в WebView, используя шаблон
  Future<void> _loadHtmlToWebView(String htmlContent, {bool hasHighlights = false}) async {
    if (_htmlTemplate.isEmpty) {
      LoggerService.logDebug('⚠️ HTML шаблон не загружен, загружаю fallback');
      await _loadFallbackTemplate();
    }

    final htmlPage = _buildHtmlFromTemplate(htmlContent, hasHighlights);

    await _webViewController.loadHtmlString(htmlPage, baseUrl: Uri.parse('https://localhost/').toString());

    _setupJavaScriptChannel();
  }

  /// Строит HTML страницу из шаблона
  String _buildHtmlFromTemplate(String htmlContent, bool hasHighlights) {
    var result = _htmlTemplate.replaceFirst('<!-- CONTENT_PLACEHOLDER -->', htmlContent);

    final navHtml = hasHighlights
        ? '<div id="matches-nav" class="matches-nav">Найдено: <span id="match-count">0</span></div>'
        : '';

    result = result.replaceFirst('<!-- NAVIGATION_PLACEHOLDER -->', navHtml);

    // Добавляем отладочную информацию только если это не fallback шаблон
    if (!_htmlTemplate.contains('<!-- NAVIGATION_PLACEHOLDER -->')) {
      result = result.replaceFirst('</body>', '''
        <div class="debug-info" id="page-info" style="display: none; position: fixed; top: 10px; left: 10px; background: rgba(0,0,0,0.8); color: white; padding: 10px; border-radius: 5px; font-size: 12px; z-index: 1000;">
          Загружено: ${DateTime.now().toLocal()}<br>
          Совпадений: ${_matches.length}<br>
          Поиск: "${_currentSearchQuery.substring(0, 50)}"
        </div>
        <script>
          document.addEventListener('dblclick', function() {
            const info = document.getElementById('page-info');
            if (info) {
              info.style.display = info.style.display === 'none' ? 'block' : 'none';
            }
          });
        </script>
        </body>
      ''');
    }

    return result;
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

      if (result.toString().isNotEmpty) {
        final data = jsonDecode(result as String);
        if (data['success'] == true) {
          LoggerService.logDebug('✅ Прокрутка к первому совпадению выполнена');
        } else {
          LoggerService.logDebug('❌ Не удалось прокрутить: ${data['message']}');
        }
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

      if (result.toString().isNotEmpty) {
        final data = jsonDecode(result as String);
        if (data['success'] == true) {
          LoggerService.logDebug('➡️ Совпадение ${data['currentIndex'] + 1}/${data['total']}');
        }
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

      if (result.toString().isNotEmpty) {
        final data = jsonDecode(result as String);
        if (data['success'] == true) {
          LoggerService.logDebug('⬅️ Совпадение ${data['currentIndex'] + 1}/${data['total']}');
        }
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

      if (result.toString().isNotEmpty) {
        final info = jsonDecode(result as String);
        LoggerService.logDebug('📊 Всего совпадений: ${info['total']}');
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

      if (result.toString().isNotEmpty) {
        final info = jsonDecode(result as String);
        LoggerService.logDebug('🐛 Отладочная информация:');
        LoggerService.logDebug('   Совпадений: ${info['matchesCount']}');
      }
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка получения отладочной информации: $e');
    }
  }

  /// Обновление поиска
  void _refreshSearch() {
    LoggerService.logDebug('🔄 Обновление поиска...');
    _processSearchAndLoad();
  }

  /// Убирает первые две строки
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
          widget.knowledge.docName.split('\n').firstOrNull ?? 'Документ',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                FloatingActionButton(
                  onPressed: _getMatchesInfo,
                  tooltip: 'Информация о совпадениях',
                  backgroundColor: Colors.green,
                  mini: true,
                  child: const Icon(Icons.info, color: Colors.white, size: 20),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  onPressed: _scrollToFirstMatch,
                  tooltip: 'К первому совпадению',
                  backgroundColor: Colors.orange,
                  mini: true,
                  child: const Icon(Icons.first_page, color: Colors.white, size: 20),
                ),
                const SizedBox(height: 16),
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
