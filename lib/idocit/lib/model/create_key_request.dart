//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateKeyRequest {
  /// Returns a new [CreateKeyRequest] instance.
  CreateKeyRequest({
    required this.tenant,
    this.role = 'user',
    this.scopes = const [],
    this.expiresInDays,
    this.test = false,
  });

  String tenant;

  String role;

  List<String>? scopes;

  int? expiresInDays;

  bool test;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateKeyRequest &&
    other.tenant == tenant &&
    other.role == role &&
    _deepEquality.equals(other.scopes, scopes) &&
    other.expiresInDays == expiresInDays &&
    other.test == test;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (tenant.hashCode) +
    (role.hashCode) +
    (scopes == null ? 0 : scopes!.hashCode) +
    (expiresInDays == null ? 0 : expiresInDays!.hashCode) +
    (test.hashCode);

  @override
  String toString() => 'CreateKeyRequest[tenant=$tenant, role=$role, scopes=$scopes, expiresInDays=$expiresInDays, test=$test]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'tenant'] = this.tenant;
      json[r'role'] = this.role;
    if (this.scopes != null) {
      json[r'scopes'] = this.scopes;
    } else {
      json[r'scopes'] = null;
    }
    if (this.expiresInDays != null) {
      json[r'expires_in_days'] = this.expiresInDays;
    } else {
      json[r'expires_in_days'] = null;
    }
      json[r'test'] = this.test;
    return json;
  }

  /// Returns a new [CreateKeyRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateKeyRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateKeyRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateKeyRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateKeyRequest(
        tenant: mapValueOfType<String>(json, r'tenant')!,
        role: mapValueOfType<String>(json, r'role') ?? 'user',
        scopes: json[r'scopes'] is Iterable
            ? (json[r'scopes'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        expiresInDays: mapValueOfType<int>(json, r'expires_in_days'),
        test: mapValueOfType<bool>(json, r'test') ?? false,
      );
    }
    return null;
  }

  static List<CreateKeyRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateKeyRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateKeyRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateKeyRequest> mapFromJson(dynamic json) {
    final map = <String, CreateKeyRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateKeyRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateKeyRequest-objects as value to a dart map
  static Map<String, List<CreateKeyRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateKeyRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateKeyRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'tenant',
  };
}

