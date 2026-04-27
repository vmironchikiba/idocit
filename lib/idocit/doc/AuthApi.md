# idocit_client.api.AuthApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**loginApiLoginPost**](AuthApi.md#loginapiloginpost) | **POST** /api/v1/auth/login | Login
[**logoutApiLogoutPost**](AuthApi.md#logoutapilogoutpost) | **POST** /api/v1/auth/logout | Logout
[**refreshApiTokenRefreshPost**](AuthApi.md#refreshapitokenrefreshpost) | **POST** /api/v1/auth/refresh | Refresh
[**tokenStatusApiTokenStatusGet**](AuthApi.md#tokenstatusapitokenstatusget) | **GET** /api/token/status | Token Status


# **loginApiLoginPost**
> UserToken loginApiLoginPost(bodyLoginApiLoginPost)

Login

Handles user login. Accepts form data with `username` and `password`.

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = AuthApi();
final bodyLoginApiLoginPost = BodyLoginApiLoginPost(); // BodyLoginApiLoginPost | 

try {
    final result = api_instance.loginApiLoginPost(bodyLoginApiLoginPost);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->loginApiLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **bodyLoginApiLoginPost** | [**BodyLoginApiLoginPost**](BodyLoginApiLoginPost.md)|  | 

### Return type

[**UserToken**](UserToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logoutApiLogoutPost**
> String logoutApiLogoutPost(logoutRequest)

Logout

Handles user logout.

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = AuthApi();
final logoutRequest = LogoutRequest(); // LogoutRequest | 

try {
    final result = api_instance.logoutApiLogoutPost(logoutRequest);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->logoutApiLogoutPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **logoutRequest** | [**LogoutRequest**](LogoutRequest.md)|  | 

### Return type

**String**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshApiTokenRefreshPost**
> UserToken refreshApiTokenRefreshPost(refreshTokenRequest)

Refresh

Refresh access token using a Bearer refresh token in the Authorization header.  Expects header:  Authorization: Bearer <refresh_token> Returns: UserToken JSON (access_token, token_type, refresh_token, expires_in)

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = AuthApi();
final refreshTokenRequest = RefreshTokenRequest(); // RefreshTokenRequest | 

try {
    final result = api_instance.refreshApiTokenRefreshPost(refreshTokenRequest);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->refreshApiTokenRefreshPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **refreshTokenRequest** | [**RefreshTokenRequest**](RefreshTokenRequest.md)|  | [optional] 

### Return type

[**UserToken**](UserToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tokenStatusApiTokenStatusGet**
> Object tokenStatusApiTokenStatusGet()

Token Status

Return validity info for a presented access token.  Authorization: Bearer <access_token> Response: {\"active\": bool, \"exp\": <int>|None, ...} Returns 401 if header missing or malformed.

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AuthApi();

try {
    final result = api_instance.tokenStatusApiTokenStatusGet();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->tokenStatusApiTokenStatusGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

