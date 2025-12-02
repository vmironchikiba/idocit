//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ConversationItemHistory {
  /// Returns a new [ConversationItemHistory] instance.
  ConversationItemHistory({
    required this.content,
    this.user,
    required this.type,
    this.id,
  });

  String content;

  String? user;

  String type;

  String? id;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ConversationItemHistory &&
    other.content == content &&
    other.user == user &&
    other.type == type &&
    other.id == id;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (content.hashCode) +
    (user == null ? 0 : user!.hashCode) +
    (type.hashCode) +
    (id == null ? 0 : id!.hashCode);

  @override
  String toString() => 'ConversationItemHistory[content=$content, user=$user, type=$type, id=$id]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'content'] = this.content;
    if (this.user != null) {
      json[r'user'] = this.user;
    } else {
      json[r'user'] = null;
    }
      json[r'type'] = this.type;
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    return json;
  }

  /// Returns a new [ConversationItemHistory] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ConversationItemHistory? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ConversationItemHistory[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ConversationItemHistory[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ConversationItemHistory(
        content: mapValueOfType<String>(json, r'content')!,
        user: mapValueOfType<String>(json, r'user'),
        type: mapValueOfType<String>(json, r'type')!,
        id: mapValueOfType<String>(json, r'id'),
      );
    }
    return null;
  }

  static List<ConversationItemHistory> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ConversationItemHistory>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ConversationItemHistory.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ConversationItemHistory> mapFromJson(dynamic json) {
    final map = <String, ConversationItemHistory>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ConversationItemHistory.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ConversationItemHistory-objects as value to a dart map
  static Map<String, List<ConversationItemHistory>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ConversationItemHistory>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ConversationItemHistory.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'content',
    'type',
  };
}

