import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:flutter_tts/flutter_tts.dart';

class StreamOnDataHandler {
  final FlutterTts flutterTts;

  StreamOnDataHandler(this.flutterTts);

  String buffer = '';
  String previewBuffer = '';
  bool frameScheduled = false;

  Future<void> onData(ChatChunk data, ChatStateNotifier store) async {
    final choice = data.choices.first;

    // =============================
    // CONTENT STREAM
    // =============================
    final content = choice.delta?.content;

    if (content != null) {
      store.setPreMessageArray([]);

      final currentChatId = store.chatId;

      if (currentChatId == null) {
        store.setChatId(data.id);
        await store.getAllHistory();
      }

      final chunk = content;

      buffer += chunk.replaceAll('\n', ' ');
      previewBuffer += chunk;

      // === RAF аналог ===
      if (!frameScheduled) {
        frameScheduled = true;

        SchedulerBinding.instance.addPostFrameCallback((_) {
          store.appendPreviewMessage(previewBuffer);
          previewBuffer = '';
          frameScheduled = false;
        });
      }

      // =============================
      // VOICE RESPONSE
      // =============================
      if (store.isRequestedUsedMicrophone && store.isVoiceResponseEnabled) {
        if (store.previewMessage.isEmpty) {
          store.setIsSpeakingLastMessage(true);
        }

        final sentences = buffer.split(RegExp(r'(?<=[.!?])\s'));

        if (sentences.isNotEmpty) {
          final last = sentences.last;

          final endsProperly = last.endsWith('.') || last.endsWith('!') || last.endsWith('?');

          if (!endsProperly) {
            buffer = sentences.removeLast();
          } else {
            buffer = '';
          }
        }

        for (final sentence in sentences) {
          await flutterTts.setLanguage(store.defaultLanguage);
          await flutterTts.speak(sentence);
        }
      }
    }

    // =============================
    // TOOL CALLS
    // =============================
    if (choice.finishReason == 'tool_calls') {
      final toolCall = choice.delta!.toolCalls!.first;
      final args = toolCall.function.arguments;

      if (args.type == 'system.token') {
        store.addPreMessage(args.message ?? '');
      }

      if (toolCall.id == 'generation.node_update') {
        final knowledge = args.data?[1].generation.knowledge as QueryResponse;

        store.setKnowledge(knowledge: knowledge, traceId: args.traceId ?? '');
      }
    }
  }
}

class ChatStateNotifier {
  String? chatId;
  String previewMessage = '';

  bool isRequestedUsedMicrophone = false;
  bool isVoiceResponseEnabled = true;

  String defaultLanguage = 'en-US';

  List<String> preMessageArray = [];

  void setChatId(String id) {
    chatId = id;
  }

  Future<void> getAllHistory() async {}

  void setPreMessageArray(List<String> arr) {
    preMessageArray = arr;
  }

  void appendPreviewMessage(String text) {
    previewMessage += text;
  }

  void setIsSpeakingLastMessage(bool v) {}

  void addPreMessage(String msg) {
    preMessageArray.add(msg);
  }

  void setKnowledge({required QueryResponse knowledge, required String traceId}) {}
}

class KnowledgeData {
  final String text;
  final String docName;
  final int chunkId;
  final String docUuid;
  final String docType;
  final String score;
  final String? docLink;
  final bool? isUsed;

  KnowledgeData({
    required this.text,
    required this.docName,
    required this.chunkId,
    required this.docUuid,
    required this.docType,
    required this.score,
    this.docLink,
    this.isUsed,
  });

  factory KnowledgeData.fromJson(Map<String, dynamic> json) {
    return KnowledgeData(
      text: json['text'] ?? '',
      docName: json['doc_name'] ?? '',
      chunkId: json['chunk_id'] ?? 0,
      docUuid: json['doc_uuid'] ?? '',
      docType: json['doc_type'] ?? '',
      score: json['score'] ?? '',
      docLink: json['doc_link'],
      isUsed: json['is_used'],
    );
  }
}

class QueryRelatedCategories {
  final String id;
  final String type;
  final String name;
  final String description;
  final String context;
  final List<KnowledgeData> knowledgeData;

