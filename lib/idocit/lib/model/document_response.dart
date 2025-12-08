//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DocumentResponse {
  /// Returns a new [DocumentResponse] instance.
  DocumentResponse({
    required this.document,
  });

  Document document;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DocumentResponse &&
    other.document == document;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (document.hashCode);

  @override
  String toString() => 'DocumentResponse[document=$document]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'document'] = this.document;
    return json;
  }

  /// Returns a new [DocumentResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DocumentResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DocumentResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DocumentResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DocumentResponse(
        document: Document.fromJson(json[r'document'])!,
      );
    }
    return null;
  }

  static List<DocumentResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DocumentResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DocumentResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DocumentResponse> mapFromJson(dynamic json) {
    final map = <String, DocumentResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DocumentResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DocumentResponse-objects as value to a dart map
  static Map<String, List<DocumentResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DocumentResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DocumentResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'document',
  };
}

