import 'package:flutter/material.dart';

class IdocItDivider extends StatelessWidget {
  final double? size, thickness, indent, endIndent;
  final Color? color;

  const IdocItDivider({
    super.key,
    this.size = 1.0,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: size,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color ?? Theme.of(context).dividerTheme.color?.withValues(alpha: 0.5),
    );
  }
}
