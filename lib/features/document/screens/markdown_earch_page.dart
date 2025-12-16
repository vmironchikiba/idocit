import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:idocit/features/document/screens/markdown_test_moc.dart';

class MarkdownSearchPage extends StatefulWidget {
  const MarkdownSearchPage({super.key});

  @override
  State<MarkdownSearchPage> createState() => _MarkdownSearchPageState();
}

class _MarkdownSearchPageState extends State<MarkdownSearchPage> {
  final String _originalMarkdownData = MarkdownTestMoc.originalMarkdownData;

  String _displayedMarkdownData = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with original data
    _displayedMarkdownData = _originalMarkdownData;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
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
    final query = escapeRegexLiterals(removeFirstTwoLines(MarkdownTestMoc.query)).trim();
    final query1 = escapeRegexLiterals(MarkdownTestMoc.queryString).trim();
    final query2 = MarkdownTestMoc.queryString;
    // _searchController.text;
    if (query.isEmpty) {
      setState(() {
        _displayedMarkdownData = _originalMarkdownData;
      });
      return;
    }

    // Use a regular expression for case-insensitive matching
    final regex = RegExp(query1, caseSensitive: false, dotAll: true, multiLine: true);

    // Replace all occurrences of the query with Markdown bold syntax (**query**)
    // This is the core trick for highlighting within flutter_markdown
    final highlightedData = _originalMarkdownData.replaceAllMapped(regex, (match) {
      return '**${match.group(0)}**';
    });

    setState(() {
      _displayedMarkdownData = highlightedData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Searchable Markdown'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Enter search text...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MarkdownBody(
            data: _displayedMarkdownData,
            selectable: true, // Enables standard text selection (copy/paste)
            styleSheet: MarkdownStyleSheet(
              // Define a custom style for bold text (`strong` tag)
              // to make it look like a highlight
              strong: const TextStyle(
                backgroundColor: Colors.yellow,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Ensure text is visible on yellow bg
              ),
              // Ensure other text styles don't interfere
              p: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
