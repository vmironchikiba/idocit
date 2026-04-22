import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/models/extensions/string_path.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_marquee_plus/flutter_marquee_plus.dart';

class MarkdownInAppWebViewPage extends StatefulWidget {
  final KnowledgeData knowledge;

  const MarkdownInAppWebViewPage({super.key, required this.knowledge});

  @override
  State<MarkdownInAppWebViewPage> createState() => _MarkdownInAppWebViewPageState();
}

class _MarkdownInAppWebViewPageState extends State<MarkdownInAppWebViewPage> {
  bool _snackBarIsProcessing = false;
  late ScaffoldMessengerState _scaffoldMessenger;
  InAppWebViewController? _controller;
  bool canGoBack = false;
  bool canGoForward = false;

  bool _isLoading = true;
  int progress = 0;

  String _htmlTemplate = '';
  String _htmlPage = '';

  final List<DocumentChunk> _chunks = locator<DocumentBloc>().state.documentResponse?.chunks ?? [];
  // late String _currentSearchQuery = '';
  final String docType =
      locator<DocumentBloc>().state.documentResponse?.document.properties.docType ?? 'Unknown Document Type';
  late String _textFromChunks;
  late WebUri? _docLink;
  late WebUri? _currentUri;

  @override
  void initState() {
    super.initState();
    final url = locator<DocumentBloc>().state.documentResponse?.document.properties.docLink;
    _docLink = url != null ? WebUri(url) : null;
    _currentUri = _docLink;

    // _currentSearchQuery = widget.knowledge.text;
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

    _loadTemplatesAndProcess();
  }

  // =========================
  // INIT
  // =========================

  Future<void> _loadTemplatesAndProcess() async {
    try {
      _htmlTemplate = await rootBundle.loadString('assets/templates/document_template.html');
    } catch (_) {
      _htmlTemplate = _fallbackTemplate();
    }

    _prepareHtml(_textFromChunks); // 👈 только генерим HTML
  }

  void _prepareHtml(String markdown) {
    final html = md.markdownToHtml(markdown, extensionSet: md.ExtensionSet.gitHubFlavored);

    _htmlPage = _htmlTemplate.replaceFirst('<!-- CONTENT_PLACEHOLDER -->', html);
  }

  String _fallbackTemplate() {
    return """
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
      </head>
      <body>
        <!-- CONTENT_PLACEHOLDER -->
      </body>
    </html>
    """;
  }

  // =========================
  // MARKDOWN → HTML
  // =========================

  Future<void> _loadMarkdown(String markdown) async {
    final html = md.markdownToHtml(markdown, extensionSet: md.ExtensionSet.gitHubFlavored);

    _htmlPage = _htmlTemplate.replaceFirst('<!-- CONTENT_PLACEHOLDER -->', html);

    if (_controller != null) {
      await _controller!.loadData(data: _htmlPage, mimeType: "text/html", encoding: "utf-8");
    }
  }

  // =========================
  // URL handling
  // =========================

  Future<void> _handleExternalUrl(BuildContext context) async {
    LoggerService.logDebug("Open external: $_currentUri");

    if (_currentUri == null) return;
    final uri = _currentUri!.uriValue;
    final canLaunch = await canLaunchUrl(uri);
    if (!canLaunch) return;
    if (!canLaunch || !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Could not launch $uri', 5);
    }
  }

  bool _isHtml(Uri uri) {
    final path = uri.path.toLowerCase();
    return path.endsWith('.html') || path.endsWith('.htm') || path.isEmpty || path.endsWith('/');
  }

  // =========================
  // UI
  // =========================

  Future<void> showSnackBar(BuildContext context, String text, int seconds) async {
    if (_snackBarIsProcessing || !mounted) return;
    setState(() {
      _isLoading = false;
      _snackBarIsProcessing = true;
    });
    _scaffoldMessenger.showSnackBar(
      SnackBar(
        key: UniqueKey(),
        content: Text(text),
        duration: Duration(seconds: seconds),
      ),
    );
    await Future.delayed(Duration(seconds: seconds + 2));
    setState(() {
      _snackBarIsProcessing = false;
    });
  }

