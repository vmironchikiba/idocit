# idocit_client.api.DocTypeApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllDocTypesApiGetAllDocTypesGet**](DocTypeApi.md#getalldoctypesapigetalldoctypesget) | **GET** /api/get_all_doc_types | Get All Doc Types


# **getAllDocTypesApiGetAllDocTypesGet**
> Object getAllDocTypesApiGetAllDocTypesGet()

Get All Doc Types

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocTypeApi();

try {
    final result = api_instance.getAllDocTypesApiGetAllDocTypesGet();
    print(result);
} catch (e) {
    print('Exception when calling DocTypeApi->getAllDocTypesApiGetAllDocTypesGet: $e\n');
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

