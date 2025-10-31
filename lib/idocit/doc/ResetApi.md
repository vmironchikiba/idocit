# idocit_client.api.ResetApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**resetCacheApiResetCacheGet**](ResetApi.md#resetcacheapiresetcacheget) | **GET** /api/reset_cache | Reset Cache
[**resetSchemaApiAdminResetSchemaPost**](ResetApi.md#resetschemaapiadminresetschemapost) | **POST** /api/admin/reset_schema | Reset Schema
[**resetVerbaApiResetGet**](ResetApi.md#resetverbaapiresetget) | **GET** /api/reset | Reset Verba


# **resetCacheApiResetCacheGet**
> Object resetCacheApiResetCacheGet()

Reset Cache

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ResetApi();

try {
    final result = api_instance.resetCacheApiResetCacheGet();
    print(result);
} catch (e) {
    print('Exception when calling ResetApi->resetCacheApiResetCacheGet: $e\n');
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

# **resetSchemaApiAdminResetSchemaPost**
> Object resetSchemaApiAdminResetSchemaPost(resetSchemaPayload)

Reset Schema

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ResetApi();
final resetSchemaPayload = ResetSchemaPayload(); // ResetSchemaPayload | 

try {
    final result = api_instance.resetSchemaApiAdminResetSchemaPost(resetSchemaPayload);
    print(result);
} catch (e) {
    print('Exception when calling ResetApi->resetSchemaApiAdminResetSchemaPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetSchemaPayload** | [**ResetSchemaPayload**](ResetSchemaPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **resetVerbaApiResetGet**
> Object resetVerbaApiResetGet()

Reset Verba

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ResetApi();

try {
    final result = api_instance.resetVerbaApiResetGet();
    print(result);
} catch (e) {
    print('Exception when calling ResetApi->resetVerbaApiResetGet: $e\n');
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

