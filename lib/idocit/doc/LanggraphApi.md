# idocit_client.api.LanggraphApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**streamLanggraphAgentApiLanggraphStreamPost**](LanggraphApi.md#streamlanggraphagentapilanggraphstreampost) | **POST** /api/langgraph/stream | Stream Langgraph Agent


# **streamLanggraphAgentApiLanggraphStreamPost**
> Object streamLanggraphAgentApiLanggraphStreamPost(generatePayload)

Stream Langgraph Agent

SSE stream for LangGraph: sends events as they are ready. Each event is a block in the form:   event: <name>   data: <json>  Events:   - node_started/node_finished/node_update (technical statuses)   - token (partial generation tokens)   - final (final message with full_text and categories)   - error (on exceptions)

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = LanggraphApi();
final generatePayload = GeneratePayload(); // GeneratePayload | 

try {
    final result = api_instance.streamLanggraphAgentApiLanggraphStreamPost(generatePayload);
    print(result);
} catch (e) {
    print('Exception when calling LanggraphApi->streamLanggraphAgentApiLanggraphStreamPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **generatePayload** | [**GeneratePayload**](GeneratePayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

