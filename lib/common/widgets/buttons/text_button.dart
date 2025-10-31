import 'package:flutter/material.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/sizes.dart';
import 'package:idocit/constants/style.dart';

enum IdocItButtonType { scaffold, dialog }

class IdocItTextButton extends StatelessWidget {
  final String contentText;
  final Widget? contentWidget;
  final VoidCallback callback;
  final double height;
  final double? width;
  final EdgeInsets? labelPadding;
  final String? progressLabel;
  final TextStyle? textStyle;
  final bool isSlim;
  final bool isBlocked;
  final bool withProgress;
  final bool withShadow;
  final IdocItButtonType type;

  const IdocItTextButton({
    Key? key,
    this.contentText = 'Button',
    this.contentWidget,
    required this.callback,
    this.height = SizeConstants.defaultButtonHeight,
    this.width,
    this.labelPadding = const EdgeInsets.symmetric(
      vertical: SizeConstants.defaultPadding * 0.5,
      horizontal: SizeConstants.defaultPadding,
    ),
    this.progressLabel,
    this.textStyle,
    this.isSlim = false,
    this.isBlocked = false,
    this.withProgress = false,
    this.withShadow = true,
    this.type = IdocItButtonType.scaffold,
  }) : super(key: key);

  Color? _getButtonColor(BuildContext context) {
    if (isBlocked && type == IdocItButtonType.scaffold) {
      return ColorConstants.black400;
    }

    if (isBlocked && type == IdocItButtonType.dialog) {
      return ColorConstants.black500;
    }

    return null;
  }

  Widget _buildContentWidget(BuildContext context) {
    final buttonTextStyle =
        textStyle ??
        Theme.of(
          context,
        ).textTheme.displayMedium?.copyWith(color: isBlocked ? ColorConstants.black300 : ColorConstants.white500);

    return contentWidget ??
        IdocItText(text: contentText, maxLines: 1, style: buttonTextStyle, isVerticalCentered: false);
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isBlocked,
      child: Container(
        height: height,
        width: isSlim ? null : width ?? double.maxFinite,
        decoration: BoxDecoration(
          color: _getButtonColor(context),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          boxShadow: [
            if (!isBlocked && withShadow)
              BoxShadow(
                color: const Color(0xFF00454F).withOpacity(0.5),
                offset: const Offset(0.0, 4.0),
                blurRadius: 12.0,
              ),
          ],
          gradient: isBlocked
              ? null
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorConstants.gradientVertical.first, ColorConstants.gradientVertical.last],
                ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: TextButton(
            onPressed: callback,
            style: TextButton.styleFrom(padding: labelPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(child: _buildContentWidget(context)),
                AnimatedOpacity(
                  duration: StyleConstants.defaultAnimationDuration,
                  opacity: withProgress ? 1.0 : 0.0,
                  child: AnimatedContainer(
                    duration: StyleConstants.defaultAnimationDuration,
                    width: withProgress ? 20.0 : 0.0,
                    margin: EdgeInsets.only(left: withProgress ? 8.0 : 0.0),
                    child: IdocItLoadingIndicator(color: isBlocked ? ColorConstants.black300 : ColorConstants.white500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
