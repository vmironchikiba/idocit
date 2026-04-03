import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/dialogs.dart';
import 'package:idocit/common/widgets/dialogs/warning_dialog.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/injection_container.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:idocit/idocit/lib/api.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MarkdownWebViewPage extends StatefulWidget {
  final KnowledgeData knowledge;
  const MarkdownWebViewPage({super.key, required this.knowledge});

  @override
  State<MarkdownWebViewPage> createState() => _MarkdownWebViewPageState();
}

class _MarkdownWebViewPageState extends State<MarkdownWebViewPage> {
  static const hasDebugInfo = false;
  late final WebViewController _webViewController;
  final String docType =
      locator<DocumentBloc>().state.documentResponse?.document.properties.docType ?? 'Unknown Document Type';
  final String _docLink = locator<DocumentBloc>().state.documentResponse?.document.properties.docLink ?? '';
  final Uri? _docLinkUri = Uri.tryParse(
    locator<DocumentBloc>().state.documentResponse?.document.properties.docLink ?? '::Not valid URI::',
  );
  final List<DocumentChunk> _chunks = locator<DocumentBloc>().state.documentResponse?.chunks ?? [];
  // final String _originalMarkdownData =
  //     locator<DocumentBloc>().state.documentResponse?.document.properties.text.replaceAll('\n\n', '\n') ?? '';
  late String _currentSearchQuery = '';
  bool _isLoading = true;
  double _scrollPosition = 0;
  final List<SearchMatch> _matches = [];
  String _htmlTemplate = '';
  String _fallbackTemplate = ''; // Добавьте это поле
  // late String _preparedText;
  final Map<String, double> _scrollPositions = {};
  late String _textFromChunks;
  bool channelsInitialized = false;
  int progress = 0;

