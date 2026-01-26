import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:idocit/features/document/builders/custom_builders.dart';
import 'package:idocit/features/document/builders/highlight_line_syntax.dart';
import 'package:idocit/features/document/builders/highlight_syntax.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:idocit/features/document/screens/markdown_test_moc.dart';

class MarkdownPresentPage extends StatefulWidget {
  const MarkdownPresentPage({super.key});

  @override
  State<MarkdownPresentPage> createState() => _MarkdownPresentPageState();
}

class _MarkdownPresentPageState extends State<MarkdownPresentPage> {
  final String _originalMarkdownData = MarkdownTestMoc.originalMarkdownData;

  String _displayedMarkdownData = "";

  @override
  void initState() {
    super.initState();
    // Initialize with original data
    _displayedMarkdownData = _originalMarkdownData;
    _onSearchChanged();
  }

  @override
  void dispose() {
    // _searchController.dispose();
    super.dispose();
  }

  String removeFirstTwoLines(String input) {
    final lines = input.split('\n');

    if (lines.length <= 2) return ''; // nothing left
    return lines.sublist(2).join('\n');
  }

  String escapeRegexLiterals(String? input) {
    final text = input ?? '';
    // Replace non-breaking space
    final replacedNbsp = text.replaceAll('\u00A0', ' ');

    // Escape all regex special characters
    final escaped = replacedNbsp.replaceAllMapped(RegExp(r'([.*+?^${}()|\[\]\\])'), (match) => '\\${match[0]}');

    return escaped;
  }

  String escapeMarkdownLiterals(String? input) {
    return (input ?? '')
        .replaceAll('\u00A0', ' ')
        // escape every unescaped underscore
        .replaceAllMapped(RegExp(r'(?<!\\)_'), (m) => r'\_')
        // escape every unescaped asterisk
        .replaceAllMapped(RegExp(r'(?<!\\)\*'), (m) => r'\*');
  }

  void _onSearchChanged() {
    final query = escapeRegexLiterals(removeFirstTwoLines(MarkdownTestMoc.query));
    // final query1 = escapeRegexLiterals(MarkdownTestMoc.query).trim();
    // _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _displayedMarkdownData = _originalMarkdownData;
      });
      return;
    }

    // Use a regular expression for case-insensitive matching
    final regex = RegExp(query, caseSensitive: false, dotAll: true, multiLine: true);

    // Replace all occurrences of the query with Markdown bold syntax (**query**)
    // This is the core trick for highlighting within flutter_markdown
    final highlightedData = _originalMarkdownData.replaceAllMapped(regex, (match) {
      final group = match.group(0)?.split('\n') ?? [];
      final highlighted = group
          .map((el) => el.isNotEmpty ? '[[highlight color="blue" bg="lightblue"]]$el[[/highlight]]' : el)
          .toList();
      final joined = highlighted.join('\n');

      return joined;
    });

    setState(() {
      _displayedMarkdownData = highlightedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Markdown(
        data: _displayedMarkdownData,
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
    );
  }
}

class ChipBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final color = element.attributes['color'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color == 'red' ? Colors.red.shade100 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(element.textContent, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
