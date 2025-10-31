# idocit_client.api.DataApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**adminLoadDataApiAdminDataPost**](DataApi.md#adminloaddataapiadmindatapost) | **POST** /api/admin/data | Admin Load Data
[**cancelJobApiDataJobJobIdCancelPost**](DataApi.md#canceljobapidatajobjobidcancelpost) | **POST** /api/data/job/{job_id}/cancel | Cancel Job
[**getJobStatusApiDataJobJobIdGet**](DataApi.md#getjobstatusapidatajobjobidget) | **GET** /api/data/job/{job_id} | Get Job Status
[**listJobsApiDataJobGet**](DataApi.md#listjobsapidatajobget) | **GET** /api/data/job | List Jobs
[**loadDataApiDataPost**](DataApi.md#loaddataapidatapost) | **POST** /api/data | Load Data


# **adminLoadDataApiAdminDataPost**
> Object adminLoadDataApiAdminDataPost(adminLoadPayload)

Admin Load Data

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DataApi();
final adminLoadPayload = AdminLoadPayload(); // AdminLoadPayload | 

try {
    final result = api_instance.adminLoadDataApiAdminDataPost(adminLoadPayload);
    print(result);
} catch (e) {
    print('Exception when calling DataApi->adminLoadDataApiAdminDataPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **adminLoadPayload** | [**AdminLoadPayload**](AdminLoadPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **cancelJobApiDataJobJobIdCancelPost**
> Object cancelJobApiDataJobJobIdCancelPost(jobId)

Cancel Job

Cancel an in-flight upload task. Processed files keep status; others become Canceled.

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DataApi();
final jobId = jobId_example; // String | 

try {
    final result = api_instance.cancelJobApiDataJobJobIdCancelPost(jobId);
    print(result);
} catch (e) {
    print('Exception when calling DataApi->cancelJobApiDataJobJobIdCancelPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getJobStatusApiDataJobJobIdGet**
> Object getJobStatusApiDataJobJobIdGet(jobId)

Get Job Status

Get the status of a background job. Prefer DB-backed record, fallback to in-memory tracker.

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DataApi();
final jobId = jobId_example; // String | 

try {
    final result = api_instance.getJobStatusApiDataJobJobIdGet(jobId);
    print(result);
} catch (e) {
    print('Exception when calling DataApi->getJobStatusApiDataJobJobIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **jobId** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listJobsApiDataJobGet**
> Object listJobsApiDataJobGet()

List Jobs

List recent upload tasks for current user (last 3 days).

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DataApi();

try {
    final result = api_instance.listJobsApiDataJobGet();
    print(result);
} catch (e) {
    print('Exception when calling DataApi->listJobsApiDataJobGet: $e\n');
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

# **loadDataApiDataPost**
> Object loadDataApiDataPost(loadPayload)

Load Data

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = DataApi();
final loadPayload = LoadPayload(); // LoadPayload | 

try {
    final result = api_instance.loadDataApiDataPost(loadPayload);
    print(result);
} catch (e) {
    print('Exception when calling DataApi->loadDataApiDataPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **loadPayload** | [**LoadPayload**](LoadPayload.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

