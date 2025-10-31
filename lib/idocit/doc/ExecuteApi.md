# idocit_client.api.ExecuteApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**executePythonApiExecutePythonPost**](ExecuteApi.md#executepythonapiexecutepythonpost) | **POST** /api/execute/python | Execute Python


# **executePythonApiExecutePythonPost**
> Object executePythonApiExecutePythonPost(executePythonPayload)

Execute Python

### Example
```dart
import 'package:idocit_client/api.dart';

final api_instance = ExecuteApi();
final executePythonPayload = ExecutePythonPayload(); // ExecutePythonPayload | 

try {
    final result = api_instance.executePythonApiExecutePythonPost(executePythonPayload);
    print(result);
} catch (e) {
    print('Exception when calling ExecuteApi->executePythonApiExecutePythonPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **executePythonPayload** | [**ExecutePythonPayload**](ExecutePythonPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

