# idocit_client.api.DocumentApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteDocumentApiDeleteDocumentPost**](DocumentApi.md#deletedocumentapideletedocumentpost) | **POST** /api/delete_document | Delete Document
[**deleteDocumentsApiDeleteDocumentsPost**](DocumentApi.md#deletedocumentsapideletedocumentspost) | **POST** /api/delete_documents | Delete Documents
[**getAllDocumentsAdminApiAdminGetAllDocumentsPost**](DocumentApi.md#getalldocumentsadminapiadmingetalldocumentspost) | **POST** /api/admin/get_all_documents | Get All Documents Admin
[**getAllDocumentsApiGetAllDocumentsPost**](DocumentApi.md#getalldocumentsapigetalldocumentspost) | **POST** /api/get_all_documents | Get All Documents
[**getDocumentApiGetDocumentPost**](DocumentApi.md#getdocumentapigetdocumentpost) | **POST** /api/get_document | Get Document
[**searchDocumentsApiSearchDocumentsPost**](DocumentApi.md#searchdocumentsapisearchdocumentspost) | **POST** /api/search_documents | Search Documents
[**updateDocumentsApiDocumentsPut**](DocumentApi.md#updatedocumentsapidocumentsput) | **PUT** /api/documents | Update Documents


# **deleteDocumentApiDeleteDocumentPost**
> Object deleteDocumentApiDeleteDocumentPost(getDocumentPayload)

Delete Document

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocumentApi();
final getDocumentPayload = GetDocumentPayload(); // GetDocumentPayload | 

try {
    final result = api_instance.deleteDocumentApiDeleteDocumentPost(getDocumentPayload);
    print(result);
} catch (e) {
    print('Exception when calling DocumentApi->deleteDocumentApiDeleteDocumentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **getDocumentPayload** | [**GetDocumentPayload**](GetDocumentPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteDocumentsApiDeleteDocumentsPost**
> Object deleteDocumentsApiDeleteDocumentsPost(deleteDocumentsPayload)

Delete Documents

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocumentApi();
final deleteDocumentsPayload = DeleteDocumentsPayload(); // DeleteDocumentsPayload | 

try {
    final result = api_instance.deleteDocumentsApiDeleteDocumentsPost(deleteDocumentsPayload);
    print(result);
} catch (e) {
    print('Exception when calling DocumentApi->deleteDocumentsApiDeleteDocumentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteDocumentsPayload** | [**DeleteDocumentsPayload**](DeleteDocumentsPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllDocumentsAdminApiAdminGetAllDocumentsPost**
> Object getAllDocumentsAdminApiAdminGetAllDocumentsPost()

Get All Documents Admin

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocumentApi();

try {
    final result = api_instance.getAllDocumentsAdminApiAdminGetAllDocumentsPost();
    print(result);
} catch (e) {
    print('Exception when calling DocumentApi->getAllDocumentsAdminApiAdminGetAllDocumentsPost: $e\n');
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

# **getAllDocumentsApiGetAllDocumentsPost**
> Object getAllDocumentsApiGetAllDocumentsPost()

Get All Documents

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocumentApi();

try {
    final result = api_instance.getAllDocumentsApiGetAllDocumentsPost();
    print(result);
} catch (e) {
    print('Exception when calling DocumentApi->getAllDocumentsApiGetAllDocumentsPost: $e\n');
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

# **getDocumentApiGetDocumentPost**
> Object getDocumentApiGetDocumentPost(getDocumentPayload)

Get Document

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocumentApi();
final getDocumentPayload = GetDocumentPayload(); // GetDocumentPayload | 

try {
    final result = api_instance.getDocumentApiGetDocumentPost(getDocumentPayload);
    print(result);
} catch (e) {
    print('Exception when calling DocumentApi->getDocumentApiGetDocumentPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **getDocumentPayload** | [**GetDocumentPayload**](GetDocumentPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchDocumentsApiSearchDocumentsPost**
> Object searchDocumentsApiSearchDocumentsPost(searchQueryPayload)

Search Documents

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocumentApi();
final searchQueryPayload = SearchQueryPayload(); // SearchQueryPayload | 

try {
    final result = api_instance.searchDocumentsApiSearchDocumentsPost(searchQueryPayload);
    print(result);
} catch (e) {
    print('Exception when calling DocumentApi->searchDocumentsApiSearchDocumentsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **searchQueryPayload** | [**SearchQueryPayload**](SearchQueryPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateDocumentsApiDocumentsPut**
> Object updateDocumentsApiDocumentsPut(updateDocumentsPayload)

Update Documents

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DocumentApi();
final updateDocumentsPayload = UpdateDocumentsPayload(); // UpdateDocumentsPayload | 

try {
    final result = api_instance.updateDocumentsApiDocumentsPut(updateDocumentsPayload);
    print(result);
} catch (e) {
    print('Exception when calling DocumentApi->updateDocumentsApiDocumentsPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateDocumentsPayload** | [**UpdateDocumentsPayload**](UpdateDocumentsPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

