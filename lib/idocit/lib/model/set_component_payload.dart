//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetComponentPayload {
  /// Returns a new [SetComponentPayload] instance.
  SetComponentPayload({
    required this.component,
    required this.selectedComponent,
  });

  String component;

  SelectedComponent selectedComponent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetComponentPayload &&
    other.component == component &&
    other.selectedComponent == selectedComponent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (component.hashCode) +
    (selectedComponent.hashCode);

  @override
  String toString() => 'SetComponentPayload[component=$component, selectedComponent=$selectedComponent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'component'] = this.component;
      json[r'selected_component'] = this.selectedComponent;
    return json;
  }

  /// Returns a new [SetComponentPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetComponentPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SetComponentPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SetComponentPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SetComponentPayload(
        component: mapValueOfType<String>(json, r'component')!,
        selectedComponent: SelectedComponent.fromJson(json[r'selected_component'])!,
      );
    }
    return null;
  }

  static List<SetComponentPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetComponentPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetComponentPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetComponentPayload> mapFromJson(dynamic json) {
    final map = <String, SetComponentPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetComponentPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetComponentPayload-objects as value to a dart map
  static Map<String, List<SetComponentPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetComponentPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetComponentPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'component',
    'selected_component',
  };
}

