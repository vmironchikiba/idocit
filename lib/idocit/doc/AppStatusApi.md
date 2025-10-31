# idocit_client.api.AppStatusApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getProductionApiGetProductionGet**](AppStatusApi.md#getproductionapigetproductionget) | **GET** /api/get_production | Get Production
[**getStatusApiGetStatusGet**](AppStatusApi.md#getstatusapigetstatusget) | **GET** /api/get_status | Get Status


# **getProductionApiGetProductionGet**
> Object getProductionApiGetProductionGet()

Get Production

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = AppStatusApi();

try {
    final result = api_instance.getProductionApiGetProductionGet();
    print(result);
} catch (e) {
    print('Exception when calling AppStatusApi->getProductionApiGetProductionGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getStatusApiGetStatusGet**
> Object getStatusApiGetStatusGet()

Get Status

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = AppStatusApi();

try {
    final result = api_instance.getStatusApiGetStatusGet();
    print(result);
} catch (e) {
    print('Exception when calling AppStatusApi->getStatusApiGetStatusGet: $e\n');
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

