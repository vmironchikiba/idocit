# idocit_client.api.CategoryApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createCategoryApiCategoriesPost**](CategoryApi.md#createcategoryapicategoriespost) | **POST** /api/categories | Create Category
[**deleteCategoriesApiCategoriesDelete**](CategoryApi.md#deletecategoriesapicategoriesdelete) | **DELETE** /api/categories | Delete Categories
[**getCategoriesApiCategoriesGet**](CategoryApi.md#getcategoriesapicategoriesget) | **GET** /api/categories | Get Categories
[**getCategoryApiCategoriesCategoryIdGet**](CategoryApi.md#getcategoryapicategoriescategoryidget) | **GET** /api/categories/{category_id} | Get Category
[**updateCategoryApiCategoriesCategoryIdPut**](CategoryApi.md#updatecategoryapicategoriescategoryidput) | **PUT** /api/categories/{category_id} | Update Category


# **createCategoryApiCategoriesPost**
> Object createCategoryApiCategoriesPost(createCategoryPayload)

Create Category

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryApi();
final createCategoryPayload = CreateCategoryPayload(); // CreateCategoryPayload | 

try {
    final result = api_instance.createCategoryApiCategoriesPost(createCategoryPayload);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->createCategoryApiCategoriesPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createCategoryPayload** | [**CreateCategoryPayload**](CreateCategoryPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteCategoriesApiCategoriesDelete**
> Object deleteCategoriesApiCategoriesDelete(deleteCategoriesPayload)

Delete Categories

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryApi();
final deleteCategoriesPayload = DeleteCategoriesPayload(); // DeleteCategoriesPayload | 

try {
    final result = api_instance.deleteCategoriesApiCategoriesDelete(deleteCategoriesPayload);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->deleteCategoriesApiCategoriesDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteCategoriesPayload** | [**DeleteCategoriesPayload**](DeleteCategoriesPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCategoriesApiCategoriesGet**
> Object getCategoriesApiCategoriesGet()

Get Categories

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryApi();

try {
    final result = api_instance.getCategoriesApiCategoriesGet();
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->getCategoriesApiCategoriesGet: $e\n');
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

# **getCategoryApiCategoriesCategoryIdGet**
> Object getCategoryApiCategoriesCategoryIdGet(categoryId)

Get Category

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryApi();
final categoryId = 56; // int | 

try {
    final result = api_instance.getCategoryApiCategoriesCategoryIdGet(categoryId);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->getCategoryApiCategoriesCategoryIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateCategoryApiCategoriesCategoryIdPut**
> Object updateCategoryApiCategoriesCategoryIdPut(categoryId, updateCategoryPayload)

Update Category

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = CategoryApi();
final categoryId = 56; // int | 
final updateCategoryPayload = UpdateCategoryPayload(); // UpdateCategoryPayload | 

try {
    final result = api_instance.updateCategoryApiCategoriesCategoryIdPut(categoryId, updateCategoryPayload);
    print(result);
} catch (e) {
    print('Exception when calling CategoryApi->updateCategoryApiCategoriesCategoryIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **categoryId** | **int**|  | 
 **updateCategoryPayload** | [**UpdateCategoryPayload**](UpdateCategoryPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

