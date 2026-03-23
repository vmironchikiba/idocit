import 'package:flutter/material.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/idocit/widget/inline_expandable_list.dart';
import 'package:idocit/idocit/lib/api.dart';

class DocNamesExpandableList extends StatelessWidget {
  final List<KnowledgeData> docNames;

  const DocNamesExpandableList({super.key, required this.docNames});

  @override
  Widget build(BuildContext context) {
    if (docNames.isEmpty) return const SizedBox.shrink();

    return InlineExpandableList(
      items: docNames,
      onItemTap: (udid, _) {
        LoggerService.logDebug(udid);
      },
    );
  }
}
