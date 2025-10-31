//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:idocit_client/api.dart';
import 'package:test/test.dart';


/// tests for AuthApi
void main() {
  // final instance = AuthApi();

  group('tests for AuthApi', () {
    // Login
    //
    // Handles user login. Accepts form data with `username` and `password`.
    //
    //Future<UserToken> loginApiLoginPost(String username, String password, { String grantType, String scope, String clientId, String clientSecret }) async
    test('test loginApiLoginPost', () async {
      // TODO
    });

    // Logout
    //
    // Handles user logout.
    //
    //Future<Object> logoutApiLogoutPost(LogoutRequest logoutRequest) async
    test('test logoutApiLogoutPost', () async {
      // TODO
    });

    // Refresh
    //
    // Refresh access token using a Bearer refresh token in the Authorization header.  Expects header:  Authorization: Bearer <refresh_token> Returns: UserToken JSON (access_token, token_type, refresh_token, expires_in)
    //
    //Future<Object> refreshApiTokenRefreshPost({ RefreshTokenRequest refreshTokenRequest }) async
    test('test refreshApiTokenRefreshPost', () async {
      // TODO
    });

    // Token Status
    //
    // Return validity info for a presented access token.  Authorization: Bearer <access_token> Response: {\"active\": bool, \"exp\": <int>|None, ...} Returns 401 if header missing or malformed.
    //
    //Future<Object> tokenStatusApiTokenStatusGet() async
    test('test tokenStatusApiTokenStatusGet', () async {
      // TODO
    });

  });
}
