# idocit_client.api.ImportExportApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminExportDataApiAdminExportGet**](ImportExportApi.md#adminexportdataapiadminexportget) | **GET** /api/admin/export | Admin Export Data
[**adminImportDataApiAdminImportPost**](ImportExportApi.md#adminimportdataapiadminimportpost) | **POST** /api/admin/import | Admin Import Data


# **adminExportDataApiAdminExportGet**
> adminExportDataApiAdminExportGet()

Admin Export Data

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ImportExportApi();

try {
    api_instance.adminExportDataApiAdminExportGet();
} catch (e) {
    print('Exception when calling ImportExportApi->adminExportDataApiAdminExportGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/zip

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **adminImportDataApiAdminImportPost**
> Object adminImportDataApiAdminImportPost(file)

Admin Import Data

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ImportExportApi();
final file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.adminImportDataApiAdminImportPost(file);
    print(result);
} catch (e) {
    print('Exception when calling ImportExportApi->adminImportDataApiAdminImportPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

