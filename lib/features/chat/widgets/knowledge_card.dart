import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/document/domain/usecases/get_document_by_id.dart';
import 'package:idocit/features/document/screens/markdown_web_view_page.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';

class KnowledgeCard extends StatefulWidget {
  final KnowledgeData knowledge;

  const KnowledgeCard({super.key, required this.knowledge});

  @override
  State<KnowledgeCard> createState() => _KnowledgeCardState();
}

class _KnowledgeCardState extends State<KnowledgeCard> {
  bool _isLoading = false;

  Future<void> _handleTap() async {
    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    try {
      final result = await locator<GetDocumentById>().call(GetDocumentPayload(documentId: widget.knowledge.docUuid));

      if (result.isRight() && mounted) {
        Navigator.push(context, CupertinoPageRoute(builder: (_) => MarkdownWebViewPage(knowledge: widget.knowledge)));
      }
    } finally {
      // Hide loading indicator whether successful or not
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              onPressed: _isLoading ? null : _handleTap,
              child: Text(
                widget.knowledge.text,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: ColorConstants.black500),
              ),
            ),
          ),

          // Loading overlay
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.7),
              child: const Center(child: IdocItLoadingIndicator()),
            ),
        ],
      ),
    );
  }
}
