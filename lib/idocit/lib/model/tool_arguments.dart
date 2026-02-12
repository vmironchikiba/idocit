//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ToolArguments {
  /// Returns a new [ToolArguments] instance.
  ToolArguments({
    this.type,
    this.data = const [],
    this.node,
    this.traceId,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? type;

  List<Object> data;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? node;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? traceId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToolArguments &&
          other.type == type &&
          _deepEquality.equals(other.data, data) &&
          other.node == node &&
          other.traceId == traceId;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (type == null ? 0 : type!.hashCode) +
      (data.hashCode) +
      (node == null ? 0 : node!.hashCode) +
      (traceId == null ? 0 : traceId!.hashCode);

  @override
  String toString() => 'ToolArguments[type=$type, data=$data, node=$node, traceId=$traceId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    json[r'data'] = this.data;
    if (this.node != null) {
      json[r'node'] = this.node;
    } else {
      json[r'node'] = null;
    }
    if (this.traceId != null) {
      json[r'trace_id'] = this.traceId;
    } else {
      json[r'trace_id'] = null;
    }
    return json;
  }

  /// Returns a new [ToolArguments] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ToolArguments? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ToolArguments[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ToolArguments[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ToolArguments(
        type: mapValueOfType<String>(json, r'type'),
        data: (json[r'data'] as List<Object>), // Object.listFromJson(json[r'data']),
        node: mapValueOfType<String>(json, r'node'),
        traceId: mapValueOfType<String>(json, r'trace_id'),
      );
    }
    return null;
  }

  static List<ToolArguments> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ToolArguments>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ToolArguments.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ToolArguments> mapFromJson(dynamic json) {
    final map = <String, ToolArguments>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ToolArguments.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ToolArguments-objects as value to a dart map
  static Map<String, List<ToolArguments>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<ToolArguments>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ToolArguments.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}
