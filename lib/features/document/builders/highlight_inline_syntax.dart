import 'package:markdown/markdown.dart' as md;

/// Кастомный INLINE синтаксис для тега [[highlight]]
/// InlineSyntax работает внутри строк, а не как отдельные блоки
class HighlightInlineSyntax extends md.InlineSyntax {
  HighlightInlineSyntax() : super(r'\[\[highlight(?: ([^\]]*))?\]\](.*?)\[\[/highlight\]\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    // 1. Получаем атрибуты и содержимое
    final attributesStr = match.group(1)?.trim() ?? '';
    final content = match.group(2) ?? '';

    // 2. Парсим атрибуты (color="red" bg="yellow")
    final attributes = <String, String>{};
    if (attributesStr.isNotEmpty) {
      final attrPattern = RegExp(r'(\w+)="([^"]*)"');
      for (final attrMatch in attrPattern.allMatches(attributesStr)) {
        attributes[attrMatch.group(1)!] = attrMatch.group(2)!;
      }
    }

    // 3. Создаём элемент с тегом 'highlight'
    final element = md.Element('highlight', [md.Text(content)]);
    element.attributes.addAll(attributes);

    // 4. Добавляем элемент в парсер
    parser.addNode(element);

    // Отладочный вывод (можно убрать после отладки)
    print('HighlightInlineSyntax: Создан элемент с текстом "$content" и атрибутами $attributes');

    return true;
  }
}
