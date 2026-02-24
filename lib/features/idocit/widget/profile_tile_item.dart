import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/widgets/divider.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/colors.dart';

class ProfileTileItem extends StatelessWidget {
  final String title;
  final String iconSrc;
  final Function() onTap;
  final bool withTopPadding;

  const ProfileTileItem({
    Key? key,
    required this.title,
    required this.iconSrc,
    required this.onTap,
    this.withTopPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: ColorConstants.transparent,
        child: Column(
          children: [
            if (withTopPadding) const SizedBox(height: 12.0),
            Row(
              children: [
                SizedBox.square(dimension: 24.0, child: SvgPicture.asset(iconSrc)),
                const SizedBox(width: 12.0),
                IdocItText(text: title, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 12.0),
            const IdocItDivider(),
          ],
        ),
      ),
    );
  }
}
