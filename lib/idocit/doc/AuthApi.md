# idocit_client.api.AuthApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**loginApiLoginPost**](AuthApi.md#loginapiloginpost) | **POST** /api/login | Login
[**logoutApiLogoutPost**](AuthApi.md#logoutapilogoutpost) | **POST** /api/logout | Logout
[**refreshApiTokenRefreshPost**](AuthApi.md#refreshapitokenrefreshpost) | **POST** /api/token/refresh | Refresh
[**tokenStatusApiTokenStatusGet**](AuthApi.md#tokenstatusapitokenstatusget) | **GET** /api/token/status | Token Status


# **loginApiLoginPost**
> UserToken loginApiLoginPost(username, password, grantType, scope, clientId, clientSecret)

Login

Handles user login. Accepts form data with `username` and `password`.

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = AuthApi();
final username = username_example; // String | 
final password = password_example; // String | 
final grantType = grantType_example; // String | 
final scope = scope_example; // String | 
final clientId = clientId_example; // String | 
final clientSecret = clientSecret_example; // String | 

try {
    final result = api_instance.loginApiLoginPost(username, password, grantType, scope, clientId, clientSecret);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->loginApiLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | **String**|  | 
 **password** | **String**|  | 
 **grantType** | **String**|  | [optional] 
 **scope** | **String**|  | [optional] [default to '']
 **clientId** | **String**|  | [optional] 
 **clientSecret** | **String**|  | [optional] 

### Return type

[**UserToken**](UserToken.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/x-www-form-urlencoded
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **logoutApiLogoutPost**
> Object logoutApiLogoutPost(logoutRequest)

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

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **refreshApiTokenRefreshPost**
> Object refreshApiTokenRefreshPost(refreshTokenRequest)

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

[**Object**](Object.md)

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

