# idocit_client.api.PresetApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createPresetApiPresetsPost**](PresetApi.md#createpresetapipresetspost) | **POST** /api/presets | Create Preset
[**deletePresetsApiPresetsDelete**](PresetApi.md#deletepresetsapipresetsdelete) | **DELETE** /api/presets | Delete Presets
[**getAllPresetsApiPresetsGet**](PresetApi.md#getallpresetsapipresetsget) | **GET** /api/presets | Get All Presets
[**getPresetApiPresetsPresetIdGet**](PresetApi.md#getpresetapipresetspresetidget) | **GET** /api/presets/{preset_id} | Get Preset
[**updatePresetApiPresetsPresetIdPut**](PresetApi.md#updatepresetapipresetspresetidput) | **PUT** /api/presets/{preset_id} | Update Preset


# **createPresetApiPresetsPost**
> Object createPresetApiPresetsPost(createPresetPayload)

Create Preset

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PresetApi();
final createPresetPayload = CreatePresetPayload(); // CreatePresetPayload | 

try {
    final result = api_instance.createPresetApiPresetsPost(createPresetPayload);
    print(result);
} catch (e) {
    print('Exception when calling PresetApi->createPresetApiPresetsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createPresetPayload** | [**CreatePresetPayload**](CreatePresetPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deletePresetsApiPresetsDelete**
> Object deletePresetsApiPresetsDelete(deletePresetsPayload)

Delete Presets

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PresetApi();
final deletePresetsPayload = DeletePresetsPayload(); // DeletePresetsPayload | 

try {
    final result = api_instance.deletePresetsApiPresetsDelete(deletePresetsPayload);
    print(result);
} catch (e) {
    print('Exception when calling PresetApi->deletePresetsApiPresetsDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deletePresetsPayload** | [**DeletePresetsPayload**](DeletePresetsPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAllPresetsApiPresetsGet**
> Object getAllPresetsApiPresetsGet()

Get All Presets

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PresetApi();

try {
    final result = api_instance.getAllPresetsApiPresetsGet();
    print(result);
} catch (e) {
    print('Exception when calling PresetApi->getAllPresetsApiPresetsGet: $e\n');
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

# **getPresetApiPresetsPresetIdGet**
> Object getPresetApiPresetsPresetIdGet(presetId)

Get Preset

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PresetApi();
final presetId = 56; // int | 

try {
    final result = api_instance.getPresetApiPresetsPresetIdGet(presetId);
    print(result);
} catch (e) {
    print('Exception when calling PresetApi->getPresetApiPresetsPresetIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **presetId** | **int**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePresetApiPresetsPresetIdPut**
> Object updatePresetApiPresetsPresetIdPut(presetId, updatePresetPayload)

Update Preset

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = PresetApi();
final presetId = 56; // int | 
final updatePresetPayload = UpdatePresetPayload(); // UpdatePresetPayload | 

try {
    final result = api_instance.updatePresetApiPresetsPresetIdPut(presetId, updatePresetPayload);
    print(result);
} catch (e) {
    print('Exception when calling PresetApi->updatePresetApiPresetsPresetIdPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **presetId** | **int**|  | 
 **updatePresetPayload** | [**UpdatePresetPayload**](UpdatePresetPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

