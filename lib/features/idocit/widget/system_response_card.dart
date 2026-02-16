import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';

class SystemResponseCard extends StatelessWidget {
  final String message;

  const SystemResponseCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: ColorConstants.blue500.withValues(alpha: 0.1),
      child: ListTile(
        title: Row(
          children: [
            SvgPicture.asset(ImageConstants.igIdocIt, height: 24, width: 24),
            SizedBox(width: 20),
            Text(
              'IdocIt AI',
              style: const TextStyle(color: ColorConstants.black500, fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        subtitle: ListTile(
          title: Text(message, style: const TextStyle(color: ColorConstants.black400)),
        ),
      ),
    );
  }
}