  QueryRelatedCategories({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.context,
    required this.knowledgeData,
  });

  factory QueryRelatedCategories.fromJson(Map<String, dynamic> json) {
    return QueryRelatedCategories(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      context: json['context'] ?? '',
      knowledgeData: (json['knowledge_data'] as List? ?? []).map((e) => KnowledgeData.fromJson(e)).toList(),
    );
  }
}

class QueryResponse {
  final List<QueryRelatedCategories> categories;
  final String? sessionId;

  QueryResponse({required this.categories, this.sessionId});

  factory QueryResponse.fromJson(Map<String, dynamic> json) {
    return QueryResponse(
      categories: (json['categories'] as List? ?? []).map((e) => QueryRelatedCategories.fromJson(e)).toList(),
      sessionId: json['session_id'],
    );
  }
}

class IMessage {
  final String? id;
  final String type;
  final String content;
  final bool typewriter;
  final List<QueryRelatedCategories>? categories;
  final String? traceId;
  final int? statusCode;
  final String? finishReason;
  final String? fullText;
  final String? message;
  final List<String>? preMessageArray;

  IMessage({
    this.id,
    required this.type,
    required this.content,
    required this.typewriter,
    this.categories,
    this.traceId,
    this.statusCode,
    this.finishReason,
    this.fullText,
    this.message,
    this.preMessageArray,
  });

  factory IMessage.fromJson(Map<String, dynamic> json) {
    return IMessage(
      id: json['id'],
      type: json['type'] ?? 'system',
      content: json['content'] ?? '',
      typewriter: json['typewriter'] ?? false,
      categories: (json['categories'] as List?)?.map((e) => QueryRelatedCategories.fromJson(e)).toList(),
      traceId: json['trace_id'],
      statusCode: json['status_code'],
      finishReason: json['finish_reason'],
      fullText: json['full_text'],
      message: json['message'],
      preMessageArray: (json['preMessageArray'] as List?)?.map((e) => e.toString()).toList(),
    );
  }
}

class ChatChunk {
  final String id;
  final List<ChatChoice> choices;

  ChatChunk({required this.id, required this.choices});

  factory ChatChunk.fromJson(Map<String, dynamic> json) {
    return ChatChunk(
      id: json['id'] ?? '',
      choices: (json['choices'] as List).map((e) => ChatChoice.fromJson(e)).toList(),
    );
  }
}

class ChatChoice {
  final ChatDelta? delta;
  final String? finishReason;

  ChatChoice({this.delta, this.finishReason});

  factory ChatChoice.fromJson(Map<String, dynamic> json) {
    return ChatChoice(
      delta: json['delta'] != null ? ChatDelta.fromJson(json['delta']) : null,
      finishReason: json['finish_reason'],
    );
  }
}

class ChatDelta {
  final String? content;
  final List<ToolCall>? toolCalls;

  ChatDelta({this.content, this.toolCalls});

  factory ChatDelta.fromJson(Map<String, dynamic> json) {
    return ChatDelta(
      content: json['content'],
      toolCalls: json['tool_calls'] != null
          ? (json['tool_calls'] as List).map((e) => ToolCall.fromJson(e)).toList()
          : null,
    );
  }
}

class ToolCall {
  final String id;
  final ToolFunction function;

  ToolCall({required this.id, required this.function});

  factory ToolCall.fromJson(Map<String, dynamic> json) {
    return ToolCall(id: json['id'] ?? '', function: ToolFunction.fromJson(json['function']));
  }
}

class ToolFunction {
  final ToolArguments arguments;

  ToolFunction({required this.arguments});

  factory ToolFunction.fromJson(Map<String, dynamic> json) {
    return ToolFunction(
      arguments: ToolArguments.fromJson(
        json['arguments'] is String ? jsonDecode(json['arguments']) : json['arguments'],
      ),
    );
  }
}

class ToolArguments {
  final String? type;
  final String? message;
  final List<dynamic>? data;
  final String? traceId;

  ToolArguments({this.type, this.message, this.data, this.traceId});

  factory ToolArguments.fromJson(Map<String, dynamic> json) {
    return ToolArguments(type: json['type'], message: json['message'], data: json['data'], traceId: json['trace_id']);
  }
}
