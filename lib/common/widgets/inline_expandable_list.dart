import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';

class InlineExpandableList extends StatefulWidget {
  final List<String> items;
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

    final header = ListTile(
      leading: SvgPicture.asset(ImageConstants.igIdocIt, height: 21, width: 21),
      title: Card(
        elevation: 0,
        color: ColorConstants.white500.withValues(alpha: 1),
        child: Text(
          !_expanded ? widget.items[0].split('\n').first : widget.items[0],
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
          leading: SvgPicture.asset(ImageConstants.igIdocIt, height: 21, width: 21),
          title: Card(
            elevation: 0,
            color: ColorConstants.white500.withValues(alpha: 1),
            child: Text(widget.items[i + 1], style: const TextStyle(color: ColorConstants.black500)),
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
