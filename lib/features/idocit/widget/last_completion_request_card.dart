import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';

class LastCompletionRequestCard extends StatelessWidget {
  final String text;

  const LastCompletionRequestCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.black200,
      child: ListTile(
        leading: SvgPicture.asset(ImageConstants.userChatAvatarSvg),
        title: Text(text, style: const TextStyle(color: ColorConstants.white500)),
      ),
    );
  }
}
