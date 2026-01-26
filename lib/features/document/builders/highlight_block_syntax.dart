import 'package:markdown/markdown.dart' as md;

/// Кастомный синтаксис для тега [[highlight]]
class HighlightBlockSyntax extends md.BlockSyntax {
  @override
  RegExp get pattern => RegExp(r'^\[\[highlight(\s+[^\]]*)?\]\]\s*$');

  @override
  bool canEndBlock(md.BlockParser parser) {
    return parser.current.content.trim() == '[[/highlight]]';
  }

  @override
  md.Node? parse(md.BlockParser parser) {
    // 1. Получаем строку с открывающим тегом и атрибутами
    final match = pattern.firstMatch(parser.current.content)!;
    final attributesStr = match.group(1)?.trim() ?? '';

    // 2. Парсим атрибуты (color="red" bg="yellow")
    final attributes = <String, String>{};
    final attrPattern = RegExp(r'(\w+)="([^"]*)"');
    for (final attrMatch in attrPattern.allMatches(attributesStr)) {
      attributes[attrMatch.group(1)!] = attrMatch.group(2)!;
    }

    // 3. Пропускаем строку с открывающим тегом
    parser.advance();

    // 4. Собираем все строки до закрывающего тега
    final lines = <String>[];
    while (!parser.isDone && !canEndBlock(parser)) {
      lines.add(parser.current.content);
      parser.advance();
    }

    // 5. Пропускаем закрывающий тег
    if (!parser.isDone && canEndBlock(parser)) {
      parser.advance();
    }

    // 6. Создаём элемент с тегом 'highlight'
    final content = lines.join('\n');
    final element = md.Element('highlight', [md.Text(content)]);
    element.attributes.addAll(attributes);

    return element;
  }
}
