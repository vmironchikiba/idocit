//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdatePresetPayload {
  /// Returns a new [UpdatePresetPayload] instance.
  UpdatePresetPayload({
    required this.name,
    required this.description,
    required this.reader,
    required this.chunker,
    required this.units,
    required this.overlap,
  });

  String name;

  String description;

  String reader;

  String chunker;

  int units;

  int overlap;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdatePresetPayload &&
    other.name == name &&
    other.description == description &&
    other.reader == reader &&
    other.chunker == chunker &&
    other.units == units &&
    other.overlap == overlap;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (description.hashCode) +
    (reader.hashCode) +
    (chunker.hashCode) +
    (units.hashCode) +
    (overlap.hashCode);

  @override
  String toString() => 'UpdatePresetPayload[name=$name, description=$description, reader=$reader, chunker=$chunker, units=$units, overlap=$overlap]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'description'] = this.description;
      json[r'reader'] = this.reader;
      json[r'chunker'] = this.chunker;
      json[r'units'] = this.units;
      json[r'overlap'] = this.overlap;
    return json;
  }

  /// Returns a new [UpdatePresetPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdatePresetPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdatePresetPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdatePresetPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdatePresetPayload(
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        reader: mapValueOfType<String>(json, r'reader')!,
        chunker: mapValueOfType<String>(json, r'chunker')!,
        units: mapValueOfType<int>(json, r'units')!,
        overlap: mapValueOfType<int>(json, r'overlap')!,
      );
    }
    return null;
  }

  static List<UpdatePresetPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdatePresetPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdatePresetPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdatePresetPayload> mapFromJson(dynamic json) {
    final map = <String, UpdatePresetPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdatePresetPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdatePresetPayload-objects as value to a dart map
  static Map<String, List<UpdatePresetPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdatePresetPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdatePresetPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'description',
    'reader',
    'chunker',
    'units',
    'overlap',
  };
}

