//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DocumentProperties {
  /// Returns a new [DocumentProperties] instance.
  DocumentProperties({
    required this.chunkCount,
    required this.docLink,
    required this.docName,
    required this.docType,
    required this.html,
    required this.text,
  });

  int chunkCount;

  String docLink;

  String docName;

  String docType;

  String html;

  String text;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DocumentProperties &&
    other.chunkCount == chunkCount &&
    other.docLink == docLink &&
    other.docName == docName &&
    other.docType == docType &&
    other.html == html &&
    other.text == text;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chunkCount.hashCode) +
    (docLink.hashCode) +
    (docName.hashCode) +
    (docType.hashCode) +
    (html.hashCode) +
    (text.hashCode);

  @override
  String toString() => 'DocumentProperties[chunkCount=$chunkCount, docLink=$docLink, docName=$docName, docType=$docType, html=$html, text=$text]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'chunk_count'] = this.chunkCount;
      json[r'doc_link'] = this.docLink;
      json[r'doc_name'] = this.docName;
      json[r'doc_type'] = this.docType;
      json[r'html'] = this.html;
      json[r'text'] = this.text;
    return json;
  }

  /// Returns a new [DocumentProperties] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DocumentProperties? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DocumentProperties[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DocumentProperties[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DocumentProperties(
        chunkCount: mapValueOfType<int>(json, r'chunk_count')!,
        docLink: mapValueOfType<String>(json, r'doc_link')!,
        docName: mapValueOfType<String>(json, r'doc_name')!,
        docType: mapValueOfType<String>(json, r'doc_type')!,
        html: mapValueOfType<String>(json, r'html')!,
        text: mapValueOfType<String>(json, r'text')!,
      );
    }
    return null;
  }

  static List<DocumentProperties> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DocumentProperties>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DocumentProperties.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DocumentProperties> mapFromJson(dynamic json) {
    final map = <String, DocumentProperties>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DocumentProperties.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DocumentProperties-objects as value to a dart map
  static Map<String, List<DocumentProperties>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DocumentProperties>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DocumentProperties.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'chunk_count',
    'doc_link',
    'doc_name',
    'doc_type',
    'html',
    'text',
  };
}

