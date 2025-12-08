//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Document {
  /// Returns a new [Document] instance.
  Document({
    required this.class_,
    required this.id,
    required this.creationTimeUnix,
    required this.lastUpdateTimeUnix,
    required this.properties,
  });

  String class_;

  String id;

  int creationTimeUnix;

  int lastUpdateTimeUnix;

  DocumentProperties properties;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Document &&
    other.class_ == class_ &&
    other.id == id &&
    other.creationTimeUnix == creationTimeUnix &&
    other.lastUpdateTimeUnix == lastUpdateTimeUnix &&
    other.properties == properties;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (class_.hashCode) +
    (id.hashCode) +
    (creationTimeUnix.hashCode) +
    (lastUpdateTimeUnix.hashCode) +
    (properties.hashCode);

  @override
  String toString() => 'Document[class_=$class_, id=$id, creationTimeUnix=$creationTimeUnix, lastUpdateTimeUnix=$lastUpdateTimeUnix, properties=$properties]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'class'] = this.class_;
      json[r'id'] = this.id;
      json[r'creationTimeUnix'] = this.creationTimeUnix;
      json[r'lastUpdateTimeUnix'] = this.lastUpdateTimeUnix;
      json[r'properties'] = this.properties;
    return json;
  }

  /// Returns a new [Document] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Document? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Document[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Document[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Document(
        class_: mapValueOfType<String>(json, r'class')!,
        id: mapValueOfType<String>(json, r'id')!,
        creationTimeUnix: mapValueOfType<int>(json, r'creationTimeUnix')!,
        lastUpdateTimeUnix: mapValueOfType<int>(json, r'lastUpdateTimeUnix')!,
        properties: DocumentProperties.fromJson(json[r'properties'])!,
      );
    }
    return null;
  }

  static List<Document> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Document>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Document.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Document> mapFromJson(dynamic json) {
    final map = <String, Document>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Document.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Document-objects as value to a dart map
  static Map<String, List<Document>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Document>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Document.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'class',
    'id',
    'creationTimeUnix',
    'lastUpdateTimeUnix',
    'properties',
  };
}

