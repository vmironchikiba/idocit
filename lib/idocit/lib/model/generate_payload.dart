//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GeneratePayload {
  /// Returns a new [GeneratePayload] instance.
  GeneratePayload({
    required this.query,
    this.queryRelatedCategories = const [],
    this.conversation = const [],
    this.generator = '',
    this.embedder = '',
    this.language = '',
    this.sessionId,
  });

  String query;

  List<QueryRelatedCategoryPayload> queryRelatedCategories;

  List<ConversationItem> conversation;

  String generator;

  String embedder;

  String language;

  String? sessionId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GeneratePayload &&
    other.query == query &&
    _deepEquality.equals(other.queryRelatedCategories, queryRelatedCategories) &&
    _deepEquality.equals(other.conversation, conversation) &&
    other.generator == generator &&
    other.embedder == embedder &&
    other.language == language &&
    other.sessionId == sessionId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (query.hashCode) +
    (queryRelatedCategories.hashCode) +
    (conversation.hashCode) +
    (generator.hashCode) +
    (embedder.hashCode) +
    (language.hashCode) +
    (sessionId == null ? 0 : sessionId!.hashCode);

  @override
  String toString() => 'GeneratePayload[query=$query, queryRelatedCategories=$queryRelatedCategories, conversation=$conversation, generator=$generator, embedder=$embedder, language=$language, sessionId=$sessionId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'query'] = this.query;
      json[r'query_related_categories'] = this.queryRelatedCategories;
      json[r'conversation'] = this.conversation;
      json[r'generator'] = this.generator;
      json[r'embedder'] = this.embedder;
      json[r'language'] = this.language;
    if (this.sessionId != null) {
      json[r'session_id'] = this.sessionId;
    } else {
      json[r'session_id'] = null;
    }
    return json;
  }

  /// Returns a new [GeneratePayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GeneratePayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GeneratePayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GeneratePayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GeneratePayload(
        query: mapValueOfType<String>(json, r'query')!,
        queryRelatedCategories: QueryRelatedCategoryPayload.listFromJson(json[r'query_related_categories']),
        conversation: ConversationItem.listFromJson(json[r'conversation']),
        generator: mapValueOfType<String>(json, r'generator') ?? '',
        embedder: mapValueOfType<String>(json, r'embedder') ?? '',
        language: mapValueOfType<String>(json, r'language') ?? '',
        sessionId: mapValueOfType<String>(json, r'session_id'),
      );
    }
    return null;
  }

  static List<GeneratePayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GeneratePayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GeneratePayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GeneratePayload> mapFromJson(dynamic json) {
    final map = <String, GeneratePayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GeneratePayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GeneratePayload-objects as value to a dart map
  static Map<String, List<GeneratePayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GeneratePayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GeneratePayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'query',
    'query_related_categories',
    'conversation',
  };
}

