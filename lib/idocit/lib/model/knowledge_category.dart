//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KnowledgeCategory {
  /// Returns a new [KnowledgeCategory] instance.
  KnowledgeCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.context,
    this.knowledgeData = const [],
  });

  int id;

  String name;

  String description;

  String type;

  String context;

  List<KnowledgeData> knowledgeData;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KnowledgeCategory &&
    other.id == id &&
    other.name == name &&
    other.description == description &&
    other.type == type &&
    other.context == context &&
    _deepEquality.equals(other.knowledgeData, knowledgeData);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (description.hashCode) +
    (type.hashCode) +
    (context.hashCode) +
    (knowledgeData.hashCode);

  @override
  String toString() => 'KnowledgeCategory[id=$id, name=$name, description=$description, type=$type, context=$context, knowledgeData=$knowledgeData]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'description'] = this.description;
      json[r'type'] = this.type;
      json[r'context'] = this.context;
      json[r'knowledge_data'] = this.knowledgeData;
    return json;
  }

  /// Returns a new [KnowledgeCategory] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static KnowledgeCategory? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "KnowledgeCategory[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "KnowledgeCategory[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return KnowledgeCategory(
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        type: mapValueOfType<String>(json, r'type')!,
        context: mapValueOfType<String>(json, r'context')!,
        knowledgeData: KnowledgeData.listFromJson(json[r'knowledge_data']),
      );
    }
    return null;
  }

  static List<KnowledgeCategory> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <KnowledgeCategory>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KnowledgeCategory.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, KnowledgeCategory> mapFromJson(dynamic json) {
    final map = <String, KnowledgeCategory>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KnowledgeCategory.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of KnowledgeCategory-objects as value to a dart map
  static Map<String, List<KnowledgeCategory>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<KnowledgeCategory>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = KnowledgeCategory.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'description',
    'type',
    'context',
    'knowledge_data',
  };
}

