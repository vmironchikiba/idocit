import 'package:idocit/idocit/lib/api.dart';

class CompletionRequest {
  final String tenant;
  final String chatId;
  final String language;
  final String role;
  final String content;

  const CompletionRequest({
    required this.tenant,
    required this.chatId,
    required this.language,
    required this.content,
    required this.role,
  });
  VerbaOptions _toVerbaOptions() =>
      VerbaOptions(tenant: tenant, language: language, chatId: chatId, embedder: {}, retriever: {}, generator: {});
  ChatMessage _toChatMessage() => ChatMessage(role: role, content: content);
  ChatCompletionRequest toChatCompletionRequest() => ChatCompletionRequest(
    model: 'idocit',
    messages: [_toChatMessage()],
    stream: true,
    extraParams: _toVerbaOptions(),
  );
}
