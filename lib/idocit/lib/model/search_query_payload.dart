//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SearchQueryPayload {
  /// Returns a new [SearchQueryPayload] instance.
  SearchQueryPayload({
    required this.query,
    required this.docType,
  });

  String query;

  String docType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SearchQueryPayload &&
    other.query == query &&
    other.docType == docType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (query.hashCode) +
    (docType.hashCode);

  @override
  String toString() => 'SearchQueryPayload[query=$query, docType=$docType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'query'] = this.query;
      json[r'doc_type'] = this.docType;
    return json;
  }

  /// Returns a new [SearchQueryPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SearchQueryPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SearchQueryPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SearchQueryPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SearchQueryPayload(
        query: mapValueOfType<String>(json, r'query')!,
        docType: mapValueOfType<String>(json, r'doc_type')!,
      );
    }
    return null;
  }

  static List<SearchQueryPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SearchQueryPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SearchQueryPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SearchQueryPayload> mapFromJson(dynamic json) {
    final map = <String, SearchQueryPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SearchQueryPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SearchQueryPayload-objects as value to a dart map
  static Map<String, List<SearchQueryPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SearchQueryPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SearchQueryPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'query',
    'doc_type',
  };
}

