//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BodyLoginApiLoginPost {
  /// Returns a new [BodyLoginApiLoginPost] instance.
  BodyLoginApiLoginPost({
    this.grantType,
    required this.username,
    required this.password,
    this.scope = '',
    this.clientId,
    this.clientSecret,
  });

  String? grantType;

  String username;

  String password;

  String scope;

  String? clientId;

  String? clientSecret;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BodyLoginApiLoginPost &&
    other.grantType == grantType &&
    other.username == username &&
    other.password == password &&
    other.scope == scope &&
    other.clientId == clientId &&
    other.clientSecret == clientSecret;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (grantType == null ? 0 : grantType!.hashCode) +
    (username.hashCode) +
    (password.hashCode) +
    (scope.hashCode) +
    (clientId == null ? 0 : clientId!.hashCode) +
    (clientSecret == null ? 0 : clientSecret!.hashCode);

  @override
  String toString() => 'BodyLoginApiLoginPost[grantType=$grantType, username=$username, password=$password, scope=$scope, clientId=$clientId, clientSecret=$clientSecret]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.grantType != null) {
      json[r'grant_type'] = this.grantType;
    } else {
      json[r'grant_type'] = null;
    }
      json[r'username'] = this.username;
      json[r'password'] = this.password;
      json[r'scope'] = this.scope;
    if (this.clientId != null) {
      json[r'client_id'] = this.clientId;
    } else {
      json[r'client_id'] = null;
    }
    if (this.clientSecret != null) {
      json[r'client_secret'] = this.clientSecret;
    } else {
      json[r'client_secret'] = null;
    }
    return json;
  }

  /// Returns a new [BodyLoginApiLoginPost] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BodyLoginApiLoginPost? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BodyLoginApiLoginPost[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BodyLoginApiLoginPost[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BodyLoginApiLoginPost(
        grantType: mapValueOfType<String>(json, r'grant_type'),
        username: mapValueOfType<String>(json, r'username')!,
        password: mapValueOfType<String>(json, r'password')!,
        scope: mapValueOfType<String>(json, r'scope') ?? '',
        clientId: mapValueOfType<String>(json, r'client_id'),
        clientSecret: mapValueOfType<String>(json, r'client_secret'),
      );
    }
    return null;
  }

  static List<BodyLoginApiLoginPost> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BodyLoginApiLoginPost>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BodyLoginApiLoginPost.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BodyLoginApiLoginPost> mapFromJson(dynamic json) {
    final map = <String, BodyLoginApiLoginPost>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BodyLoginApiLoginPost.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BodyLoginApiLoginPost-objects as value to a dart map
  static Map<String, List<BodyLoginApiLoginPost>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BodyLoginApiLoginPost>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BodyLoginApiLoginPost.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'username',
    'password',
  };
}

