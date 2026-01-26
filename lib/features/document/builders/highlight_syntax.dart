// highlight_syntax.dart
import 'package:markdown/markdown.dart' as md;

/// Синтаксис для обычных однострочных highlight тегов
class HighlightSyntax extends md.InlineSyntax {
  HighlightSyntax() : super(r'\[\[highlight([^\]]*)\]\](.*?)\[\[/highlight\]\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final attributesStr = match.group(1)?.trim() ?? '';
    final content = match.group(2) ?? '';

    final attributes = <String, String>{};
    final attrPattern = RegExp(r'(\w+)="([^"]*)"');
    for (final attrMatch in attrPattern.allMatches(attributesStr)) {
      attributes[attrMatch.group(1)!] = attrMatch.group(2)!;
    }

    final element = md.Element('highlight', [md.Text(content)]);
    element.attributes.addAll(attributes);

    parser.addNode(element);

    return true;
  }
}
