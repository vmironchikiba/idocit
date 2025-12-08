//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KnowledgeData {
  /// Returns a new [KnowledgeData] instance.
  KnowledgeData({
    required this.text,
    required this.docName,
    required this.chunkId,
    required this.docUuid,
    required this.docType,
    required this.score,
    this.docLink,
    this.isUsed,
  });

  String text;

  String docName;

  int chunkId;

  String docUuid;

  String docType;

  /// String representation of a numeric score
  String score;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? docLink;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isUsed;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KnowledgeData &&
    other.text == text &&
    other.docName == docName &&
    other.chunkId == chunkId &&
    other.docUuid == docUuid &&
    other.docType == docType &&
    other.score == score &&
    other.docLink == docLink &&
    other.isUsed == isUsed;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (text.hashCode) +
    (docName.hashCode) +
    (chunkId.hashCode) +
    (docUuid.hashCode) +
    (docType.hashCode) +
    (score.hashCode) +
    (docLink == null ? 0 : docLink!.hashCode) +
    (isUsed == null ? 0 : isUsed!.hashCode);

  @override
  String toString() => 'KnowledgeData[text=$text, docName=$docName, chunkId=$chunkId, docUuid=$docUuid, docType=$docType, score=$score, docLink=$docLink, isUsed=$isUsed]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'text'] = this.text;
      json[r'doc_name'] = this.docName;
      json[r'chunk_id'] = this.chunkId;
      json[r'doc_uuid'] = this.docUuid;
      json[r'doc_type'] = this.docType;
      json[r'score'] = this.score;
    if (this.docLink != null) {
      json[r'doc_link'] = this.docLink;
    } else {
      json[r'doc_link'] = null;
    }
    if (this.isUsed != null) {
      json[r'is_used'] = this.isUsed;
    } else {
      json[r'is_used'] = null;
    }
    return json;
  }

  /// Returns a new [KnowledgeData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static KnowledgeData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "KnowledgeData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "KnowledgeData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return KnowledgeData(
        text: mapValueOfType<String>(json, r'text')!,
        docName: mapValueOfType<String>(json, r'doc_name')!,
        chunkId: mapValueOfType<int>(json, r'chunk_id')!,
        docUuid: mapValueOfType<String>(json, r'doc_uuid')!,
        docType: mapValueOfType<String>(json, r'doc_type')!,
        score: mapValueOfType<String>(json, r'score')!,
        docLink: mapValueOfType<String>(json, r'doc_link'),
        isUsed: mapValueOfType<bool>(json, r'is_used'),
      );
    }
    return null;
  }

  static List<KnowledgeData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <KnowledgeData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KnowledgeData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, KnowledgeData> mapFromJson(dynamic json) {
    final map = <String, KnowledgeData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KnowledgeData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of KnowledgeData-objects as value to a dart map
  static Map<String, List<KnowledgeData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<KnowledgeData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = KnowledgeData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'text',
    'doc_name',
    'chunk_id',
    'doc_uuid',
    'doc_type',
    'score',
  };
}

