//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Provider {
  /// Returns a new [Provider] instance.
  Provider({
    required this.providerId,
    required this.name,
    required this.description,
    required this.defaultModelId,
    required this.available,
    required this.message,
  });

  String providerId;

  String name;

  String description;

  String defaultModelId;

  bool available;

  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Provider &&
    other.providerId == providerId &&
    other.name == name &&
    other.description == description &&
    other.defaultModelId == defaultModelId &&
    other.available == available &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (providerId.hashCode) +
    (name.hashCode) +
    (description.hashCode) +
    (defaultModelId.hashCode) +
    (available.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'Provider[providerId=$providerId, name=$name, description=$description, defaultModelId=$defaultModelId, available=$available, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'provider_id'] = this.providerId;
      json[r'name'] = this.name;
      json[r'description'] = this.description;
      json[r'default_model_id'] = this.defaultModelId;
      json[r'available'] = this.available;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [Provider] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Provider? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Provider[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Provider[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Provider(
        providerId: mapValueOfType<String>(json, r'provider_id')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        defaultModelId: mapValueOfType<String>(json, r'default_model_id')!,
        available: mapValueOfType<bool>(json, r'available')!,
        message: mapValueOfType<String>(json, r'message')!,
      );
    }
    return null;
  }

  static List<Provider> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Provider>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Provider.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Provider> mapFromJson(dynamic json) {
    final map = <String, Provider>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Provider.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Provider-objects as value to a dart map
  static Map<String, List<Provider>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Provider>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Provider.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'provider_id',
    'name',
    'description',
    'default_model_id',
    'available',
    'message',
  };
}

