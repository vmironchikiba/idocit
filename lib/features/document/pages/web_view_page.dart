import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/dialogs.dart';
import 'package:idocit/common/widgets/dialogs/warning_dialog.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/injection_container.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatefulWidget {
  final KnowledgeData knowledge;
  const WebViewPage({super.key, required this.knowledge});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _webViewController;
  final String docType =
      locator<DocumentBloc>().state.documentResponse?.document.properties.docType ?? 'Unknown Document Type';
  final String _originalHTMLData =
      locator<DocumentBloc>().state.documentResponse?.document.properties.html ?? 'NO HTML';
  final String? _originalText = locator<DocumentBloc>().state.documentResponse?.document.properties.text;
  final String? docLink = locator<DocumentBloc>().state.documentResponse?.document.properties.docLink;
  bool _isLoading = true;

  // final List<SearchMatch> _matches = [];

  Future<void> _openExternal(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  bool _isHtmlPage(Uri uri) {
    final path = uri.path.toLowerCase();
    final link = uri.toString();

    return path.endsWith('.html') || path.endsWith('.htm') || path.isEmpty || path.endsWith('/') || link == docLink;
  }

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            final url = request.url;

            final uri = Uri.parse(url);

            // Если это не обычная веб-страница
            if (!_isHtmlPage(uri)) {
              await _openExternal(url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() => _isLoading = false);
              // if (_currentSearchQuery.isNotEmpty) {
              //   _scrollToFirstMatch();
              // }
            }
          },

          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) async {
            await idocitShowDialog<bool?>(
              IdocItWarningDialog(
                label: 'WebView error',
                description: error.description,
                // iconSrc: _inAppFailureProvider.iconSrc,
                buttonText: 'OK',
                // buttonCallback: _onTryAgainHandler,
              ),
            );
            LoggerService.logDebug('WebView error: ${error.description}');
          },
        ),
      );
    _loadHtmlToWebView(_originalHTMLData).then((_) {
      LoggerService.logDebug('DONE');
    });
  }

  Future<void> _loadHtmlToWebView(String htmlContent, {bool hasHighlights = false}) async {
    await _webViewController.loadHtmlString(htmlContent, baseUrl: docLink);
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
      ),

      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Container(
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
    );
  }
}
