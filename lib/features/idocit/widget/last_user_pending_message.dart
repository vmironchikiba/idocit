import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';

class LastUserPendingMessage extends StatelessWidget {
  final String text;

  const LastUserPendingMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.blue500.withValues(alpha: 0.1),
      child: ListTile(
        title: Text(text, style: const TextStyle(color: ColorConstants.blue500)),
      ),
    );
  }
}

class LastUserPendingArray extends StatelessWidget {
  final List<String> preMessageArray;

  const LastUserPendingArray({super.key, required this.preMessageArray});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: ColorConstants.blue500.withValues(alpha: 0.1),
      color: ColorConstants.white500,
      child: ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(ImageConstants.igIdocIt, height: 24, width: 24),
                SizedBox(width: 20),
                Text(
                  'IdocIt AI',
                  style: const TextStyle(color: ColorConstants.black500, fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            IdocItLoadingIndicator(size: 30.0),
          ],
        ),
        subtitle: Column(
          children: preMessageArray
              .map(
                (text) => ListTile(
                  leading: Icon(Icons.circle_outlined, size: 20.0, color: ColorConstants.black400),
                  title: Text(text, style: const TextStyle(color: ColorConstants.black400)),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