  WebViewController _initController() {
    // 1. Создаём параметры (без inspectable)
    PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams();
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    // 2. Создаём контроллер
    final controller = WebViewController.fromPlatformCreationParams(params);

    // 3. Включаем инспектирование для iOS 16.4+
    if (controller.platform is WebKitWebViewController) {
      (controller.platform as WebKitWebViewController).setInspectable(true);
    }

    // Остальные настройки
    return controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setOnConsoleMessage((JavaScriptConsoleMessage message) {
        // if (message.level == JavaScriptLogLevel.error) {
        // LoggerService.logDebug('WebView Console Error: ${message.message}');
        // }
        LoggerService.logDebug('WebView Console: ${message.message}');
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            final url = request.url;
            // Игнорируем пустые или промежуточные навигации
            if (url == 'about:blank') {
              return NavigationDecision.navigate; // или .prevent, в зависимости от задачи
            }
            final uri = Uri.tryParse(url);
            if (uri == null) return NavigationDecision.navigate;
            // Если это не обычная веб-страница
            if (!_isHtmlPage(uri)) {
              await _openExternalWithUrl(url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
            setState(() {
              this.progress = progress;
            });
          },

          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            // if (!channelsInitialized) {
            //   _setupJavaScriptChannel();
            //   channelsInitialized = true;
            // }
            setState(() => _isLoading = false);
          },
          onHttpError: (error) {
            LoggerService.logDebug(
              "onHttpError: ${error.request?.uri.toString() ?? 'No request'}  ${error.response?.statusCode ?? 'No response'}",
            );
          },
          onSslAuthError: (error) {
            LoggerService.logDebug("onSslAuthError: ${error.toString()}");
          },
          onWebResourceError: (WebResourceError error) async {
            // await idocitShowDialog<bool?>(
            //   IdocItWarningDialog(
            //     label: error.errorType.toString(),
            //     description: error.description,
            //     iconSrc: ImageConstants.igIdocIt,
            //     buttonText: 'OK',
            //     // buttonCallback: _onTryAgainHandler,
            //   ),
            // );
            LoggerService.logDebug(
              'onWebResourceError: ${error.errorType} - ${error.errorCode} - ${error.description}',
            );

            // КЛЮЧЕВОЕ: обрабатываем именно ошибку завершения процесса
            if (Platform.isIOS && error.errorType == WebResourceErrorType.webContentProcessTerminated) {
              LoggerService.logDebug('WebContent process terminated. Reloading...');
              // Небольшая задержка перед перезагрузкой, чтобы система успела "успокоиться"
              Future.delayed(const Duration(milliseconds: 500), () {
                _webViewController.reload();
              });
            }
          },
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    // _preparedText = escapeMarkdownLiterals(_originalMarkdownData);
    _currentSearchQuery = widget.knowledge.text;
    final chunksList = _chunks.indexed.map((item) {
      final (index, chunk) = item;
      final id = 'match-${DateTime.now().millisecondsSinceEpoch}-$index';
      if (chunk.textNoOverlap.contains(widget.knowledge.text)) {
        LoggerService.logDebug('STOP');
      }

      return chunk.chunkId == widget.knowledge.chunkId - 1
          ? '<mark class="search-match" id="$id" data-match-index="$index">${chunk.textNoOverlap}</mark>'
          : chunk.textNoOverlap;
    }).toList();

    _textFromChunks = chunksList.join('');
    // escapeMarkdownLiterals(chunksList.join(''));
    _webViewController = _initController();
    if (!channelsInitialized) {
      _setupJavaScriptChannel();
      channelsInitialized = true;
    }
    _loadTemplatesAndProcessSearchNew(); // Измените название метода
  }

  bool _isHtmlPage(Uri uri) {
    final path = uri.path.toLowerCase();
    final link = uri.toString();

    return path.endsWith('.html') ||
        path.endsWith('.htm') ||
        path.isEmpty ||
        path.endsWith('/') ||
        link == _docLinkUri.toString();
  }

  Future<void> _loadTemplatesAndProcessSearchNew() async {
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
    await _processSearchAndLoadNew(_textFromChunks);
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

  Future<void> _processSearchAndLoadNew(String text) async {
    await _loadMarkdownWithHighlights(text);
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

    await _webViewController.loadHtmlString(
      htmlPage,
      // baseUrl: _docLinkUri != null && _docLink.isNotEmpty && _docLink != 'about:blank' ? _docLink : null,
    );

    // _setupJavaScriptChannel();
  }

  /// Строит HTML страницу из шаблона
  String _buildHtmlFromTemplate(String htmlContent, bool hasHighlights) {
    var result = _htmlTemplate.replaceFirst('<!-- CONTENT_PLACEHOLDER -->', htmlContent);

    final navHtml = hasHighlights && hasDebugInfo
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

  void _refreshSearch() {
    LoggerService.logDebug('🔄 Обновление поиска...');
    _processSearchAndLoadNew(_textFromChunks);
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

  Future<void> _openExternal() async {
    if (_docLink.isEmpty) return;
    _openExternalWithUrl(_docLink);
  }

  Future<void> _openExternalWithUrl(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    final canLaunch = await canLaunchUrl(uri);
    if (!canLaunch) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset(ImageConstants.igIdocIt, height: 8, width: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.knowledge.docName.split('\n').firstOrNull ?? 'Документ',
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        actions: [
          if (progress > 0 && progress < 100)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(child: Text('$progress%', style: const TextStyle(fontSize: 14))),
            ),
        ],
      ),

      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color.fromRGBO(255, 217, 39, 1.0),
                      ),
                      child: Text(
                        docType,
                        style: TextStyle(color: ColorConstants.black500, fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                    ),
                    if (_docLink.isNotEmpty)
                      IconButton(
                        onPressed: _openExternal,
                        icon: Icon(Icons.open_in_browser, color: ColorConstants.white500, size: 30),
                      ),
                  ],
                ),
              ),
              Expanded(child: WebViewWidget(controller: _webViewController)),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.white,
              child: const Center(child: IdocItLoadingIndicator(size: 40.0, color: ColorConstants.loading)),
            ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _refreshSearch,
        tooltip: 'Обновить поиск',
        backgroundColor: ColorConstants.loading,
        child: const Icon(Icons.refresh, color: ColorConstants.black350),
      ),
    );
  }
}
//onst Icon(Icons.refresh, color: ColorConstants.moccasin)

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
