import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';

class IdocItLoadingIndicator extends StatefulWidget {
  final double size;
  final Color? color;

  const IdocItLoadingIndicator({Key? key, this.size = 20.0, this.color}) : super(key: key);

  @override
  State<IdocItLoadingIndicator> createState() => _IdocItLoadingIndicatorState();
}

class _IdocItLoadingIndicatorState extends State<IdocItLoadingIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(angle: _controller.value * 2 * math.pi, child: child);
      },
      child: SizedBox.square(
        dimension: widget.size,
        child: Image.asset(ImageConstants.icLoading, color: widget.color ?? ColorConstants.green500),
      ),
    );
  }
}
