# idocit_client.api.CategoryTypeApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getCategoryTypesApiCategoryTypesGet**](CategoryTypeApi.md#getcategorytypesapicategorytypesget) | **GET** /api/category-types | Get Category Types


# **getCategoryTypesApiCategoryTypesGet**
> Object getCategoryTypesApiCategoryTypesGet()

Get Category Types

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = CategoryTypeApi();

try {
    final result = api_instance.getCategoryTypesApiCategoryTypesGet();
    print(result);
} catch (e) {
    print('Exception when calling CategoryTypeApi->getCategoryTypesApiCategoryTypesGet: $e\n');
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

