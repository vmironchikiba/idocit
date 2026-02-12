//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatHistoryMessage {
  /// Returns a new [ChatHistoryMessage] instance.
  ChatHistoryMessage({
    required this.id,
    required this.chatId,
    required this.role,
    required this.content,
    this.knowledgeRetrieval,
    this.traceId,
    required this.sequence,
    required this.createdAt,
  });

  String id;

  String chatId;

  String role;

  String content;

  KnowledgeRetrieval? knowledgeRetrieval;

  String? traceId;

  int sequence;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatHistoryMessage &&
    other.id == id &&
    other.chatId == chatId &&
    other.role == role &&
    other.content == content &&
    other.knowledgeRetrieval == knowledgeRetrieval &&
    other.traceId == traceId &&
    other.sequence == sequence &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (chatId.hashCode) +
    (role.hashCode) +
    (content.hashCode) +
    (knowledgeRetrieval == null ? 0 : knowledgeRetrieval!.hashCode) +
    (traceId == null ? 0 : traceId!.hashCode) +
    (sequence.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'ChatHistoryMessage[id=$id, chatId=$chatId, role=$role, content=$content, knowledgeRetrieval=$knowledgeRetrieval, traceId=$traceId, sequence=$sequence, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'chat_id'] = this.chatId;
      json[r'role'] = this.role;
      json[r'content'] = this.content;
    if (this.knowledgeRetrieval != null) {
      json[r'knowledge_retrieval'] = this.knowledgeRetrieval;
    } else {
      json[r'knowledge_retrieval'] = null;
    }
    if (this.traceId != null) {
      json[r'trace_id'] = this.traceId;
    } else {
      json[r'trace_id'] = null;
    }
      json[r'sequence'] = this.sequence;
      json[r'created_at'] = this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ChatHistoryMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatHistoryMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatHistoryMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatHistoryMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatHistoryMessage(
        id: mapValueOfType<String>(json, r'id')!,
        chatId: mapValueOfType<String>(json, r'chat_id')!,
        role: mapValueOfType<String>(json, r'role')!,
        content: mapValueOfType<String>(json, r'content')!,
        knowledgeRetrieval: KnowledgeRetrieval.fromJson(json[r'knowledge_retrieval']),
        traceId: mapValueOfType<String>(json, r'trace_id'),
        sequence: mapValueOfType<int>(json, r'sequence')!,
        createdAt: mapDateTime(json, r'created_at', r'')!,
      );
    }
    return null;
  }

  static List<ChatHistoryMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatHistoryMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatHistoryMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatHistoryMessage> mapFromJson(dynamic json) {
    final map = <String, ChatHistoryMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatHistoryMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatHistoryMessage-objects as value to a dart map
  static Map<String, List<ChatHistoryMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatHistoryMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatHistoryMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'chat_id',
    'role',
    'content',
    'sequence',
    'created_at',
  };
}

