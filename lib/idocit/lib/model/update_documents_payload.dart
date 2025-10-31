//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateDocumentsPayload {
  /// Returns a new [UpdateDocumentsPayload] instance.
  UpdateDocumentsPayload({
    this.ids = const [],
    required this.categoryId,
  });

  List<String> ids;

  int categoryId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateDocumentsPayload &&
    _deepEquality.equals(other.ids, ids) &&
    other.categoryId == categoryId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (ids.hashCode) +
    (categoryId.hashCode);

  @override
  String toString() => 'UpdateDocumentsPayload[ids=$ids, categoryId=$categoryId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'ids'] = this.ids;
      json[r'category_id'] = this.categoryId;
    return json;
  }

  /// Returns a new [UpdateDocumentsPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateDocumentsPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateDocumentsPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateDocumentsPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateDocumentsPayload(
        ids: json[r'ids'] is Iterable
            ? (json[r'ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        categoryId: mapValueOfType<int>(json, r'category_id')!,
      );
    }
    return null;
  }

  static List<UpdateDocumentsPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateDocumentsPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateDocumentsPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateDocumentsPayload> mapFromJson(dynamic json) {
    final map = <String, UpdateDocumentsPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateDocumentsPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateDocumentsPayload-objects as value to a dart map
  static Map<String, List<UpdateDocumentsPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateDocumentsPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateDocumentsPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'ids',
    'category_id',
  };
}

