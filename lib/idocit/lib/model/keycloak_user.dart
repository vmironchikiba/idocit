//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class KeycloakUser {
  /// Returns a new [KeycloakUser] instance.
  KeycloakUser({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.tenant,
    required this.isOnedriveAuthorized,
  });

  String id;

  String username;

  String? email;

  String role;

  String tenant;

  bool? isOnedriveAuthorized;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KeycloakUser &&
    other.id == id &&
    other.username == username &&
    other.email == email &&
    other.role == role &&
    other.tenant == tenant &&
    other.isOnedriveAuthorized == isOnedriveAuthorized;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (username.hashCode) +
    (email == null ? 0 : email!.hashCode) +
    (role.hashCode) +
    (tenant.hashCode) +
    (isOnedriveAuthorized == null ? 0 : isOnedriveAuthorized!.hashCode);

  @override
  String toString() => 'KeycloakUser[id=$id, username=$username, email=$email, role=$role, tenant=$tenant, isOnedriveAuthorized=$isOnedriveAuthorized]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'username'] = this.username;
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
      json[r'role'] = this.role;
      json[r'tenant'] = this.tenant;
    if (this.isOnedriveAuthorized != null) {
      json[r'is_onedrive_authorized'] = this.isOnedriveAuthorized;
    } else {
      json[r'is_onedrive_authorized'] = null;
    }
    return json;
  }

  /// Returns a new [KeycloakUser] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static KeycloakUser? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "KeycloakUser[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "KeycloakUser[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return KeycloakUser(
        id: mapValueOfType<String>(json, r'id')!,
        username: mapValueOfType<String>(json, r'username')!,
        email: mapValueOfType<String>(json, r'email'),
        role: mapValueOfType<String>(json, r'role')!,
        tenant: mapValueOfType<String>(json, r'tenant')!,
        isOnedriveAuthorized: mapValueOfType<bool>(json, r'is_onedrive_authorized'),
      );
    }
    return null;
  }

  static List<KeycloakUser> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <KeycloakUser>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = KeycloakUser.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, KeycloakUser> mapFromJson(dynamic json) {
    final map = <String, KeycloakUser>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = KeycloakUser.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of KeycloakUser-objects as value to a dart map
  static Map<String, List<KeycloakUser>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<KeycloakUser>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = KeycloakUser.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'username',
    'email',
    'role',
    'tenant',
    'is_onedrive_authorized',
  };
}

