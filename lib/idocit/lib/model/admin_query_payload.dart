//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminQueryPayload {
  /// Returns a new [AdminQueryPayload] instance.
  AdminQueryPayload({
    required this.query,
    required this.embedder,
    required this.retriever,
    required this.generator,
    this.documentTypes = const [],
  });

  String query;

  String embedder;

  String retriever;

  String generator;

  List<String> documentTypes;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminQueryPayload &&
    other.query == query &&
    other.embedder == embedder &&
    other.retriever == retriever &&
    other.generator == generator &&
    _deepEquality.equals(other.documentTypes, documentTypes);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (query.hashCode) +
    (embedder.hashCode) +
    (retriever.hashCode) +
    (generator.hashCode) +
    (documentTypes.hashCode);

  @override
  String toString() => 'AdminQueryPayload[query=$query, embedder=$embedder, retriever=$retriever, generator=$generator, documentTypes=$documentTypes]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'query'] = this.query;
      json[r'embedder'] = this.embedder;
      json[r'retriever'] = this.retriever;
      json[r'generator'] = this.generator;
      json[r'document_types'] = this.documentTypes;
    return json;
  }

  /// Returns a new [AdminQueryPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminQueryPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AdminQueryPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AdminQueryPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AdminQueryPayload(
        query: mapValueOfType<String>(json, r'query')!,
        embedder: mapValueOfType<String>(json, r'embedder')!,
        retriever: mapValueOfType<String>(json, r'retriever')!,
        generator: mapValueOfType<String>(json, r'generator')!,
        documentTypes: json[r'document_types'] is Iterable
            ? (json[r'document_types'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<AdminQueryPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminQueryPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminQueryPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminQueryPayload> mapFromJson(dynamic json) {
    final map = <String, AdminQueryPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminQueryPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminQueryPayload-objects as value to a dart map
  static Map<String, List<AdminQueryPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminQueryPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminQueryPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'query',
    'embedder',
    'retriever',
    'generator',
  };
}

