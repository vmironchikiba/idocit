# idocit_client.api.UsersApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**readCurrentUserApiUsersMeGet**](UsersApi.md#readcurrentuserapiusersmeget) | **GET** /api/users/me | Read Current User


# **readCurrentUserApiUsersMeGet**
> KeycloakUser readCurrentUserApiUsersMeGet()

Read Current User

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = UsersApi();

try {
    final result = api_instance.readCurrentUserApiUsersMeGet();
    print(result);
} catch (e) {
    print('Exception when calling UsersApi->readCurrentUserApiUsersMeGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**KeycloakUser**](KeycloakUser.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

