//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class FeedbackPayload {
  /// Returns a new [FeedbackPayload] instance.
  FeedbackPayload({
    required this.traceId,
    required this.satisfaction,
    this.comment,
  });

  String traceId;

  int satisfaction;

  String? comment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is FeedbackPayload &&
    other.traceId == traceId &&
    other.satisfaction == satisfaction &&
    other.comment == comment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (traceId.hashCode) +
    (satisfaction.hashCode) +
    (comment == null ? 0 : comment!.hashCode);

  @override
  String toString() => 'FeedbackPayload[traceId=$traceId, satisfaction=$satisfaction, comment=$comment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'trace_id'] = this.traceId;
      json[r'satisfaction'] = this.satisfaction;
    if (this.comment != null) {
      json[r'comment'] = this.comment;
    } else {
      json[r'comment'] = null;
    }
    return json;
  }

  /// Returns a new [FeedbackPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static FeedbackPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "FeedbackPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "FeedbackPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return FeedbackPayload(
        traceId: mapValueOfType<String>(json, r'trace_id')!,
        satisfaction: mapValueOfType<int>(json, r'satisfaction')!,
        comment: mapValueOfType<String>(json, r'comment'),
      );
    }
    return null;
  }

  static List<FeedbackPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FeedbackPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FeedbackPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, FeedbackPayload> mapFromJson(dynamic json) {
    final map = <String, FeedbackPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = FeedbackPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of FeedbackPayload-objects as value to a dart map
  static Map<String, List<FeedbackPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<FeedbackPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = FeedbackPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'trace_id',
    'satisfaction',
  };
}