  void _shareAsXFile(BuildContext context) async {
    _scaffoldMessenger.clearSnackBars();
    final box = context.findRenderObject() as RenderBox?;
    final docName = widget.knowledge.docName.split('\n').firstOrNull ?? 'Документ';
    final body = widget.knowledge.text;
    final mdDocName = docName.withExtension('md');
    final htmlDocName = docName.withExtension('html');
    try {
      final shareResult = await SharePlus.instance.share(
        ShareParams(
          text: body,
          files: [
            XFile.fromData(utf8.encode(_htmlPage), name: htmlDocName, mimeType: 'text/html'),
            XFile.fromData(utf8.encode(_textFromChunks), name: mdDocName, mimeType: 'text/markdown'),
          ],
          subject: docName,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
          fileNameOverrides: [htmlDocName, mdDocName],
          downloadFallbackEnabled: true,
          // excludedCupertinoActivities: excludedCupertinoActivityType,
        ),
      );
      if (shareResult.status == ShareResultStatus.unavailable) {
        // ignore: use_build_context_synchronously
        await showSnackBar(context, shareResult.status.message, 3);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Error: $e', 5);
    }
  }

  void _refreshSearch() {
    LoggerService.logDebug('🔄 Обновление поиска...');
    _controller?.reload();
    // _loadMarkdownWithHighlights(_textFromChunks);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Сохраняем ссылку на ScaffoldMessenger при первом построении
    _scaffoldMessenger = ScaffoldMessenger.of(context);
  }

  @override
  void dispose() {
    // Используем сохраненную ссылку, а не context
    _scaffoldMessenger.clearSnackBars();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_snackBarIsProcessing,
      child: Scaffold(
        appBar: AppBar(
          leading: SvgPicture.asset(ImageConstants.igIdocIt, height: 8, width: 8),
          title:
              // MarqueePlus(text: widget.knowledge.docName.split('\n').firstOrNull ?? 'Документ', velocity: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      widget.knowledge.docName.split('\n').firstOrNull ?? 'Документ',
                      maxLines: 2,
                      style: const TextStyle(
                        color: ColorConstants.white500,
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
                child: Center(
                  child: Text('$progress%', style: const TextStyle(fontSize: 14, color: ColorConstants.white500)),
                ),
              ),
          ],
        ),
        body: Stack(
          children: [
            Column(
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

                      Row(
                        children: [
                          IconButton(
                            onPressed: () => _shareAsXFile(context),
                            icon: Icon(Icons.ios_share, color: ColorConstants.white500, size: 30),
                          ),
                          if (_currentUri != null)
                            IconButton(
                              onPressed: () => _handleExternalUrl(context),
                              icon: Icon(Icons.open_in_browser, color: ColorConstants.white500, size: 30),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InAppWebView(
                    initialSettings: InAppWebViewSettings(
                      javaScriptEnabled: true,
                      useShouldOverrideUrlLoading: true,
                      mediaPlaybackRequiresUserGesture: false,
                      transparentBackground: false,
                    ),

                    onWebViewCreated: (controller) async {
                      _controller = controller;

                      // JS Bridge
                      controller.addJavaScriptHandler(
                        handlerName: 'FlutterChannel',
                        callback: (args) {
                          try {
                            final data = args.first;
                            LoggerService.logDebug("JS message: $data");
                          } catch (e) {
                            LoggerService.logDebug("JS error: $e");
                          }
                          return null;
                        },
                      );

                      // грузим HTML после создания
                      await controller.loadData(data: _htmlPage, mimeType: "text/html", encoding: "utf-8");
                    },

                    shouldOverrideUrlLoading: (controller, navigationAction) async {
                      final uri = navigationAction.request.url;
                      if (uri.isBlank) {
                        return NavigationActionPolicy.ALLOW;
                      }
                      setState(() {
                        _currentUri = uri;
                      });

                      if (navigationAction.shouldPerformDownload == true) {
                        return NavigationActionPolicy.DOWNLOAD;
                      }

                      return NavigationActionPolicy.ALLOW;
                    },

                    onLoadStart: (controller, url) {
                      setState(() => _isLoading = true);
                    },

                    onLoadStop: (controller, url) async {
                      setState(() {
                        _currentUri = url.isBlank ? _docLink : url;
                      });

                      controller.canGoBack().then((canGoBack) {
                        setState(() {
                          this.canGoBack = canGoBack;
                        });
                      });
                      controller.canGoForward().then((canGoForward) {
                        setState(() {
                          this.canGoForward = canGoForward;
                        });
                      });
                      setState(() {
                        _isLoading = false;
                      });
                    },

                    onProgressChanged: (controller, p) {
                      setState(() => progress = p);
                    },

                    onConsoleMessage: (controller, msg) {
                      LoggerService.logDebug("Console: ${msg.message}");
                    },

                    onReceivedError: (controller, request, error) async => await showSnackBar(
                      context,
                      "onReceivedError: ${error.type.toString()}  ${error.description}",
                      5,
                    ),

                    onReceivedHttpError: (controller, request, error) async =>
                        await showSnackBar(context, "onReceivedError: ${error.statusCode}  ${error.toString()}", 5),
                  ),
                ),
              ],
            ),

            // Loader
            if (_isLoading)
              Container(
                color: ColorConstants.white500,
                child: const Center(child: IdocItLoadingIndicator(size: 40.0, color: ColorConstants.loading)),
              ),

            // Progress bar
            if (progress < 100) LinearProgressIndicator(value: progress / 100),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (canGoBack)
              AnimatedOpacity(
                opacity: canGoBack ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: "goback",
                    onPressed: () async => await _controller?.goBack(),
                    tooltip: 'Навигация назад',
                    backgroundColor: ColorConstants.loading.withValues(alpha: 0.4),
                    child: const Icon(Icons.arrow_back_ios_new, color: ColorConstants.black350),
                  ),
                ),
              ),
            if (canGoForward)
              AnimatedOpacity(
                opacity: canGoForward ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: "goforward",
                    onPressed: () async => await _controller?.goForward(),
                    tooltip: 'Навигация вперёд',
                    backgroundColor: ColorConstants.loading.withValues(alpha: 0.4),
                    child: const Icon(Icons.arrow_forward_ios, color: ColorConstants.black350),
                  ),
                ),
              ),
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 500),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "refresh",
                  onPressed: _refreshSearch,
                  tooltip: 'Обновить поиск',
                  backgroundColor: ColorConstants.loading.withValues(alpha: 0.4),
                  child: const Icon(Icons.refresh, color: ColorConstants.black350),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension _ShareResultStatusString on ShareResultStatus {
  String get message => switch (this) {
    ShareResultStatus.success => 'Успешно',
    ShareResultStatus.dismissed => 'Отмена',
    ShareResultStatus.unavailable => 'Недоступно',
  };
}

extension _WebUriBlank on WebUri? {
  static String blank = 'about:blank';
  bool get isBlank => this == null || toString() == blank;
}
