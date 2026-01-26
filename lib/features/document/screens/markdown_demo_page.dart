import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:idocit/features/document/builders/custom_builders.dart';
import 'package:idocit/features/document/builders/highlight_line_syntax.dart';
import 'package:idocit/features/document/builders/highlight_syntax.dart';
import 'package:idocit/features/document/builders/text_preprocessor.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownDemoPage extends StatefulWidget {
  const MarkdownDemoPage({super.key});

  @override
  State<MarkdownDemoPage> createState() => _MarkdownDemoPageState();
}

class _MarkdownDemoPageState extends State<MarkdownDemoPage> {
  final String _rawText = '''
# Пример сложного многострочного highlight

## Случай 1: Гибридный текст (преобразуется в highlight_line)
Начало текста[[highlight color="blue" bg="lightblue"]]строка 1
строка 2
строка 3[[/highlight]]Конец текста

## Случай 2: Отдельные строки (остаётся как highlight)
Просто [[highlight color="red"]]однострочный текст[[/highlight]] в середине.

## Случай 3: Многострочный блок (преобразуется в highlight_line)
[[highlight bg="yellow"]]
Это
многострочный
блок
[[/highlight]]
''';

  @override
  Widget build(BuildContext context) {
    // Обрабатываем текст перед отображением
    final processedText = preprocessMultilineHighlights(_rawText);

    print('=== Обработанный текст ===');
    print(processedText);
    print('=========================');

    return Scaffold(
      appBar: AppBar(title: const Text('Многострочный Highlight')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Markdown(
                data: processedText,
                extensionSet: md.ExtensionSet(
                  <md.BlockSyntax>[...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
                  <md.InlineSyntax>[
                    HighlightSyntax(), // ДЛЯ ОДНОСТРОЧНЫХ тегов [[highlight]]
                    HighlightLineSyntax(), // ДЛЯ МНОГОСТРОЧНЫХ тегов [[highlight_line]]
                    ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
                  ],
                ),
                builders: {
                  'highlight': MultilineHighlightBuilder(), // Для обычных тегов
                  'highlight_line': MultilineHighlightBuilder(), // Для построчных тегов
                },
                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: const TextStyle(fontSize: 16, height: 1.5),
                  h1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Отладка:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Текст содержит:', style: TextStyle(color: Colors.grey[700], fontSize: 12)),
                  Text(
                    '- Однострочные теги: [[highlight ...]]',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    '- Многострочные теги: [[highlight_line ...]]',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
