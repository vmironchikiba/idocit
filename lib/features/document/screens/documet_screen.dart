import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/pages/markdown_web_view_page.dart';
import 'package:idocit/features/document/pages/web_view_page.dart';
import 'package:idocit/injection_container.dart';
import 'package:idocit/idocit/lib/api.dart';

class DocumentScreen extends StatefulWidget {
  final KnowledgeData knowledge;
  const DocumentScreen({super.key, required this.knowledge});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final String docType =
      locator<DocumentBloc>().state.documentResponse?.document.properties.docType ?? 'Unknown Document Type';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (docType == 'MD Format')
        ? MarkdownWebViewPage(knowledge: widget.knowledge)
        : docType == 'WEB documents'
        ? WebViewPage(knowledge: widget.knowledge)
        : Scaffold(
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

            body: Text('Unknown Format'),
          );
  }
}
