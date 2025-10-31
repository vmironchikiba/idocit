//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatMessage {
  /// Returns a new [ChatMessage] instance.
  ChatMessage({
    this.role = 'user',
    required this.content,
  });

  String role;

  String content;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatMessage &&
    other.role == role &&
    other.content == content;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (role.hashCode) +
    (content.hashCode);

  @override
  String toString() => 'ChatMessage[role=$role, content=$content]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'role'] = this.role;
      json[r'content'] = this.content;
    return json;
  }

  /// Returns a new [ChatMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatMessage(
        role: mapValueOfType<String>(json, r'role') ?? 'user',
        content: mapValueOfType<String>(json, r'content')!,
      );
    }
    return null;
  }

  static List<ChatMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatMessage> mapFromJson(dynamic json) {
    final map = <String, ChatMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatMessage-objects as value to a dart map
  static Map<String, List<ChatMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
  };
}

