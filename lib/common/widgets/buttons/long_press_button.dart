import 'package:flutter/material.dart';
import 'package:idocit/constants/colors.dart';

class LongPressButton extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final Color? color;
  final bool isStarted;
  final bool isPresented;

  const LongPressButton({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.color = ColorConstants.white500,
    this.isStarted = false,
    this.isPresented = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 7),
        child: Icon(
          isPresented
              ? isStarted
                    ? Icons.mic_off_outlined
                    : Icons.mic_none
              : Icons.send,
          color: color,
        ),
      ),
    );
  }
}
