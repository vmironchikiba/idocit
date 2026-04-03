//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DocumentChunk {
  /// Returns a new [DocumentChunk] instance.
  DocumentChunk({
    required this.chunkId,
    required this.parentChunkId,
    required this.textNoOverlap,
  });

  int chunkId;

  int parentChunkId;

  String textNoOverlap;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DocumentChunk &&
    other.chunkId == chunkId &&
    other.parentChunkId == parentChunkId &&
    other.textNoOverlap == textNoOverlap;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (chunkId.hashCode) +
    (parentChunkId.hashCode) +
    (textNoOverlap.hashCode);

  @override
  String toString() => 'DocumentChunk[chunkId=$chunkId, parentChunkId=$parentChunkId, textNoOverlap=$textNoOverlap]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'chunk_id'] = this.chunkId;
      json[r'parent_chunk_id'] = this.parentChunkId;
      json[r'text_no_overlap'] = this.textNoOverlap;
    return json;
  }

  /// Returns a new [DocumentChunk] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DocumentChunk? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DocumentChunk[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DocumentChunk[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DocumentChunk(
        chunkId: mapValueOfType<int>(json, r'chunk_id')!,
        parentChunkId: mapValueOfType<int>(json, r'parent_chunk_id')!,
        textNoOverlap: mapValueOfType<String>(json, r'text_no_overlap')!,
      );
    }
    return null;
  }

  static List<DocumentChunk> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DocumentChunk>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DocumentChunk.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DocumentChunk> mapFromJson(dynamic json) {
    final map = <String, DocumentChunk>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DocumentChunk.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DocumentChunk-objects as value to a dart map
  static Map<String, List<DocumentChunk>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DocumentChunk>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DocumentChunk.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'chunk_id',
    'parent_chunk_id',
    'text_no_overlap',
  };
}

