import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:idocit/features/document/builders/highlight_line_syntax.dart';
import 'package:idocit/features/document/builders/highlight_syntax.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:idocit/features/document/unused/markdown_test_moc.dart';

class CalibrationStats {
  final List<double> measurements = [];
  int successfulCalibrations = 0;

  void addMeasurement(double pixelsPerChar) {
    measurements.add(pixelsPerChar);
    successfulCalibrations++;
    if (measurements.length > 10) measurements.removeAt(0);
  }

  double get average {
    if (measurements.isEmpty) return 0.0;
    return measurements.reduce((a, b) => a + b) / measurements.length;
  }

  double get median {
    if (measurements.isEmpty) return 0.0;
    final sorted = List<double>.from(measurements)..sort();
    final middle = measurements.length ~/ 2;
    return measurements.length % 2 == 1 ? sorted[middle] : (sorted[middle - 1] + sorted[middle]) / 2.0;
  }
}

class MarkdownPresentPage extends StatefulWidget {
  final String docUuid;
  const MarkdownPresentPage({super.key, required this.docUuid});

  @override
  State<MarkdownPresentPage> createState() => _MarkdownPresentPageState();
}

class _MarkdownPresentPageState extends State<MarkdownPresentPage> {
  final String _originalMarkdownData = MarkdownTestMoc.originalMarkdownData;
  String _displayedMarkdownData = "";
  final GlobalKey _markdownKey = GlobalKey();
  final GlobalKey _firstHighlightKey = GlobalKey();
  late ScrollController _scrollController;

  int _firstHighlightTextPosition = -1;
  double _pixelsPerChar = 0.8;
  double _calculatedPixelsPerChar = 0.8;
  bool _needsCalibration = true;
  final CalibrationStats _calibrationStats = CalibrationStats();

  late _HighlightBuilderWithScroll _sharedBuilder;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // ✅ Загружаем калибровку из SharedPreferences
    _loadCalibrationFromPrefs();

    _sharedBuilder = _HighlightBuilderWithScroll(
      firstHighlightKey: _firstHighlightKey,
      onFirstHighlightFound: () {
        Future.delayed(const Duration(milliseconds: 300), () {
          _scrollToFirstHighlight();
        });
      },
    );

