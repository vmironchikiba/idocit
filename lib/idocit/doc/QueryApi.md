# idocit_client.api.QueryApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminQueryApiAdminQueryPost**](QueryApi.md#adminqueryapiadminquerypost) | **POST** /api/admin/query | Admin Query
[**queryApiQueryPost**](QueryApi.md#queryapiquerypost) | **POST** /api/query | Query


# **adminQueryApiAdminQueryPost**
> Object adminQueryApiAdminQueryPost(adminQueryPayload)

Admin Query

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = QueryApi();
final adminQueryPayload = AdminQueryPayload(); // AdminQueryPayload | 

try {
    final result = api_instance.adminQueryApiAdminQueryPost(adminQueryPayload);
    print(result);
} catch (e) {
    print('Exception when calling QueryApi->adminQueryApiAdminQueryPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminQueryPayload** | [**AdminQueryPayload**](AdminQueryPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **queryApiQueryPost**
> Object queryApiQueryPost(queryPayload)

Query

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = QueryApi();
final queryPayload = QueryPayload(); // QueryPayload | 

try {
    final result = api_instance.queryApiQueryPost(queryPayload);
    print(result);
} catch (e) {
    print('Exception when calling QueryApi->queryApiQueryPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queryPayload** | [**QueryPayload**](QueryPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

