# idocit_client.api.ApiKeysApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createKeyApiKeysPost**](ApiKeysApi.md#createkeyapikeyspost) | **POST** /api/keys | Create Key
[**listKeysApiKeysGet**](ApiKeysApi.md#listkeysapikeysget) | **GET** /api/keys | List Keys
[**revokeKeyApiKeysKeyIdDelete**](ApiKeysApi.md#revokekeyapikeyskeyiddelete) | **DELETE** /api/keys/{key_id} | Revoke Key


# **createKeyApiKeysPost**
> Object createKeyApiKeysPost(createKeyRequest)

Create Key

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ApiKeysApi();
final createKeyRequest = CreateKeyRequest(); // CreateKeyRequest | 

try {
    final result = api_instance.createKeyApiKeysPost(createKeyRequest);
    print(result);
} catch (e) {
    print('Exception when calling ApiKeysApi->createKeyApiKeysPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createKeyRequest** | [**CreateKeyRequest**](CreateKeyRequest.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listKeysApiKeysGet**
> Object listKeysApiKeysGet()

List Keys

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ApiKeysApi();

try {
    final result = api_instance.listKeysApiKeysGet();
    print(result);
} catch (e) {
    print('Exception when calling ApiKeysApi->listKeysApiKeysGet: $e\n');
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

# **revokeKeyApiKeysKeyIdDelete**
> Object revokeKeyApiKeysKeyIdDelete(keyId)

Revoke Key

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ApiKeysApi();
final keyId = 56; // int | 

try {
    final result = api_instance.revokeKeyApiKeysKeyIdDelete(keyId);
    print(result);
} catch (e) {
    print('Exception when calling ApiKeysApi->revokeKeyApiKeysKeyIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **keyId** | **int**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

