import 'package:idocit/features/chat/domain/models/enums/chat_item_type.dart';

class ChatItem {
  final ChatItemType type;
  final String text;

  ChatItem(this.type, this.text);
}
