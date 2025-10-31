//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateCategoryPayload {
  /// Returns a new [UpdateCategoryPayload] instance.
  UpdateCategoryPayload({
    this.name,
    this.description,
    this.categoryTypeId,
    this.actionScript,
    this.retriever,
    this.generator,
  });

  String? name;

  String? description;

  int? categoryTypeId;

  String? actionScript;

  String? retriever;

  String? generator;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateCategoryPayload &&
    other.name == name &&
    other.description == description &&
    other.categoryTypeId == categoryTypeId &&
    other.actionScript == actionScript &&
    other.retriever == retriever &&
    other.generator == generator;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (description == null ? 0 : description!.hashCode) +
    (categoryTypeId == null ? 0 : categoryTypeId!.hashCode) +
    (actionScript == null ? 0 : actionScript!.hashCode) +
    (retriever == null ? 0 : retriever!.hashCode) +
    (generator == null ? 0 : generator!.hashCode);

  @override
  String toString() => 'UpdateCategoryPayload[name=$name, description=$description, categoryTypeId=$categoryTypeId, actionScript=$actionScript, retriever=$retriever, generator=$generator]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.description != null) {
      json[r'description'] = this.description;
    } else {
      json[r'description'] = null;
    }
    if (this.categoryTypeId != null) {
      json[r'category_type_id'] = this.categoryTypeId;
    } else {
      json[r'category_type_id'] = null;
    }
    if (this.actionScript != null) {
      json[r'action_script'] = this.actionScript;
    } else {
      json[r'action_script'] = null;
    }
    if (this.retriever != null) {
      json[r'retriever'] = this.retriever;
    } else {
      json[r'retriever'] = null;
    }
    if (this.generator != null) {
      json[r'generator'] = this.generator;
    } else {
      json[r'generator'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateCategoryPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateCategoryPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateCategoryPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateCategoryPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateCategoryPayload(
        name: mapValueOfType<String>(json, r'name'),
        description: mapValueOfType<String>(json, r'description'),
        categoryTypeId: mapValueOfType<int>(json, r'category_type_id'),
        actionScript: mapValueOfType<String>(json, r'action_script'),
        retriever: mapValueOfType<String>(json, r'retriever'),
        generator: mapValueOfType<String>(json, r'generator'),
      );
    }
    return null;
  }

  static List<UpdateCategoryPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateCategoryPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateCategoryPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateCategoryPayload> mapFromJson(dynamic json) {
    final map = <String, UpdateCategoryPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateCategoryPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateCategoryPayload-objects as value to a dart map
  static Map<String, List<UpdateCategoryPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateCategoryPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateCategoryPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

