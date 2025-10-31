import 'package:flutter/material.dart';

class IdocItText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;

  /// Flutter engine does not support text vertical alignment.
  /// Right now we need to implement our custom solution.
  final bool isVerticalCentered;

  const IdocItText({
    Key? key,
    required this.text,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 10,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.textScaleFactor,
    this.isVerticalCentered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isVerticalCentered) {
      return Text(
        text,
        key: key,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );
    }

    final height = style?.height ?? Theme.of(context).textTheme.bodyLarge?.height ?? 1.0;
    final textSize = style?.fontSize ?? Theme.of(context).textTheme.bodyLarge?.fontSize ?? 14.0;
    final bottomPadding = (height * textSize - textSize) / 2.0;
    final baseline = height * textSize - height * textSize / 4.0;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Baseline(
        baselineType: TextBaseline.alphabetic,
        baseline: baseline,
        child: Text(
          text,
          key: key,
          style: style,
          strutStyle: strutStyle,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        ),
      ),
    );
  }
}

class IdocItRichText extends StatelessWidget {
  final InlineSpan span;
  final TextAlign textAlign;
  final TextDirection? textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;

  const IdocItRichText({
    Key? key,
    required this.span,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 10,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
    this.textScaleFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      span,
      key: key,
      textAlign: textAlign,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor ?? MediaQuery.of(context).textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior:
          textHeightBehavior ?? const TextHeightBehavior(leadingDistribution: TextLeadingDistribution.even),
    );
  }
}
