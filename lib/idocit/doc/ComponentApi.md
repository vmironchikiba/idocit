# idocit_client.api.ComponentApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getComponentApiGetComponentPost**](ComponentApi.md#getcomponentapigetcomponentpost) | **POST** /api/get_component | Get Component
[**getComponentsApiComponentsGet**](ComponentApi.md#getcomponentsapicomponentsget) | **GET** /api/components | Get Components
[**setComponentApiComponentsPost**](ComponentApi.md#setcomponentapicomponentspost) | **POST** /api/components | Set Component


# **getComponentApiGetComponentPost**
> Object getComponentApiGetComponentPost(getComponentPayload)

Get Component

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ComponentApi();
final getComponentPayload = GetComponentPayload(); // GetComponentPayload | 

try {
    final result = api_instance.getComponentApiGetComponentPost(getComponentPayload);
    print(result);
} catch (e) {
    print('Exception when calling ComponentApi->getComponentApiGetComponentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **getComponentPayload** | [**GetComponentPayload**](GetComponentPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getComponentsApiComponentsGet**
> ComponentConfig getComponentsApiComponentsGet()

Get Components

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ComponentApi();

try {
    final result = api_instance.getComponentsApiComponentsGet();
    print(result);
} catch (e) {
    print('Exception when calling ComponentApi->getComponentsApiComponentsGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ComponentConfig**](ComponentConfig.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **setComponentApiComponentsPost**
> Object setComponentApiComponentsPost(setComponentPayload)

Set Component

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ComponentApi();
final setComponentPayload = SetComponentPayload(); // SetComponentPayload | 

try {
    final result = api_instance.setComponentApiComponentsPost(setComponentPayload);
    print(result);
} catch (e) {
    print('Exception when calling ComponentApi->setComponentApiComponentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **setComponentPayload** | [**SetComponentPayload**](SetComponentPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