    _displayedMarkdownData = _originalMarkdownData;
    _onSearchChanged();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Теперь здесь вычисляем коэффициент с учетом устройства
    // Это безопасно, так как didChangeDependencies вызывается после initState
    // и когда контекст уже доступен
    if (mounted) {
      final mediaQuery = MediaQuery.of(context);
      final devicePixelRatio = mediaQuery.devicePixelRatio;
      final textScaleFactor = mediaQuery.textScaleFactor;

      // Базовый коэффициент, скорректированный под устройство
      _pixelsPerChar = 0.8 * (devicePixelRatio / 2.0) * (1.0 / textScaleFactor);

      // Если у нас нет сохраненного калиброванного коэффициента, используем этот
      if (_needsCalibration) {
        _calculatedPixelsPerChar = _pixelsPerChar;
      }

      print('📱 Параметры устройства:');
      print('   devicePixelRatio: $devicePixelRatio');
      print('   textScaleFactor: $textScaleFactor');
      print('   Начальный коэффициент: $_pixelsPerChar');
    }
  }

  Future<void> _loadCalibrationFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCoefficient = prefs.getDouble('pixels_per_char');
      if (savedCoefficient != null && savedCoefficient > 0) {
        _calculatedPixelsPerChar = savedCoefficient;
        _needsCalibration = false;
        print('📂 Загружен сохраненный коэффициент: $_calculatedPixelsPerChar');
      }
    } catch (e) {
      print('⚠️ Ошибка загрузки калибровки: $e');
    }
  }

  Future<void> _saveCalibrationToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('pixels_per_char', _calculatedPixelsPerChar);
      print('💾 Коэффициент сохранен: $_calculatedPixelsPerChar');
    } catch (e) {
      print('⚠️ Ошибка сохранения калибровки: $e');
    }
  }

  void _autoCalibrateOnSuccess() {
    if (_firstHighlightKey.currentContext != null && _firstHighlightTextPosition > 0) {
      try {
        final renderBox = _firstHighlightKey.currentContext!.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final position = renderBox.localToGlobal(Offset.zero);
          final screenHeight = MediaQuery.of(context).size.height;

          if (position.dy > 0 && position.dy < screenHeight) {
            final newCoefficient = position.dy / _firstHighlightTextPosition;
            _calibrationStats.addMeasurement(newCoefficient);
            _calculatedPixelsPerChar = _calibrationStats.median;
            _needsCalibration = false;
            _saveCalibrationToPrefs();

            print('🎯 Автоматическая калибровка: $_calculatedPixelsPerChar');
            print('   Успешных калибровок: ${_calibrationStats.successfulCalibrations}');
          }
        }
      } catch (e) {
        print('⚠️ Ошибка при автоматической калибровке: $e');
      }
    }
  }

  void _scrollToFirstHighlight() {
    print('🎯 Прокрутка к первому выделению');

    if (_firstHighlightKey.currentContext != null) {
      print('✅ Контекст доступен, используем ensureVisible');
      try {
        _autoCalibrateOnSuccess();

        Scrollable.ensureVisible(
          _firstHighlightKey.currentContext!,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.1,
        );
        return;
      } catch (e) {
        print('⚠️ Ошибка при ensureVisible: $e');
      }
    }

    print('📏 Используем рассчитанную позицию');
    _scrollToCalculatedPosition();
  }

  void _scrollToCalculatedPosition() {
    if (_firstHighlightTextPosition <= 0) {
      _scrollToBeginning();
      return;
    }

    final targetPosition = _calculateSmartPosition(_firstHighlightTextPosition);

    print('📐 Расчет позиции:');
    print('   Позиция в тексте: $_firstHighlightTextPosition');
    print('   Коэффициент: ${_calculatedPixelsPerChar.toStringAsFixed(4)}');
    print('   Целевая позиция: $targetPosition');

    _scrollController.animateTo(targetPosition, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  double _calculateSmartPosition(int textPosition) {
    if (!_scrollController.hasClients) return 0.0;

    final totalLength = _originalMarkdownData.length;
    if (totalLength == 0) return 0.0;

    // 1. Метод коэффициента
    final coefficientPosition = textPosition * (_needsCalibration ? _pixelsPerChar : _calculatedPixelsPerChar);

    // 2. Пропорциональный метод
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      final proportion = textPosition / totalLength;
      final proportionalPosition = proportion * maxScroll;

      // Комбинируем оба метода
      return min(coefficientPosition * 0.5 + proportionalPosition * 0.5, maxScroll);
    }

    return min(coefficientPosition, maxScroll);
  }

  void _scrollToBeginning() {
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  void _resetSearch() {
    _firstHighlightTextPosition = -1;
    _sharedBuilder.reset();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String removeFirstTwoLines(String input) {
    final lines = input.split('\n');
    return lines.length <= 2 ? '' : lines.sublist(2).join('\n');
  }

  String escapeRegexLiterals(String? input) {
    final text = input ?? '';
    final replacedNbsp = text.replaceAll('\u00A0', ' ');
    return replacedNbsp.replaceAllMapped(RegExp(r'([.*+?^${}()|\[\]\\])'), (match) => '\\${match[0]}');
  }

  void _onSearchChanged() {
    _resetSearch();

    final query = escapeRegexLiterals(removeFirstTwoLines(MarkdownTestMoc.query));
    if (query.isEmpty) {
      setState(() => _displayedMarkdownData = _originalMarkdownData);
      return;
    }

    final regex = RegExp(query, caseSensitive: false, dotAll: true, multiLine: true);
    final firstMatch = regex.firstMatch(_originalMarkdownData);
    if (firstMatch != null) {
      _firstHighlightTextPosition = firstMatch.start;
      print('📍 Позиция первого выделения: $_firstHighlightTextPosition');
    }

    final highlightedData = _originalMarkdownData.replaceAllMapped(regex, (match) {
      final group = match.group(0)?.split('\n') ?? [];
      final highlighted = group
          .map((el) => el.isNotEmpty ? '[[highlight color="blue" bg="lightblue"]]$el[[/highlight]]' : el)
          .toList();
      return highlighted.join('\n');
    });

    setState(() => _displayedMarkdownData = highlightedData);
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Внутри build() мы можем безопасно обращаться к MediaQuery и другим InheritedWidgets
    return Scaffold(
      body: Markdown(
        key: _markdownKey,
        data: _displayedMarkdownData,
        controller: _scrollController,
        extensionSet: md.ExtensionSet(
          [...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
          [HighlightSyntax(), HighlightLineSyntax(), ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes],
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
          print('=== СТАТУС ===');
          print('Позиция в тексте: $_firstHighlightTextPosition');
          print('Коэффициент: $_calculatedPixelsPerChar');
          print('Калибровано: ${!_needsCalibration}');
          print('Измерения: ${_calibrationStats.measurements.length}');
          _scrollToFirstHighlight();
        },
        tooltip: 'К первому выделенному тексту',
        child: const Icon(Icons.arrow_downward),
      ),
    );
  }
}

class _HighlightBuilderWithScroll extends MarkdownElementBuilder {
  final GlobalKey firstHighlightKey;
  final VoidCallback onFirstHighlightFound;
  bool _firstKeyAdded = false;
  int _processedCount = 0;

  _HighlightBuilderWithScroll({required this.firstHighlightKey, required this.onFirstHighlightFound});

  void reset() {
    _firstKeyAdded = false;
    _processedCount = 0;
    print('🧹 Билдер сброшен');
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

    if (!_firstKeyAdded) {
      _firstKeyAdded = true;
      final widgetWithKey = Container(
        key: firstHighlightKey,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
              child: const Icon(Icons.arrow_downward, color: Colors.white, size: 12),
            ),
            Flexible(
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

      WidgetsBinding.instance.addPostFrameCallback((_) => onFirstHighlightFound());
      return widgetWithKey;
    }

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
    if (colors.containsKey(lowerName)) return colors[lowerName];
    try {
      if (lowerName.startsWith('#')) return Color(int.parse(lowerName.replaceAll('#', '0xFF')));
      if (lowerName.startsWith('0x')) return Color(int.parse(lowerName));
    } catch (e) {
      return null;
    }
    return null;
  }
}
