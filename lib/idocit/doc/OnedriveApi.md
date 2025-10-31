# idocit_client.api.OnedriveApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authorizeApiOnedriveAuthUriGet**](OnedriveApi.md#authorizeapionedriveauthuriget) | **GET** /api/onedrive/auth_uri | Authorize
[**callbackApiOnedriveAuthCallbackGet**](OnedriveApi.md#callbackapionedriveauthcallbackget) | **GET** /api/onedrive/auth/callback | Callback
[**onedriveReadFilesApiOnedriveReadFilesPost**](OnedriveApi.md#onedrivereadfilesapionedrivereadfilespost) | **POST** /api/onedrive/read_files | Onedrive Read Files


# **authorizeApiOnedriveAuthUriGet**
> Object authorizeApiOnedriveAuthUriGet(redirectUrl)

Authorize

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OnedriveApi();
final redirectUrl = redirectUrl_example; // String | 

try {
    final result = api_instance.authorizeApiOnedriveAuthUriGet(redirectUrl);
    print(result);
} catch (e) {
    print('Exception when calling OnedriveApi->authorizeApiOnedriveAuthUriGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **redirectUrl** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **callbackApiOnedriveAuthCallbackGet**
> Object callbackApiOnedriveAuthCallbackGet(state)

Callback

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = OnedriveApi();
final state = state_example; // String | 

try {
    final result = api_instance.callbackApiOnedriveAuthCallbackGet(state);
    print(result);
} catch (e) {
    print('Exception when calling OnedriveApi->callbackApiOnedriveAuthCallbackGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **state** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **onedriveReadFilesApiOnedriveReadFilesPost**
> Object onedriveReadFilesApiOnedriveReadFilesPost(oneDriveReadFilesPayload)

Onedrive Read Files

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OnedriveApi();
final oneDriveReadFilesPayload = OneDriveReadFilesPayload(); // OneDriveReadFilesPayload | 

try {
    final result = api_instance.onedriveReadFilesApiOnedriveReadFilesPost(oneDriveReadFilesPayload);
    print(result);
} catch (e) {
    print('Exception when calling OnedriveApi->onedriveReadFilesApiOnedriveReadFilesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **oneDriveReadFilesPayload** | [**OneDriveReadFilesPayload**](OneDriveReadFilesPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

