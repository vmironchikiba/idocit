# idocit_client.api.SuggestionsApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**resetSuggestionApiResetSuggestionGet**](SuggestionsApi.md#resetsuggestionapiresetsuggestionget) | **GET** /api/reset_suggestion | Reset Suggestion
[**suggestionsApiSuggestionsPost**](SuggestionsApi.md#suggestionsapisuggestionspost) | **POST** /api/suggestions | Suggestions


# **resetSuggestionApiResetSuggestionGet**
> Object resetSuggestionApiResetSuggestionGet()

Reset Suggestion

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SuggestionsApi();

try {
    final result = api_instance.resetSuggestionApiResetSuggestionGet();
    print(result);
} catch (e) {
    print('Exception when calling SuggestionsApi->resetSuggestionApiResetSuggestionGet: $e\n');
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

# **suggestionsApiSuggestionsPost**
> SuggestionsResponse suggestionsApiSuggestionsPost(queryPayload)

Suggestions

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = SuggestionsApi();
final queryPayload = QueryPayload(); // QueryPayload | 

try {
    final result = api_instance.suggestionsApiSuggestionsPost(queryPayload);
    print(result);
} catch (e) {
    print('Exception when calling SuggestionsApi->suggestionsApiSuggestionsPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **queryPayload** | [**QueryPayload**](QueryPayload.md)|  | 

### Return type

[**SuggestionsResponse**](SuggestionsResponse.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

