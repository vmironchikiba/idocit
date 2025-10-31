//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminLoadPayload {
  /// Returns a new [AdminLoadPayload] instance.
  AdminLoadPayload({
    required this.presetId,
    required this.embedder,
    this.fileBytes = const [],
    this.fileNames = const [],
    this.filePath,
    required this.maxDepth,
    required this.allowSubdomains,
    required this.categoryId,
    this.confluenceUrl,
    this.confluenceUsername,
    this.confluencePassword,
    this.confluenceSpaceKey,
    this.descriptions = const [],
  });

  int presetId;

  String embedder;

  List<String> fileBytes;

  List<String> fileNames;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? filePath;

  int maxDepth;

  bool allowSubdomains;

  int categoryId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? confluenceUrl;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? confluenceUsername;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? confluencePassword;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? confluenceSpaceKey;

  List<String>? descriptions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminLoadPayload &&
    other.presetId == presetId &&
    other.embedder == embedder &&
    _deepEquality.equals(other.fileBytes, fileBytes) &&
    _deepEquality.equals(other.fileNames, fileNames) &&
    other.filePath == filePath &&
    other.maxDepth == maxDepth &&
    other.allowSubdomains == allowSubdomains &&
    other.categoryId == categoryId &&
    other.confluenceUrl == confluenceUrl &&
    other.confluenceUsername == confluenceUsername &&
    other.confluencePassword == confluencePassword &&
    other.confluenceSpaceKey == confluenceSpaceKey &&
    _deepEquality.equals(other.descriptions, descriptions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (presetId.hashCode) +
    (embedder.hashCode) +
    (fileBytes.hashCode) +
    (fileNames.hashCode) +
    (filePath == null ? 0 : filePath!.hashCode) +
    (maxDepth.hashCode) +
    (allowSubdomains.hashCode) +
    (categoryId.hashCode) +
    (confluenceUrl == null ? 0 : confluenceUrl!.hashCode) +
    (confluenceUsername == null ? 0 : confluenceUsername!.hashCode) +
    (confluencePassword == null ? 0 : confluencePassword!.hashCode) +
    (confluenceSpaceKey == null ? 0 : confluenceSpaceKey!.hashCode) +
    (descriptions == null ? 0 : descriptions!.hashCode);

  @override
  String toString() => 'AdminLoadPayload[presetId=$presetId, embedder=$embedder, fileBytes=$fileBytes, fileNames=$fileNames, filePath=$filePath, maxDepth=$maxDepth, allowSubdomains=$allowSubdomains, categoryId=$categoryId, confluenceUrl=$confluenceUrl, confluenceUsername=$confluenceUsername, confluencePassword=$confluencePassword, confluenceSpaceKey=$confluenceSpaceKey, descriptions=$descriptions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'preset_id'] = this.presetId;
      json[r'embedder'] = this.embedder;
      json[r'fileBytes'] = this.fileBytes;
      json[r'fileNames'] = this.fileNames;
    if (this.filePath != null) {
      json[r'filePath'] = this.filePath;
    } else {
      json[r'filePath'] = null;
    }
      json[r'maxDepth'] = this.maxDepth;
      json[r'allowSubdomains'] = this.allowSubdomains;
      json[r'category_id'] = this.categoryId;
    if (this.confluenceUrl != null) {
      json[r'confluence_url'] = this.confluenceUrl;
    } else {
      json[r'confluence_url'] = null;
    }
    if (this.confluenceUsername != null) {
      json[r'confluence_username'] = this.confluenceUsername;
    } else {
      json[r'confluence_username'] = null;
    }
    if (this.confluencePassword != null) {
      json[r'confluence_password'] = this.confluencePassword;
    } else {
      json[r'confluence_password'] = null;
    }
    if (this.confluenceSpaceKey != null) {
      json[r'confluence_space_key'] = this.confluenceSpaceKey;
    } else {
      json[r'confluence_space_key'] = null;
    }
    if (this.descriptions != null) {
      json[r'descriptions'] = this.descriptions;
    } else {
      json[r'descriptions'] = null;
    }
    return json;
  }

  /// Returns a new [AdminLoadPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminLoadPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminLoadPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminLoadPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminLoadPayload(
        presetId: mapValueOfType<int>(json, r'preset_id')!,
        embedder: mapValueOfType<String>(json, r'embedder')!,
        fileBytes: json[r'fileBytes'] is Iterable
            ? (json[r'fileBytes'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        fileNames: json[r'fileNames'] is Iterable
            ? (json[r'fileNames'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        filePath: mapValueOfType<String>(json, r'filePath'),
        maxDepth: mapValueOfType<int>(json, r'maxDepth')!,
        allowSubdomains: mapValueOfType<bool>(json, r'allowSubdomains')!,
        categoryId: mapValueOfType<int>(json, r'category_id')!,
        confluenceUrl: mapValueOfType<String>(json, r'confluence_url'),
        confluenceUsername: mapValueOfType<String>(json, r'confluence_username'),
        confluencePassword: mapValueOfType<String>(json, r'confluence_password'),
        confluenceSpaceKey: mapValueOfType<String>(json, r'confluence_space_key'),
        descriptions: json[r'descriptions'] is Iterable
            ? (json[r'descriptions'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<AdminLoadPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminLoadPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminLoadPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminLoadPayload> mapFromJson(dynamic json) {
    final map = <String, AdminLoadPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminLoadPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminLoadPayload-objects as value to a dart map
  static Map<String, List<AdminLoadPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminLoadPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminLoadPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'preset_id',
    'embedder',
    'fileNames',
    'maxDepth',
    'allowSubdomains',
    'category_id',
  };
}

