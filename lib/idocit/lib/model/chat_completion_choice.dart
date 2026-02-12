//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatCompletionChoice {
  /// Returns a new [ChatCompletionChoice] instance.
  ChatCompletionChoice({
    this.index,
    this.finishReason,
    this.delta = const {},
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? index;

  String? finishReason;

  Map<String, Object> delta;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatCompletionChoice &&
    other.index == index &&
    other.finishReason == finishReason &&
    _deepEquality.equals(other.delta, delta);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (index == null ? 0 : index!.hashCode) +
    (finishReason == null ? 0 : finishReason!.hashCode) +
    (delta.hashCode);

  @override
  String toString() => 'ChatCompletionChoice[index=$index, finishReason=$finishReason, delta=$delta]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.index != null) {
      json[r'index'] = this.index;
    } else {
      json[r'index'] = null;
    }
    if (this.finishReason != null) {
      json[r'finish_reason'] = this.finishReason;
    } else {
      json[r'finish_reason'] = null;
    }
      json[r'delta'] = this.delta;
    return json;
  }

  /// Returns a new [ChatCompletionChoice] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatCompletionChoice? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatCompletionChoice[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatCompletionChoice[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatCompletionChoice(
        index: mapValueOfType<int>(json, r'index'),
        finishReason: mapValueOfType<String>(json, r'finish_reason'),
        delta: mapCastOfType<String, Object>(json, r'delta') ?? const {},
      );
    }
    return null;
  }

  static List<ChatCompletionChoice> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatCompletionChoice>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatCompletionChoice.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatCompletionChoice> mapFromJson(dynamic json) {
    final map = <String, ChatCompletionChoice>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatCompletionChoice.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatCompletionChoice-objects as value to a dart map
  static Map<String, List<ChatCompletionChoice>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatCompletionChoice>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatCompletionChoice.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

