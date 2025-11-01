import 'package:flutter/material.dart';
import 'package:idocit/constants/sizes.dart';

class ContentWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool withAppBar;
  final bool withKeyboardResize;

  const ContentWrapper({
    super.key,
    required this.child,
    this.padding,
    this.withAppBar = false,
    this.withKeyboardResize = true,
  });

  static const EdgeInsets defaultPadding = EdgeInsets.only(top: 10.0, bottom: 24.0, left: 24.0, right: 24.0);

  static EdgeInsets getAdaptivePadding(BuildContext context, {bool withAppBar = false}) {
    if (withAppBar) {
      return ContentWrapper.defaultPadding;
    }

    return ContentWrapper.defaultPadding.copyWith(top: SizeConstants.isSmallDevice(context: context) ? 32.0 : 66.0);
  }

  @override
  Widget build(BuildContext context) {
    final contentPadding = padding != null ? padding! : getAdaptivePadding(context, withAppBar: withAppBar);
    final keyboardInsets = withKeyboardResize ? MediaQuery.of(context).viewInsets.bottom : 0.0;

    return Padding(
      padding: contentPadding.copyWith(bottom: contentPadding.bottom + keyboardInsets),
      child: child,
    );
  }
}
