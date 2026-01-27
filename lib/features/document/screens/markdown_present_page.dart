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

  // Ключи для прокрутки
  final GlobalKey _markdownKey = GlobalKey();
  final GlobalKey _firstHighlightKey = GlobalKey();

  // Билдер как поле класса, чтобы сохранять состояние
  late _HighlightBuilderWithScroll _sharedBuilder;

  @override
  void initState() {
    super.initState();
    // Создаем билдер один раз
    _sharedBuilder = _HighlightBuilderWithScroll(
      firstHighlightKey: _firstHighlightKey,
      onFirstHighlightFound: _scrollAfterBuild,
    );

    // Initialize with original data
    _displayedMarkdownData = _originalMarkdownData;
    _onSearchChanged();
  }

  // ✅ Метод для прокрутки после построения виджетов
  void _scrollAfterBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Даем виджетам время построиться
      Future.delayed(const Duration(milliseconds: 50), () {
        _scrollToFirstHighlight();
      });
    });
  }

  // ✅ Упрощенная прокрутка с повторными попытками
  void _scrollToFirstHighlight({int retryCount = 0}) {
    if (_firstHighlightKey.currentContext != null) {
      print('✅ Контекст найден, прокручиваем... (попытка ${retryCount + 1})');
      try {
        Scrollable.ensureVisible(
          _firstHighlightKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
      } catch (e) {
        print('⚠️ Ошибка при прокрутке: $e');
      }
    } else {
      print('⚠️ Контекст еще null (попытка ${retryCount + 1})');

      // Пробуем снова до 3 раз с увеличивающейся задержкой
      if (retryCount < 3) {
        Future.delayed(Duration(milliseconds: 100 * (retryCount + 1)), () {
          _scrollToFirstHighlight(retryCount: retryCount + 1);
        });
      } else {
        print('❌ Не удалось найти контекст после 3 попыток');

        // Альтернативный способ: пытаемся прокрутить вручную через RenderObject
        _tryAlternativeScroll();
      }
    }
  }

  // ✅ Альтернативный способ прокрутки
  void _tryAlternativeScroll() {
    final context = _markdownKey.currentContext;
    if (context == null) {
      print('❌ markdownKey тоже не имеет контекста');
      return;
    }

    // Ищем Scrollable в дереве
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable != null) {
      print('✅ Найден Scrollable, пытаемся прокрутить в начало...');
      scrollable.position.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
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
        key: _markdownKey, // ✅ Ключ на самом Markdown виджете
        data: _displayedMarkdownData,
        extensionSet: md.ExtensionSet(
          <md.BlockSyntax>[...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
          <md.InlineSyntax>[
            HighlightSyntax(), // ДЛЯ ОДНОСТРОЧНЫХ тегов [[highlight]]
            HighlightLineSyntax(), // ДЛЯ МНОГОСТРОЧНЫХ тегов [[highlight_line]]
            ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes,
          ],
        ),
        builders: {'highlight': _sharedBuilder, 'highlight_line': _sharedBuilder},
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          p: const TextStyle(fontSize: 16, height: 1.5),
          h1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
          h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey[700]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('=== РУЧНАЯ ПРОВЕРКА ===');
          print('Ключ firstHighlightKey: $_firstHighlightKey');
          print('Контекст: ${_firstHighlightKey.currentContext}');
          print('Markdown ключ: $_markdownKey');
          print('Markdown контекст: ${_markdownKey.currentContext}');
          _scrollToFirstHighlight();
        },
        tooltip: 'К первому выделенному тексту',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}

// ✅ Улучшенный билдер с управлением состоянием
class _HighlightBuilderWithScroll extends MarkdownElementBuilder {
  final GlobalKey firstHighlightKey;
  final VoidCallback onFirstHighlightFound;

  bool _firstKeyAdded = false;
  int _processedCount = 0;

  _HighlightBuilderWithScroll({required this.firstHighlightKey, required this.onFirstHighlightFound});

  // ✅ Метод для сброса состояния
  void reset() {
    _firstKeyAdded = false;
    _processedCount = 0;
    print('🧹 Билдер сброшен, готов к новому поиску');
  }

  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    _processedCount++;
    final text = element.textContent;
    final colorAttr = element.attributes['color'];
    final bgAttr = element.attributes['bg'] ?? element.attributes['background'];

    final textColor = _parseColor(colorAttr) ?? Colors.black;
    final bgColor = _parseColor(bgAttr) ?? Colors.yellow.shade100;

    print(
      '   📍 Билдер обрабатывает тег #$_processedCount: "${text.substring(0, text.length < 30 ? text.length : 30)}${text.length > 30 ? '...' : ''}"',
    );

    // ✅ Добавляем ключ ТОЛЬКО к первому тегу
    if (!_firstKeyAdded) {
      _firstKeyAdded = true;
      print('   🔑 Добавляем GlobalKey к первому тегу');

      // ✅ Создаем виджет с ключом
      final widgetWithKey = Container(
        key: firstHighlightKey, // ✅ Ключ здесь!
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
              child: const Icon(Icons.arrow_downward, color: Colors.white, size: 12),
            ),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: preferredStyle?.fontSize ?? 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

      // ✅ Вызываем прокрутку после небольшой задержки
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('   🎯 Первый тег построен, вызываем прокрутку');
        print(
          '   Состояние ключа после построения: ${firstHighlightKey.currentContext != null ? "Есть контекст" : "Нет контекста"}',
        );
        onFirstHighlightFound();
      });

      return widgetWithKey;
    }

    // Обычные теги без ключа
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(4)),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: preferredStyle?.fontSize ?? 16),
      ),
    );
  }

  Color? _parseColor(String? colorName) {
    if (colorName == null || colorName.isEmpty) return null;

    final colors = {
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

    final lowerName = colorName.toLowerCase();
    if (colors.containsKey(lowerName)) {
      return colors[lowerName];
    }

    try {
      if (lowerName.startsWith('#')) {
        return Color(int.parse(lowerName.replaceAll('#', '0xFF')));
      }
      if (lowerName.startsWith('0x')) {
        return Color(int.parse(lowerName));
      }
    } catch (e) {
      return null;
    }

    return null;
  }
}
