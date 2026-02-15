import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:markdown/markdown.dart' as md;

class MultilineHighlightBuilder extends MarkdownElementBuilder {
  final Map<String, Color> _colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'black': Colors.black,
    'white': Colors.white,
    'grey': Colors.grey,
    'lightblue': Colors.blue.shade100,
    'lightgreen': Colors.green.shade100,
    'lightyellow': Colors.yellow.shade100,
    'lightred': Colors.red.shade100,
  };

  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    LoggerService.logDebug('Билдер вызван для тега: ${element.tag}, текст: "${element.textContent}"');

    final text = element.textContent;
    final colorAttr = element.attributes['color'];
    final bgAttr = element.attributes['bg'] ?? element.attributes['background'];

    final textColor = _parseColor(colorAttr) ?? parentStyle?.color ?? Colors.black;
    final bgColor = _parseColor(bgAttr) ?? Colors.yellow.shade100;

    // ОБРАБОТКА ОДНОСТРОЧНЫХ тегов (tag = 'highlight')
    if (element.tag == 'highlight') {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: preferredStyle?.fontSize ?? 16),
        ),
      );
    }

    // ОБРАБОТКА МНОГОСТРОЧНЫХ тегов (tag = 'highlight_line')
    final isFirst = element.attributes['first'] == 'true';
    final isLast = element.attributes['last'] == 'true';
    final isMiddle = element.attributes['middle'] == 'true';

    return Container(
      padding: EdgeInsets.only(left: 4, right: 4, top: isFirst ? 2 : 1, bottom: isLast ? 2 : 1),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.only(
          topLeft: isFirst ? const Radius.circular(4) : Radius.zero,
          topRight: isFirst ? const Radius.circular(4) : Radius.zero,
          bottomLeft: isLast ? const Radius.circular(4) : Radius.zero,
          bottomRight: isLast ? const Radius.circular(4) : Radius.zero,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: preferredStyle?.fontSize ?? 16),
      ),
    );
  }

  Color? _parseColor(String? colorName) {
    if (colorName == null || colorName.isEmpty) return null;

    if (_colorMap.containsKey(colorName.toLowerCase())) {
      return _colorMap[colorName.toLowerCase()];
    }

    try {
      if (colorName.startsWith('#')) {
        return Color(int.parse(colorName.replaceAll('#', '0xFF')));
      }
      if (colorName.startsWith('0x')) {
        return Color(int.parse(colorName));
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}
