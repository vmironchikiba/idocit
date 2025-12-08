import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/models/extensions/percent_string.dart';
import 'package:idocit/features/chat/domain/models/query_response.dart';

class InlineExpandableList extends StatefulWidget {
  // final List<String> items;
  final List<KnowledgeData> items;
  final ValueChanged<int>? onItemTap;

  const InlineExpandableList({super.key, required this.items, this.onItemTap});

  @override
  _InlineExpandableListState createState() => _InlineExpandableListState();
}

class _InlineExpandableListState extends State<InlineExpandableList> with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();
    // final total = widget.items.map((item) => double.tryParse(item.score) ?? 0).reduce((a, b) => a + b).toString();

    final header = ListTile(
      leading: Column(
        children: [
          SvgPicture.asset(ImageConstants.igIdocIt, height: 21, width: 21),
          SizedBox(height: 4.0),
          Container(
            // color: widget.items[0].score.toColor(),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: widget.items[0].score.toColor()),
            padding: EdgeInsets.all(3.0),
            child: Text(
              widget.items[0].score.toPercent(),
              style: TextStyle(color: ColorConstants.black500, fontSize: 12, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
      title: Card(
        elevation: 0,
        color: ColorConstants.white500.withValues(alpha: 1),
        child: Text(
          widget.items[0].text,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: ColorConstants.black500),
        ),
      ),
      trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
      onTap: () => setState(() => _expanded = !_expanded),
    );

    final rest = Column(
      children: List.generate(
        widget.items.length - 1,
        (i) => ListTile(
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
          title: Card(
            elevation: 0,
            color: ColorConstants.white500.withValues(alpha: 1),
            child: Text(
              widget.items[i + 1].text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: ColorConstants.black500),
            ),
          ),
          onTap: () {
            widget.onItemTap?.call(i + 1);
            // если нужно — закрывать после выбора:
            setState(() => _expanded = false);
          },
        ),
      ),
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
