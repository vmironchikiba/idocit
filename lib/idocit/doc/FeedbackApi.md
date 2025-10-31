# idocit_client.api.FeedbackApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getFeedbackStatsApiFeedbackStatsGet**](FeedbackApi.md#getfeedbackstatsapifeedbackstatsget) | **GET** /api/feedback/stats | Get Feedback Stats
[**submitFeedbackApiFeedbackPost**](FeedbackApi.md#submitfeedbackapifeedbackpost) | **POST** /api/feedback | Submit Feedback


# **getFeedbackStatsApiFeedbackStatsGet**
> Object getFeedbackStatsApiFeedbackStatsGet()

Get Feedback Stats

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FeedbackApi();

try {
    final result = api_instance.getFeedbackStatsApiFeedbackStatsGet();
    print(result);
} catch (e) {
    print('Exception when calling FeedbackApi->getFeedbackStatsApiFeedbackStatsGet: $e\n');
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

# **submitFeedbackApiFeedbackPost**
> Object submitFeedbackApiFeedbackPost(feedbackPayload)

Submit Feedback

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = FeedbackApi();
final feedbackPayload = FeedbackPayload(); // FeedbackPayload | 

try {
    final result = api_instance.submitFeedbackApiFeedbackPost(feedbackPayload);
    print(result);
} catch (e) {
    print('Exception when calling FeedbackApi->submitFeedbackApiFeedbackPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **feedbackPayload** | [**FeedbackPayload**](FeedbackPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

