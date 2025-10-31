import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/sizes.dart';

class IdocItIconButton extends StatelessWidget {
  final String iconSrc;
  final VoidCallback callback;
  final Color iconColor;

  const IdocItIconButton({
    super.key,
    required this.iconSrc,
    required this.callback,
    this.iconColor = ColorConstants.greyBlue800,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        maxHeight: SizeConstants.defaultIconSize,
        maxWidth: SizeConstants.defaultIconSize,
      ),
      icon: SvgPicture.asset(iconSrc),
      color: iconColor,
      splashRadius: SizeConstants.defaultIconSize,
      onPressed: callback,
    );
  }
}

class IdocItImageButton extends StatelessWidget {
  final dynamic image;
  final VoidCallback callback;
  final double size;
  final Color iconColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final Color? splashColor;

  const IdocItImageButton({
    super.key,
    required this.image,
    required this.callback,
    this.size = SizeConstants.defaultIconSize,
    this.iconColor = ColorConstants.greyBlue800,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
  }) : assert(image is Image || image is SvgPicture);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      icon: image,
      color: iconColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      splashRadius: size,
      onPressed: callback,
    );
  }
}
