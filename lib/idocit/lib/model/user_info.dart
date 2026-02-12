//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserInfo {
  /// Returns a new [UserInfo] instance.
  UserInfo({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    required this.tenant,
    this.isOnedriveAuthorized,
    this.isApiKey,
    this.scopes = const [],
    this.groups = const [],
    this.groupIds = const [],
  });

  String id;

  String username;

  String email;

  String role;

  String tenant;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isOnedriveAuthorized;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isApiKey;

  List<String>? scopes;

  List<String> groups;

  List<String> groupIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserInfo &&
    other.id == id &&
    other.username == username &&
    other.email == email &&
    other.role == role &&
    other.tenant == tenant &&
    other.isOnedriveAuthorized == isOnedriveAuthorized &&
    other.isApiKey == isApiKey &&
    _deepEquality.equals(other.scopes, scopes) &&
    _deepEquality.equals(other.groups, groups) &&
    _deepEquality.equals(other.groupIds, groupIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (username.hashCode) +
    (email.hashCode) +
    (role.hashCode) +
    (tenant.hashCode) +
    (isOnedriveAuthorized == null ? 0 : isOnedriveAuthorized!.hashCode) +
    (isApiKey == null ? 0 : isApiKey!.hashCode) +
    (scopes == null ? 0 : scopes!.hashCode) +
    (groups.hashCode) +
    (groupIds.hashCode);

  @override
  String toString() => 'UserInfo[id=$id, username=$username, email=$email, role=$role, tenant=$tenant, isOnedriveAuthorized=$isOnedriveAuthorized, isApiKey=$isApiKey, scopes=$scopes, groups=$groups, groupIds=$groupIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'username'] = this.username;
      json[r'email'] = this.email;
      json[r'role'] = this.role;
      json[r'tenant'] = this.tenant;
    if (this.isOnedriveAuthorized != null) {
      json[r'is_onedrive_authorized'] = this.isOnedriveAuthorized;
    } else {
      json[r'is_onedrive_authorized'] = null;
    }
    if (this.isApiKey != null) {
      json[r'is_api_key'] = this.isApiKey;
    } else {
      json[r'is_api_key'] = null;
    }
    if (this.scopes != null) {
      json[r'scopes'] = this.scopes;
    } else {
      json[r'scopes'] = null;
    }
      json[r'groups'] = this.groups;
      json[r'group_ids'] = this.groupIds;
    return json;
  }

  /// Returns a new [UserInfo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserInfo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserInfo[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserInfo[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserInfo(
        id: mapValueOfType<String>(json, r'id')!,
        username: mapValueOfType<String>(json, r'username')!,
        email: mapValueOfType<String>(json, r'email')!,
        role: mapValueOfType<String>(json, r'role')!,
        tenant: mapValueOfType<String>(json, r'tenant')!,
        isOnedriveAuthorized: mapValueOfType<bool>(json, r'is_onedrive_authorized'),
        isApiKey: mapValueOfType<bool>(json, r'is_api_key'),
        scopes: json[r'scopes'] is Iterable
            ? (json[r'scopes'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        groups: json[r'groups'] is Iterable
            ? (json[r'groups'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        groupIds: json[r'group_ids'] is Iterable
            ? (json[r'group_ids'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<UserInfo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserInfo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserInfo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserInfo> mapFromJson(dynamic json) {
    final map = <String, UserInfo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserInfo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserInfo-objects as value to a dart map
  static Map<String, List<UserInfo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserInfo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserInfo.listFromJson(entry.value, growable: growable,);
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
  };
}

