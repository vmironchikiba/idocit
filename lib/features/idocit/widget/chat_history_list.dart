import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/models/enums/role.dart';
import 'package:idocit/features/chat/domain/models/extensions/percent_string.dart';
import 'package:idocit/features/idocit/widget/doc_names_expandable_list.dart';
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
                      SvgPicture.asset(ImageConstants.userChatAvatarSvg, height: 30, width: 30),
                      Text(
                        'You',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorConstants.white500, fontSize: 9, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                : role == Role.assistant
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageConstants.igIdocIt, height: 22, width: 22),
                      Text(
                        'iDocIt\nAI',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorConstants.black500, fontSize: 9, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                : null,
            title: role != Role.user
                ? MarkdownBody(
                    data: historyItem.content,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                      p: const TextStyle(fontSize: 16, height: 1.5, color: ColorConstants.black500),
                      h1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: ColorConstants.black500),
                      h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ColorConstants.black500),
                      h3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorConstants.black500),
                      tableColumnWidth: const IntrinsicColumnWidth(),
                    ),
                    shrinkWrap: true,
                  )
                : Text(historyItem.content, style: TextStyle(color: ColorConstants.white500)),
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
                      subtitle: DocNamesExpandableList(docNames: category.knowledgeData),
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
