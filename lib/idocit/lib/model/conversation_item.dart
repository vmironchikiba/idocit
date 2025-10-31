//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConversationItem {
  /// Returns a new [ConversationItem] instance.
  ConversationItem({
    required this.type,
    required this.content,
    required this.typewriter,
  });

  String type;

  String content;

  bool typewriter;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConversationItem &&
    other.type == type &&
    other.content == content &&
    other.typewriter == typewriter;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type.hashCode) +
    (content.hashCode) +
    (typewriter.hashCode);

  @override
  String toString() => 'ConversationItem[type=$type, content=$content, typewriter=$typewriter]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'type'] = this.type;
      json[r'content'] = this.content;
      json[r'typewriter'] = this.typewriter;
    return json;
  }

  /// Returns a new [ConversationItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConversationItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ConversationItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ConversationItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConversationItem(
        type: mapValueOfType<String>(json, r'type')!,
        content: mapValueOfType<String>(json, r'content')!,
        typewriter: mapValueOfType<bool>(json, r'typewriter')!,
      );
    }
    return null;
  }

  static List<ConversationItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConversationItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConversationItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConversationItem> mapFromJson(dynamic json) {
    final map = <String, ConversationItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConversationItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConversationItem-objects as value to a dart map
  static Map<String, List<ConversationItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConversationItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConversationItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
    'content',
    'typewriter',
  };
}

