import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/pages/markdown_web_view_page.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:idocit/common/services/logger.dart';

class MarkdownInAppWebViewPage extends StatefulWidget {
  final KnowledgeData knowledge;
  MarkdownInAppWebViewPage({super.key, required this.knowledge});

  // Новые настройки (заменяют InAppWebViewGroupOptions)
  late InAppWebViewSettings settings;
  late PullToRefreshController pullToRefreshController;

  @override
  State<MarkdownInAppWebViewPage> createState() => _MarkdownInAppWebViewPageState();
}

class _MarkdownInAppWebViewPageState extends State<MarkdownInAppWebViewPage> {
  static const hasDebugInfo = false;
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();
  double progress = 0;
  bool _isLoading = true;
  String _htmlTemplate = '';
  late String _textFromChunks;
  late String _currentSearchQuery = '';
  final List<DocumentChunk> _chunks = locator<DocumentBloc>().state.documentResponse?.chunks ?? [];
  final List<SearchMatch> _matches = [];
  // Новые настройки (заменяют InAppWebViewGroupOptions)
  late InAppWebViewSettings settings;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    _currentSearchQuery = widget.knowledge.text;
    final chunksList = _chunks.indexed.map((item) {
      final (index, chunk) = item;
      final id = 'match-${DateTime.now().millisecondsSinceEpoch}-$index';
      if (chunk.textNoOverlap.contains(widget.knowledge.text)) {
        LoggerService.logDebug('STOP');
      }

      return chunk.chunkId == widget.knowledge.chunkId
          ? '<mark class="search-match" id="$id" data-match-index="$index">${chunk.textNoOverlap}</mark>'
          : chunk.textNoOverlap;
    }).toList();

    _textFromChunks = chunksList.join('');

    // Инициализация настроек
    settings = InAppWebViewSettings(
      // Общие (бывшие crossPlatform)
      javaScriptEnabled: true,
      useShouldOverrideUrlLoading: true,
      clearCache: true,
      cacheEnabled: true,
      // Дополнительно: ограничение памяти (не решает проблему, но может помочь)
      preferredContentMode: UserPreferredContentMode.MOBILE,
      allowsBackForwardNavigationGestures: true,

      // iOS специфичные
      allowsInlineMediaPlayback: true,
      isFraudulentWebsiteWarningEnabled: false,

      // Android специфичные (если нужны)
      // android: AndroidWebViewSettings(
      //   mixedContentMode: AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
      // ),
    );

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(color: Colors.blue),
      onRefresh: () async {
        if (Platform.isIOS) {
          await webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        } else {
          await webViewController?.reload();
        }
      },
    );

    _setupInAppWebView();
  }

  void _setupInAppWebView() {
    // Здесь будет загрузка HTML (вызов _loadTemplatesAndProcessSearchNew)
    _loadTemplatesAndProcessSearchNew();
  }

  Future<void> _loadTemplatesAndProcessSearchNew() async {
    try {
      // Загружаем основной шаблон
      _htmlTemplate = await rootBundle.loadString('assets/templates/document_template.html');
      LoggerService.logDebug('✅ Основной HTML шаблон загружен (${_htmlTemplate.length} символов)');
    } catch (e) {
      LoggerService.logDebug('⚠️ Ошибка загрузки основного шаблона: $e');
      // Пробуем загрузить fallback шаблон
      ///     await _loadFallbackTemplate();
    }

    // Обрабатываем поисковый запрос
    await _processSearchAndLoadNew(_textFromChunks);
  }

  Future<void> _processSearchAndLoadNew(String text) async {
    await _loadMarkdownWithHighlights(text);
  }

  Future<void> _loadMarkdownWithHighlights(String markedMarkdown) async {
    final htmlContent = md.markdownToHtml(markedMarkdown, extensionSet: md.ExtensionSet.gitHubFlavored);
    final markCount = htmlContent.split('<mark').length - 1;
    LoggerService.logDebug('🔍 Тегов <mark> в HTML: $markCount');

    if (markCount == 0) {
      LoggerService.logDebug('⚠️ ВНИМАНИЕ: Теги <mark> не обнаружены в HTML!');
    }

    await _loadHtmlToWebView(htmlContent, hasHighlights: markCount > 0);
  }

  Future<void> _loadHtmlToWebView(String htmlContent, {bool hasHighlights = false}) async {
    if (_htmlTemplate.isEmpty) {
      LoggerService.logDebug('⚠️ HTML шаблон не загружен, загружаю fallback');
      await _loadFallbackTemplate();
    }

    final htmlPage = _buildHtmlFromTemplate(htmlContent, hasHighlights);
    await webViewController?.loadData(data: htmlPage);

    // await _webViewController.loadHtmlString(
    //   htmlPage,
    //   // baseUrl: _docLinkUri != null && _docLink.isNotEmpty && _docLink != 'about:blank' ? _docLink : null,
    // );

    // _setupJavaScriptChannel();
  }

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

  String _getBuiltInFallbackTemplate() => StringsConstants.fallbackHtmlTemplate;
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
  // ... остальные методы

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
