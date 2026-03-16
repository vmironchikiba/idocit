import 'package:flutter/material.dart';
import 'package:idocit/constants/colors.dart';

class LongPressButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final Color? color;

  const LongPressButton({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.color = ColorConstants.white500,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: Icon(Icons.send, color: color),
    );
  }
}
