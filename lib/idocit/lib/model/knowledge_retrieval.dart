//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KnowledgeRetrieval {
  /// Returns a new [KnowledgeRetrieval] instance.
  KnowledgeRetrieval({
    this.query,
    this.conversation = const [],
    this.tenant,
    this.sessionId,
    this.language,
    this.userId,
    this.currentUser,
    this.triggerWorkflow,
    this.conversationResult,
    this.cachedResult,
    this.knowledge,
    this.generationResult,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? query;

  List<ConversationItemHistory> conversation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tenant;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sessionId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? language;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? userId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UserInfo? currentUser;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? triggerWorkflow;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ConversationResult? conversationResult;

  Object? cachedResult;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  KnowledgeBlock? knowledge;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  GenerationResult? generationResult;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KnowledgeRetrieval &&
    other.query == query &&
    _deepEquality.equals(other.conversation, conversation) &&
    other.tenant == tenant &&
    other.sessionId == sessionId &&
    other.language == language &&
    other.userId == userId &&
    other.currentUser == currentUser &&
    other.triggerWorkflow == triggerWorkflow &&
    other.conversationResult == conversationResult &&
    other.cachedResult == cachedResult &&
    other.knowledge == knowledge &&
    other.generationResult == generationResult;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (query == null ? 0 : query!.hashCode) +
    (conversation.hashCode) +
    (tenant == null ? 0 : tenant!.hashCode) +
    (sessionId == null ? 0 : sessionId!.hashCode) +
    (language == null ? 0 : language!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (currentUser == null ? 0 : currentUser!.hashCode) +
    (triggerWorkflow == null ? 0 : triggerWorkflow!.hashCode) +
    (conversationResult == null ? 0 : conversationResult!.hashCode) +
    (cachedResult == null ? 0 : cachedResult!.hashCode) +
    (knowledge == null ? 0 : knowledge!.hashCode) +
    (generationResult == null ? 0 : generationResult!.hashCode);

  @override
  String toString() => 'KnowledgeRetrieval[query=$query, conversation=$conversation, tenant=$tenant, sessionId=$sessionId, language=$language, userId=$userId, currentUser=$currentUser, triggerWorkflow=$triggerWorkflow, conversationResult=$conversationResult, cachedResult=$cachedResult, knowledge=$knowledge, generationResult=$generationResult]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.query != null) {
      json[r'query'] = this.query;
    } else {
      json[r'query'] = null;
    }
      json[r'conversation'] = this.conversation;
    if (this.tenant != null) {
      json[r'tenant'] = this.tenant;
    } else {
      json[r'tenant'] = null;
    }
    if (this.sessionId != null) {
      json[r'session_id'] = this.sessionId;
    } else {
      json[r'session_id'] = null;
    }
    if (this.language != null) {
      json[r'language'] = this.language;
    } else {
      json[r'language'] = null;
    }
    if (this.userId != null) {
      json[r'user_id'] = this.userId;
    } else {
      json[r'user_id'] = null;
    }
    if (this.currentUser != null) {
      json[r'current_user'] = this.currentUser;
    } else {
      json[r'current_user'] = null;
    }
    if (this.triggerWorkflow != null) {
      json[r'trigger_workflow'] = this.triggerWorkflow;
    } else {
      json[r'trigger_workflow'] = null;
    }
    if (this.conversationResult != null) {
      json[r'conversation_result'] = this.conversationResult;
    } else {
      json[r'conversation_result'] = null;
    }
    if (this.cachedResult != null) {
      json[r'cached_result'] = this.cachedResult;
    } else {
      json[r'cached_result'] = null;
    }
    if (this.knowledge != null) {
      json[r'knowledge'] = this.knowledge;
    } else {
      json[r'knowledge'] = null;
    }
    if (this.generationResult != null) {
      json[r'generation_result'] = this.generationResult;
    } else {
      json[r'generation_result'] = null;
    }
    return json;
  }

  /// Returns a new [KnowledgeRetrieval] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static KnowledgeRetrieval? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "KnowledgeRetrieval[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "KnowledgeRetrieval[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return KnowledgeRetrieval(
        query: mapValueOfType<String>(json, r'query'),
        conversation: ConversationItemHistory.listFromJson(json[r'conversation']),
        tenant: mapValueOfType<String>(json, r'tenant'),
        sessionId: mapValueOfType<String>(json, r'session_id'),
        language: mapValueOfType<String>(json, r'language'),
        userId: mapValueOfType<String>(json, r'user_id'),
        currentUser: UserInfo.fromJson(json[r'current_user']),
        triggerWorkflow: mapValueOfType<bool>(json, r'trigger_workflow'),
        conversationResult: ConversationResult.fromJson(json[r'conversation_result']),
        cachedResult: mapValueOfType<Object>(json, r'cached_result'),
        knowledge: KnowledgeBlock.fromJson(json[r'knowledge']),
        generationResult: GenerationResult.fromJson(json[r'generation_result']),
      );
    }
    return null;
  }

  static List<KnowledgeRetrieval> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <KnowledgeRetrieval>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KnowledgeRetrieval.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, KnowledgeRetrieval> mapFromJson(dynamic json) {
    final map = <String, KnowledgeRetrieval>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KnowledgeRetrieval.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of KnowledgeRetrieval-objects as value to a dart map
  static Map<String, List<KnowledgeRetrieval>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<KnowledgeRetrieval>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = KnowledgeRetrieval.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

