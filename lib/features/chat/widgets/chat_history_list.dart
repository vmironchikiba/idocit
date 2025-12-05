import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/models/enums/role.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatHistoryList extends StatelessWidget {
  final List<ChatHistoryMessage> messages;

  const ChatHistoryList({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: messages.map((historyItem) {
        final role = historyItem.role.toRole();
        final color = role == Role.user
            ? ColorConstants.black300
            : role == Role.assistant
            ? ColorConstants.white500
            : ColorConstants.red400;

        return Card(
          color: color,
          child: ListTile(
            leading: role == Role.user
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageConstants.userChatAvatarSvg, height: 21, width: 21),
                      Text(
                        'You',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorConstants.black500, fontSize: 12, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                : role == Role.assistant
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageConstants.igIdocIt, height: 21, width: 21),
                      Text(
                        'iDocIt\nAI',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorConstants.black500, fontSize: 12, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                : null,
            title: Text(
              historyItem.content,
              style: TextStyle(color: role == Role.user ? ColorConstants.white500 : ColorConstants.black500),
            ),
          ),
        );
      }).toList(),
    );
  }
}
