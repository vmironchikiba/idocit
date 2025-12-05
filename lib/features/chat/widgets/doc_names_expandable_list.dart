import 'package:flutter/material.dart';
import 'package:idocit/common/widgets/inline_expandable_list.dart';
import 'package:idocit/features/chat/domain/models/query_response.dart';

class DocNamesExpandableList extends StatelessWidget {
  // final List<String> docNames;
  final List<KnowledgeData> docNames;

  const DocNamesExpandableList({super.key, required this.docNames});

  @override
  Widget build(BuildContext context) {
    if (docNames.isEmpty) return const SizedBox.shrink();

    return InlineExpandableList(items: docNames, onItemTap: (_) {});
  }
}
