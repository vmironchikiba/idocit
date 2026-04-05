import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/models/extensions/percent_string.dart';
import 'package:idocit/features/idocit/widget/knowledge_card.dart';
import 'package:idocit/idocit/lib/api.dart';

class InlineExpandableList extends StatefulWidget {
  // final List<String> items;
  final List<KnowledgeData> items;
  final void Function(String, int) onItemTap;

  const InlineExpandableList({super.key, required this.items, required this.onItemTap});

  @override
  // ignore: library_private_types_in_public_api
  _InlineExpandableListState createState() => _InlineExpandableListState();
}

class _InlineExpandableListState extends State<InlineExpandableList> with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();
    final header = ListTileTheme(
      contentPadding: EdgeInsets.all(4),
      child: ListTile(
        leading: Column(
          children: [
            SvgPicture.asset(ImageConstants.igIdocIt, height: 21, width: 21),
            SizedBox(height: 4.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: widget.items[0].score.toColor(),
              ),
              padding: EdgeInsets.all(3.0),
              child: Text(
                widget.items[0].score.toPercent(),
                style: TextStyle(color: ColorConstants.black500, fontSize: 10, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        subtitle: Card(
          elevation: 0,
          child: KnowledgeCard(
            knowledge: widget.items[0],
            onItemTap: (docUuid) {
              widget.onItemTap(docUuid, 0);
              setState(() => _expanded = false);
            },
          ),
        ),
        trailing: widget.items.length > 1 ? Icon(_expanded ? Icons.expand_less : Icons.expand_more) : null,
        onTap: () => setState(() => _expanded = !_expanded),
      ),
    );

    //KnowledgeCard(knowledge: knowledge)

    final rest = Column(
      children: List.generate(widget.items.length - 1, (i) {
        final data = widget.items[i + 1];
        return ListTileTheme(
          contentPadding: EdgeInsets.all(0),
          child: ListTile(
            leading: Column(
              children: [
                SvgPicture.asset(ImageConstants.igIdocIt, height: 21, width: 21),
                SizedBox(height: 4.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: widget.items[i + 1].score.toColor(),
                  ),
                  padding: EdgeInsets.all(3.0),
                  child: Text(
                    widget.items[i + 1].score.toPercent(),
                    style: TextStyle(color: ColorConstants.black500, fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            subtitle: KnowledgeCard(
              knowledge: data,
              onItemTap: (docUuid) {
                widget.onItemTap(docUuid, i + 1);
                setState(() => _expanded = false);
              },
            ),
          ),
        );
      }),
    );

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          header,
          // Анимируем показ/скрытие
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: ConstrainedBox(
              constraints: _expanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 0),
              child: ClipRect(child: rest),
            ),
          ),
        ],
      ),
    );
  }
}
