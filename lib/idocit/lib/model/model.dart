//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Model {
  /// Returns a new [Model] instance.
  Model({
    required this.providerId,
    required this.modelId,
    required this.name,
    required this.contextWindow,
    required this.available,
    required this.message,
  });

  String providerId;

  String modelId;

  String name;

  int contextWindow;

  bool available;

  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Model &&
    other.providerId == providerId &&
    other.modelId == modelId &&
    other.name == name &&
    other.contextWindow == contextWindow &&
    other.available == available &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (providerId.hashCode) +
    (modelId.hashCode) +
    (name.hashCode) +
    (contextWindow.hashCode) +
    (available.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'Model[providerId=$providerId, modelId=$modelId, name=$name, contextWindow=$contextWindow, available=$available, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'provider_id'] = this.providerId;
      json[r'model_id'] = this.modelId;
      json[r'name'] = this.name;
      json[r'context_window'] = this.contextWindow;
      json[r'available'] = this.available;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [Model] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Model? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Model[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Model[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Model(
        providerId: mapValueOfType<String>(json, r'provider_id')!,
        modelId: mapValueOfType<String>(json, r'model_id')!,
        name: mapValueOfType<String>(json, r'name')!,
        contextWindow: mapValueOfType<int>(json, r'context_window')!,
        available: mapValueOfType<bool>(json, r'available')!,
        message: mapValueOfType<String>(json, r'message')!,
      );
    }
    return null;
  }

  static List<Model> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Model>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Model.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Model> mapFromJson(dynamic json) {
    final map = <String, Model>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Model.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Model-objects as value to a dart map
  static Map<String, List<Model>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Model>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Model.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'provider_id',
    'model_id',
    'name',
    'context_window',
    'available',
    'message',
  };
}

