import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/models/enums/role.dart';
import 'package:idocit/features/chat/domain/models/extensions/percent_string.dart';
import 'package:idocit/features/document/screens/documet_screen.dart';
import 'package:idocit/features/document/screens/markdown_earch_page.dart';
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
        final categories = historyItem.knowledgeRetrieval?.knowledge?.categories ?? [];
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
                        style: TextStyle(color: ColorConstants.black500, fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                : null,
            title: Text(
              historyItem.content,
              style: TextStyle(color: role == Role.user ? ColorConstants.white500 : ColorConstants.black500),
            ),
            subtitle: Column(
              children: categories
                  .map(
                    (category) => ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(category.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(height: 4.0),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), color: Colors.orange),
                            padding: EdgeInsets.all(3.0),
                            child: Text(
                              category.type.capitalize(),
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: category.knowledgeData
                            .map(
                              (knowledge) => Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (_) => MarkdownSearchPage(),
                                          //DocumentScreen(documentId: knowledge.docUuid),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      knowledge.text,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: ColorConstants.black500),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}
