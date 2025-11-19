# idocit_client.api.OpenAIApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**chatCompletionsApiV1ChatCompletionsPost**](OpenAIApi.md#chatcompletionsapiv1chatcompletionspost) | **POST** /api/v1/chat/completions | Chat Completions
[**getModelsApiV1ModelsGet**](OpenAIApi.md#getmodelsapiv1modelsget) | **GET** /api/v1/models | Get Models


# **chatCompletionsApiV1ChatCompletionsPost**
> ChatCompletionChunk chatCompletionsApiV1ChatCompletionsPost(chatCompletionRequest)

Chat Completions

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OpenAIApi();
final chatCompletionRequest = ChatCompletionRequest(); // ChatCompletionRequest | 

try {
    final result = api_instance.chatCompletionsApiV1ChatCompletionsPost(chatCompletionRequest);
    print(result);
} catch (e) {
    print('Exception when calling OpenAIApi->chatCompletionsApiV1ChatCompletionsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatCompletionRequest** | [**ChatCompletionRequest**](ChatCompletionRequest.md)|  | 

### Return type

[**ChatCompletionChunk**](ChatCompletionChunk.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/x-ndjson, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getModelsApiV1ModelsGet**
> Object getModelsApiV1ModelsGet()

Get Models

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = OpenAIApi();

try {
    final result = api_instance.getModelsApiV1ModelsGet();
    print(result);
} catch (e) {
    print('Exception when calling OpenAIApi->getModelsApiV1ModelsGet: $e\n');
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

