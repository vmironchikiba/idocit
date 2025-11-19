//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatCompletionChunk {
  /// Returns a new [ChatCompletionChunk] instance.
  ChatCompletionChunk({
    this.id,
    this.created,
    this.model,
    this.object,
    this.choices = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? created;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? model;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? object;

  List<ChatCompletionChoice> choices;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatCompletionChunk &&
    other.id == id &&
    other.created == created &&
    other.model == model &&
    other.object == object &&
    _deepEquality.equals(other.choices, choices);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (created == null ? 0 : created!.hashCode) +
    (model == null ? 0 : model!.hashCode) +
    (object == null ? 0 : object!.hashCode) +
    (choices.hashCode);

  @override
  String toString() => 'ChatCompletionChunk[id=$id, created=$created, model=$model, object=$object, choices=$choices]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.created != null) {
      json[r'created'] = this.created;
    } else {
      json[r'created'] = null;
    }
    if (this.model != null) {
      json[r'model'] = this.model;
    } else {
      json[r'model'] = null;
    }
    if (this.object != null) {
      json[r'object'] = this.object;
    } else {
      json[r'object'] = null;
    }
      json[r'choices'] = this.choices;
    return json;
  }

  /// Returns a new [ChatCompletionChunk] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatCompletionChunk? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatCompletionChunk[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatCompletionChunk[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatCompletionChunk(
        id: mapValueOfType<String>(json, r'id'),
        created: mapValueOfType<int>(json, r'created'),
        model: mapValueOfType<String>(json, r'model'),
        object: mapValueOfType<String>(json, r'object'),
        choices: ChatCompletionChoice.listFromJson(json[r'choices']),
      );
    }
    return null;
  }

  static List<ChatCompletionChunk> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatCompletionChunk>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatCompletionChunk.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatCompletionChunk> mapFromJson(dynamic json) {
    final map = <String, ChatCompletionChunk>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatCompletionChunk.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatCompletionChunk-objects as value to a dart map
  static Map<String, List<ChatCompletionChunk>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatCompletionChunk>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatCompletionChunk.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

