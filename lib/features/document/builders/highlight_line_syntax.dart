// highlight_line_syntax.dart
import 'package:markdown/markdown.dart' as md;

/// Синтаксис для отдельных строк highlight
class HighlightLineSyntax extends md.InlineSyntax {
  HighlightLineSyntax() : super(r'\[\[highlight_line([^\]]*)\]\](.*?)\[\[/highlight_line\]\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final attributesStr = match.group(1)?.trim() ?? '';
    final content = match.group(2) ?? '';

    final attributes = <String, String>{};

    // Парсим оригинальные атрибуты цвета
    final colorPattern = RegExp(r'(color|bg|background)="([^"]*)"');
    for (final attrMatch in colorPattern.allMatches(attributesStr)) {
      attributes[attrMatch.group(1)!] = attrMatch.group(2)!;
    }

    // Парсим дополнительные атрибуты (first, last, middle)
    final metaPattern = RegExp(r'(first|last|middle)="([^"]*)"');
    for (final attrMatch in metaPattern.allMatches(attributesStr)) {
      attributes[attrMatch.group(1)!] = attrMatch.group(2)!;
    }

    final element = md.Element('highlight_line', [md.Text(content)]);
    element.attributes.addAll(attributes);

    parser.addNode(element);

    return true;
  }
}
