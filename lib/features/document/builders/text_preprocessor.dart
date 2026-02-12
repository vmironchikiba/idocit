import 'package:markdown/markdown.dart' as md;

// /// Предварительно обрабатывает текст, чтобы сделать многострочные теги обрабатываемыми
// String preprocessMultilineHighlights(String text) {
//   // Регулярное выражение для нахождения многострочных highlight тегов
//   final regex = RegExp(r'(\[\[highlight([^\]]*)\]\]([\s\S]*?)\[\[/highlight\]\])');

//   return text.replaceAllMapped(regex, (match) {
//     final fullTag = match.group(1)!;
//     final attrs = match.group(2)?.trim() ?? '';
//     final content = match.group(3)!;

//     // Разбиваем содержимое на строки
//     final lines = content.split('\n');

//     // Если текст однострочный - оставляем как есть
//     if (lines.length <= 1) {
//       return fullTag;
//     }

//     // Для многострочного контента преобразуем его в формат, понятный Markdown
//     // Обернём каждую строку в отдельный тег и добавим маркеры для последующей обработки

//     final buffer = StringBuffer();

//     for (int i = 0; i < lines.length; i++) {
//       final line = lines[i];

//       if (i == 0) {
//         // Первая строка - оставляем тег как есть, но делаем её отдельным элементом
//         buffer.write('[[highlight_line$attrs first="true"]]$line[[/highlight_line]]');
//       } else if (i == lines.length - 1) {
//         // Последняя строка - отмечаем как последнюю
//         buffer.write('\n[[highlight_line$attrs last="true"]]$line[[/highlight_line]]');
//       } else {
//         // Промежуточные строки
//         buffer.write('\n[[highlight_line$attrs middle="true"]]$line[[/highlight_line]]');
//       }
//     }

//     return buffer.toString();
//   });
// }

/// Предварительно обрабатывает текст, разделяя однострочные и многострочные теги
String preprocessMultilineHighlights(String text) {
  // Регулярное выражение для нахождения highlight тегов с их содержимым
  final regex = RegExp(r'(\[\[highlight([^\]]*)\]\]([\s\S]*?)\[\[/highlight\]\])');

  return text.replaceAllMapped(regex, (match) {
    final fullTag = match.group(1)!;
    final attrs = match.group(2)?.trim() ?? '';
    final content = match.group(3)!;

    // Проверяем, содержит ли контент переносы строк
    final lines = content.split('\n');

    // Если однострочный - оставляем как есть
    if (lines.length <= 1) {
      return fullTag;
    }

    // Многострочный - преобразуем
    final buffer = StringBuffer();

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (i == 0) {
        buffer.write('[[highlight_line$attrs first="true"]]$line[[/highlight_line]]');
      } else if (i == lines.length - 1) {
        buffer.write('\n[[highlight_line$attrs last="true"]]$line[[/highlight_line]]');
      } else {
        buffer.write('\n[[highlight_line$attrs middle="true"]]$line[[/highlight_line]]');
      }
    }

    return buffer.toString();
  });
}

/// Восстанавливает оригинальный формат после обработки
String postprocessHighlightedText(String text) {
  // Эта функция может быть использована, если нужно восстановить оригинальный формат
  // для сохранения или других операций
  return text;
}
