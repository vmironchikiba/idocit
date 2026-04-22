import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/pages/markdown_web_view_page.dart';
import 'package:idocit/features/document/pages/markdown_in_app_web_view_page.dart';
import 'package:idocit/features/document/pages/web_view_page.dart';
import 'package:idocit/injection_container.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentScreen extends StatefulWidget {
  final KnowledgeData knowledge;
  const DocumentScreen({super.key, required this.knowledge});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final String docType =
      locator<DocumentBloc>().state.documentResponse?.document.properties.docType ?? 'Unknown Document Type';
  final String? docLink = locator<DocumentBloc>().state.documentResponse?.document.properties.docLink;

  Future<void> _openExternal(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget errorScreen(String e) {
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

      body: Text(e),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MarkdownInAppWebViewPage(knowledge: widget.knowledge);
    // (docType == 'MD Format' || docType == 'HTML Documents' || docType == 'WEB documents' || docType == 'Confluence')
    //     ? MarkdownWebViewPage(knowledge: widget.knowledge)
    //     : docType == 'WEB documents' || docType == 'Confluence'
    //     ? WebViewPage(knowledge: widget.knowledge)
    //     : Builder(
    //         builder: (context) {
    //           try {
    //             if (docLink != null) {
    //               WidgetsBinding.instance.addPostFrameCallback((_) {
    //                 _openExternal(docLink!);
    //                 Navigator.pop(context); // чтобы не оставаться на пустом экране
    //               });
    //             }
    //             return const Scaffold(body: Center(child: CircularProgressIndicator()));
    //           } catch (e) {
    //             return errorScreen(e.toString());
    //           }
    //         },
    //       );
    // : Scaffold(
    //     appBar: AppBar(
    //       leading: SvgPicture.asset(ImageConstants.igIdocIt, height: 8, width: 8),
    //       title: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Expanded(
    //             child: Text(
    //               widget.knowledge.docName.split('\n').firstOrNull ?? 'Документ',
    //               style: const TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 14.0,
    //                 overflow: TextOverflow.ellipsis,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),

    //     body: Text('Unknown Format'),
    //   );
  }
}
