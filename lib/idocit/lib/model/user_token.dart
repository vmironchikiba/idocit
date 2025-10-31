//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UserToken {
  /// Returns a new [UserToken] instance.
  UserToken({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
  });

  String accessToken;

  String tokenType;

  String refreshToken;

  int expiresIn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UserToken &&
    other.accessToken == accessToken &&
    other.tokenType == tokenType &&
    other.refreshToken == refreshToken &&
    other.expiresIn == expiresIn;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accessToken.hashCode) +
    (tokenType.hashCode) +
    (refreshToken.hashCode) +
    (expiresIn.hashCode);

  @override
  String toString() => 'UserToken[accessToken=$accessToken, tokenType=$tokenType, refreshToken=$refreshToken, expiresIn=$expiresIn]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'access_token'] = this.accessToken;
      json[r'token_type'] = this.tokenType;
      json[r'refresh_token'] = this.refreshToken;
      json[r'expires_in'] = this.expiresIn;
    return json;
  }

  /// Returns a new [UserToken] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UserToken? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UserToken[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UserToken[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UserToken(
        accessToken: mapValueOfType<String>(json, r'access_token')!,
        tokenType: mapValueOfType<String>(json, r'token_type')!,
        refreshToken: mapValueOfType<String>(json, r'refresh_token')!,
        expiresIn: mapValueOfType<int>(json, r'expires_in')!,
      );
    }
    return null;
  }

  static List<UserToken> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserToken>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserToken.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UserToken> mapFromJson(dynamic json) {
    final map = <String, UserToken>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UserToken.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UserToken-objects as value to a dart map
  static Map<String, List<UserToken>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UserToken>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UserToken.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'access_token',
    'token_type',
    'refresh_token',
    'expires_in',
  };
}

