//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatSummary {
  /// Returns a new [ChatSummary] instance.
  ChatSummary({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.lastMessagePreview,
    this.lastMessageTime,
  });

  /// Chat ID
  String id;

  /// Chat title
  String title;

  DateTime createdAt;

  DateTime updatedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastMessagePreview;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? lastMessageTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatSummary &&
    other.id == id &&
    other.title == title &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.lastMessagePreview == lastMessagePreview &&
    other.lastMessageTime == lastMessageTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (title.hashCode) +
    (createdAt.hashCode) +
    (updatedAt.hashCode) +
    (lastMessagePreview == null ? 0 : lastMessagePreview!.hashCode) +
    (lastMessageTime == null ? 0 : lastMessageTime!.hashCode);

  @override
  String toString() => 'ChatSummary[id=$id, title=$title, createdAt=$createdAt, updatedAt=$updatedAt, lastMessagePreview=$lastMessagePreview, lastMessageTime=$lastMessageTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'title'] = this.title;
      json[r'created_at'] = this.createdAt.toUtc().toIso8601String();
      json[r'updated_at'] = this.updatedAt.toUtc().toIso8601String();
    if (this.lastMessagePreview != null) {
      json[r'last_message_preview'] = this.lastMessagePreview;
    } else {
      json[r'last_message_preview'] = null;
    }
    if (this.lastMessageTime != null) {
      json[r'last_message_time'] = this.lastMessageTime!.toUtc().toIso8601String();
    } else {
      json[r'last_message_time'] = null;
    }
    return json;
  }

  /// Returns a new [ChatSummary] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatSummary? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatSummary[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatSummary[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatSummary(
        id: mapValueOfType<String>(json, r'id')!,
        title: mapValueOfType<String>(json, r'title')!,
        createdAt: mapDateTime(json, r'created_at', r'')!,
        updatedAt: mapDateTime(json, r'updated_at', r'')!,
        lastMessagePreview: mapValueOfType<String>(json, r'last_message_preview'),
        lastMessageTime: mapDateTime(json, r'last_message_time', r''),
      );
    }
    return null;
  }

  static List<ChatSummary> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatSummary>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatSummary.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatSummary> mapFromJson(dynamic json) {
    final map = <String, ChatSummary>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatSummary.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatSummary-objects as value to a dart map
  static Map<String, List<ChatSummary>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatSummary>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatSummary.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'title',
    'created_at',
    'updated_at',
  };
}

