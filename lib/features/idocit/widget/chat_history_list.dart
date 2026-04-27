import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/models/enums/role.dart';
import 'package:idocit/features/chat/domain/models/extensions/percent_string.dart';
import 'package:idocit/features/idocit/widget/doc_names_expandable_list.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatHistoryList extends StatelessWidget {
  final List<ChatHistoryMessage> messages;

  const ChatHistoryList({super.key, required this.messages});

  Future<void> _handleExternalUrl(BuildContext context, String? href) async {
    LoggerService.logDebug("Open external: $href");

    if (href == null) return;
    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    if (scaffoldMessenger == null) return;
    scaffoldMessenger.clearSnackBars();
    final link = Uri.tryParse(href);
    if (link == null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(key: UniqueKey(), content: Text('Wrong uri $href'), duration: Duration(seconds: 5)),
      );
      return;
    }
    final canLaunch = await canLaunchUrl(link);
    if (!canLaunch) return;
    if (!await canLaunchUrl(link) || !await launchUrl(link, mode: LaunchMode.externalApplication)) {
      // ignore: use_build_context_synchronously
      scaffoldMessenger.showSnackBar(
        SnackBar(key: UniqueKey(), content: Text('Could not launch $link'), duration: Duration(seconds: 5)),
      );
    }
  }

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
            title: role == Role.user
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageConstants.userChatAvatarSvg, height: 30, width: 30),
                          SizedBox(width: 5),
                          Text(
                            'You',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorConstants.white500, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      Text(historyItem.content, style: TextStyle(color: ColorConstants.white500)),
                    ],
                  )
                : role == Role.assistant
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(ImageConstants.igIdocIt, height: 30, width: 30),
                          SizedBox(width: 5),
                          Text(
                            'iDocIt AI',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: ColorConstants.black500, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0),
                      MarkdownBody(
                        data: historyItem.content,
                        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                          p: const TextStyle(fontSize: 16, height: 1.5, color: ColorConstants.black500),
                          h1: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: ColorConstants.black500),
                          h2: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ColorConstants.black500),
                          h3: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorConstants.black500),
                          tableColumnWidth: const IntrinsicColumnWidth(),
                        ),
                        shrinkWrap: true,
                        onTapLink: (_, href, _) async => await _handleExternalUrl(context, href),
                      ),
                    ],
                  )
                : null,
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
