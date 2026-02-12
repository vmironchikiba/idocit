import 'package:flutter/material.dart';
import 'package:idocit/constants/style.dart';

class IdocItOpacityWrapper extends StatelessWidget {
  final bool isOpaque;
  final double opacity;
  final Widget child;

  const IdocItOpacityWrapper({super.key, required this.isOpaque, this.opacity = 0.5, required this.child})
    : assert(opacity >= 0.0 && opacity <= 1.0);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: StyleConstants.defaultAnimationDuration,
      opacity: isOpaque ? opacity : 1.0,
      child: child,
    );
  }
}
