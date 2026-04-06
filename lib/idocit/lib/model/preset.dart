//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Preset {
  /// Returns a new [Preset] instance.
  Preset({
    required this.presetId,
    required this.name,
    required this.description,
    required this.reader,
    required this.chunker,
    required this.units,
    required this.overlap,
    required this.tenant,
    required this.inputForm,
    this.color,
  });

  int presetId;

  String name;

  String description;

  String reader;

  String chunker;

  int units;

  int overlap;

  String tenant;

  String inputForm;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? color;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Preset &&
    other.presetId == presetId &&
    other.name == name &&
    other.description == description &&
    other.reader == reader &&
    other.chunker == chunker &&
    other.units == units &&
    other.overlap == overlap &&
    other.tenant == tenant &&
    other.inputForm == inputForm &&
    other.color == color;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (presetId.hashCode) +
    (name.hashCode) +
    (description.hashCode) +
    (reader.hashCode) +
    (chunker.hashCode) +
    (units.hashCode) +
    (overlap.hashCode) +
    (tenant.hashCode) +
    (inputForm.hashCode) +
    (color == null ? 0 : color!.hashCode);

  @override
  String toString() => 'Preset[presetId=$presetId, name=$name, description=$description, reader=$reader, chunker=$chunker, units=$units, overlap=$overlap, tenant=$tenant, inputForm=$inputForm, color=$color]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'preset_id'] = this.presetId;
      json[r'name'] = this.name;
      json[r'description'] = this.description;
      json[r'reader'] = this.reader;
      json[r'chunker'] = this.chunker;
      json[r'units'] = this.units;
      json[r'overlap'] = this.overlap;
      json[r'tenant'] = this.tenant;
      json[r'input_form'] = this.inputForm;
    if (this.color != null) {
      json[r'color'] = this.color;
    } else {
      json[r'color'] = null;
    }
    return json;
  }

  /// Returns a new [Preset] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Preset? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Preset[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Preset[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Preset(
        presetId: mapValueOfType<int>(json, r'preset_id')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
        reader: mapValueOfType<String>(json, r'reader')!,
        chunker: mapValueOfType<String>(json, r'chunker')!,
        units: mapValueOfType<int>(json, r'units')!,
        overlap: mapValueOfType<int>(json, r'overlap')!,
        tenant: mapValueOfType<String>(json, r'tenant')!,
        inputForm: mapValueOfType<String>(json, r'input_form')!,
        color: mapValueOfType<String>(json, r'color'),
      );
    }
    return null;
  }

  static List<Preset> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Preset>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Preset.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Preset> mapFromJson(dynamic json) {
    final map = <String, Preset>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Preset.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Preset-objects as value to a dart map
  static Map<String, List<Preset>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Preset>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Preset.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'preset_id',
    'name',
    'description',
    'reader',
    'chunker',
    'units',
    'overlap',
    'tenant',
    'input_form',
  };
}

