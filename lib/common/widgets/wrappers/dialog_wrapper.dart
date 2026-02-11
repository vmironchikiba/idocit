import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/common/widgets/wrappers/opacity_wrapper.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/constants/sizes.dart';

enum DialogWrapperType { webview, none }

class DialogWrapper extends StatelessWidget {
  final Widget child;
  final dynamic title, subtitle;
  final TextStyle? titleStyle, subtitleStyle;
  final EdgeInsets padding, closeButtonPadding;
  final double contentIndent;
  final bool withCloseButton;
  final Function()? onRefresh;
  final bool withPadding;
  final bool isBlocked;
  final bool isHidden;
  final DialogWrapperType type;

  const DialogWrapper({
    Key? key,
    required this.child,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
    this.padding = defaultPadding,
    this.closeButtonPadding = const EdgeInsets.all(12.0),
    this.contentIndent = 32.0,
    this.withCloseButton = false,
    this.onRefresh,
    this.withPadding = true,
    this.isBlocked = false,
    this.isHidden = false,
    this.type = DialogWrapperType.none,
  }) : assert(title is String || title is Widget || title == null),
       assert(subtitle is String || subtitle is Widget || subtitle == null),
       super(key: key);

  static const defaultPadding = EdgeInsets.only(top: 30.0, bottom: 24.0, left: 24.0, right: 24.0);

  Future<bool> _onWillPopCallback() async {
    return false;
  }

  Future<void> _closeButtonHandler(BuildContext context) async {
    FocusScope.of(context).unfocus();
    Navigator.of(context).pop();
  }

  Widget _buildDialogWrapperWidget(BuildContext context) {
    final titleContent = title is Widget
        ? title
        : title is String
        ? IdocItText(
            text: title!,
            style: titleStyle ?? Theme.of(context).dialogTheme.titleTextStyle,
            textAlign: TextAlign.center,
          )
        : null;

    final subtitleContent = subtitle is Widget
        ? subtitle
        : subtitle is String
        ? IdocItText(text: subtitle!, style: subtitleStyle, textAlign: TextAlign.center)
        : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IdocItOpacityWrapper(
          isOpaque: isBlocked,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: padding.top, left: padding.left, right: padding.right),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (titleContent != null)
                      Padding(
                        padding: withCloseButton == (onRefresh != null)
                            ? EdgeInsets.symmetric(horizontal: closeButtonPadding.right)
                            : EdgeInsets.zero,
                        child: titleContent,
                      ),
                    if (titleContent != null && subtitleContent != null) const SizedBox(height: 8.0),
                    if (subtitleContent != null) subtitleContent,
                  ],
                ),
              ),
              if (onRefresh != null)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: closeButtonPadding.top, left: closeButtonPadding.left, bottom: 8.0),
                    child: GestureDetector(
                      onTap: onRefresh,
                      child: SizedBox.square(
                        dimension: SizeConstants.defaultIconSize,
                        child: SvgPicture.asset(
                          type == DialogWrapperType.none ? ImageConstants.icRefresh : ImageConstants.icRefresh,
                        ),
                      ),
                    ),
                  ),
                ),
              if (withCloseButton)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: closeButtonPadding.top, right: closeButtonPadding.right, bottom: 8.0),
                    child: GestureDetector(
                      onTap: () => _closeButtonHandler(context),
                      child: SizedBox.square(
                        dimension: SizeConstants.defaultIconSize,
                        child: SvgPicture.asset(
                          type == DialogWrapperType.none ? ImageConstants.icClose : ImageConstants.icCloseWhite,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: contentIndent),
        Flexible(
          child: Padding(
            padding: withPadding
                ? EdgeInsets.only(bottom: padding.bottom, left: padding.left, right: padding.right)
                : EdgeInsets.zero,
            child: child,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: isBlocked || context.watch<InAppFailureProvider>().isShowing ? _onWillPopCallback : null,
      child: AbsorbPointer(
        absorbing: isBlocked,
        child: AnimatedAlign(
          duration: isHidden ? const Duration(milliseconds: 250) : const Duration(milliseconds: 200),
          alignment: Alignment.center,
          heightFactor: isHidden ? 0.0 : 1.0,
          child: AnimatedOpacity(
            duration: isHidden ? const Duration(milliseconds: 250) : const Duration(milliseconds: 200),
            opacity: isHidden ? 0.0 : 1.0,
            child: ClipRRect(
              borderRadius: type == DialogWrapperType.webview
                  ? const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                  : BorderRadius.zero,
              child: Container(
                color: type == DialogWrapperType.webview ? ColorConstants.white500 : null,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: _buildDialogWrapperWidget(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
