//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class OneDriveReadFilesPayload {
  /// Returns a new [OneDriveReadFilesPayload] instance.
  OneDriveReadFilesPayload({
    required this.presetId,
    required this.categoryId,
    required this.path,
  });

  int presetId;

  int categoryId;

  String path;

  @override
  bool operator ==(Object other) => identical(this, other) || other is OneDriveReadFilesPayload &&
    other.presetId == presetId &&
    other.categoryId == categoryId &&
    other.path == path;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (presetId.hashCode) +
    (categoryId.hashCode) +
    (path.hashCode);

  @override
  String toString() => 'OneDriveReadFilesPayload[presetId=$presetId, categoryId=$categoryId, path=$path]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'preset_id'] = this.presetId;
      json[r'category_id'] = this.categoryId;
      json[r'path'] = this.path;
    return json;
  }

  /// Returns a new [OneDriveReadFilesPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static OneDriveReadFilesPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "OneDriveReadFilesPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "OneDriveReadFilesPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return OneDriveReadFilesPayload(
        presetId: mapValueOfType<int>(json, r'preset_id')!,
        categoryId: mapValueOfType<int>(json, r'category_id')!,
        path: mapValueOfType<String>(json, r'path')!,
      );
    }
    return null;
  }

  static List<OneDriveReadFilesPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OneDriveReadFilesPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OneDriveReadFilesPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, OneDriveReadFilesPayload> mapFromJson(dynamic json) {
    final map = <String, OneDriveReadFilesPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = OneDriveReadFilesPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of OneDriveReadFilesPayload-objects as value to a dart map
  static Map<String, List<OneDriveReadFilesPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<OneDriveReadFilesPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = OneDriveReadFilesPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'preset_id',
    'category_id',
    'path',
  };
}

