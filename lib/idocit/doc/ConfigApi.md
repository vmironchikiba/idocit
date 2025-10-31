# idocit_client.api.ConfigApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getGlobalConfigApiAdminConfigsGet**](ConfigApi.md#getglobalconfigapiadminconfigsget) | **GET** /api/admin/configs | Get Global Config
[**saveGlobalConfigApiAdminConfigsPost**](ConfigApi.md#saveglobalconfigapiadminconfigspost) | **POST** /api/admin/configs | Save Global Config


# **getGlobalConfigApiAdminConfigsGet**
> Object getGlobalConfigApiAdminConfigsGet()

Get Global Config

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ConfigApi();

try {
    final result = api_instance.getGlobalConfigApiAdminConfigsGet();
    print(result);
} catch (e) {
    print('Exception when calling ConfigApi->getGlobalConfigApiAdminConfigsGet: $e\n');
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

# **saveGlobalConfigApiAdminConfigsPost**
> Object saveGlobalConfigApiAdminConfigsPost(saveGlobalConfigPayload)

Save Global Config

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ConfigApi();
final saveGlobalConfigPayload = SaveGlobalConfigPayload(); // SaveGlobalConfigPayload | 

try {
    final result = api_instance.saveGlobalConfigApiAdminConfigsPost(saveGlobalConfigPayload);
    print(result);
} catch (e) {
    print('Exception when calling ConfigApi->saveGlobalConfigApiAdminConfigsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **saveGlobalConfigPayload** | [**SaveGlobalConfigPayload**](SaveGlobalConfigPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

