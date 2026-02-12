//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ComponentItem {
  /// Returns a new [ComponentItem] instance.
  ComponentItem({
    required this.name,
    required this.description,
    this.detailedDescription,
    this.inputForm,
    required this.available,
    required this.message,
    this.units,
    this.overlap,
    this.streamable,
  });

  String name;

  String description;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? detailedDescription;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? inputForm;

  bool available;

  String message;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? units;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? overlap;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? streamable;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ComponentItem &&
    other.name == name &&
    other.description == description &&
    other.detailedDescription == detailedDescription &&
    other.inputForm == inputForm &&
    other.available == available &&
    other.message == message &&
    other.units == units &&
    other.overlap == overlap &&
    other.streamable == streamable;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description.hashCode) +
    (detailedDescription == null ? 0 : detailedDescription!.hashCode) +
    (inputForm == null ? 0 : inputForm!.hashCode) +
    (available.hashCode) +
    (message.hashCode) +
    (units == null ? 0 : units!.hashCode) +
    (overlap == null ? 0 : overlap!.hashCode) +
    (streamable == null ? 0 : streamable!.hashCode);

  @override
  String toString() => 'ComponentItem[name=$name, description=$description, detailedDescription=$detailedDescription, inputForm=$inputForm, available=$available, message=$message, units=$units, overlap=$overlap, streamable=$streamable]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'description'] = this.description;
    if (this.detailedDescription != null) {
      json[r'detailed_description'] = this.detailedDescription;
    } else {
      json[r'detailed_description'] = null;
    }
    if (this.inputForm != null) {
      json[r'input_form'] = this.inputForm;
    } else {
      json[r'input_form'] = null;
    }
      json[r'available'] = this.available;
      json[r'message'] = this.message;
    if (this.units != null) {
      json[r'units'] = this.units;
    } else {
      json[r'units'] = null;
    }
    if (this.overlap != null) {
      json[r'overlap'] = this.overlap;
    } else {
      json[r'overlap'] = null;
    }
    if (this.streamable != null) {
      json[r'streamable'] = this.streamable;
    } else {
      json[r'streamable'] = null;
    }
    return json;
  }

  /// Returns a new [ComponentItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ComponentItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ComponentItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ComponentItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ComponentItem(
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        detailedDescription: mapValueOfType<String>(json, r'detailed_description'),
        inputForm: mapValueOfType<String>(json, r'input_form'),
        available: mapValueOfType<bool>(json, r'available')!,
        message: mapValueOfType<String>(json, r'message')!,
        units: mapValueOfType<int>(json, r'units'),
        overlap: mapValueOfType<int>(json, r'overlap'),
        streamable: mapValueOfType<bool>(json, r'streamable'),
      );
    }
    return null;
  }

  static List<ComponentItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ComponentItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ComponentItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ComponentItem> mapFromJson(dynamic json) {
    final map = <String, ComponentItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ComponentItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ComponentItem-objects as value to a dart map
  static Map<String, List<ComponentItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ComponentItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ComponentItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'description',
    'available',
    'message',
  };
}

