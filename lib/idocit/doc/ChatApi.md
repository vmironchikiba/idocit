# idocit_client.api.ChatApi

## Load the API package
```dart
import 'package:idocit_client/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteChatApiChatsChatIdDelete**](ChatApi.md#deletechatapichatschatiddelete) | **DELETE** /api/chats/{chat_id} | Delete Chat
[**exportChatApiChatsChatIdExportGet**](ChatApi.md#exportchatapichatschatidexportget) | **GET** /api/chats/{chat_id}/export | Export Chat
[**getChatApiChatsChatIdGet**](ChatApi.md#getchatapichatschatidget) | **GET** /api/chats/{chat_id} | Get Chat
[**listChatsApiChatsGet**](ChatApi.md#listchatsapichatsget) | **GET** /api/chats | List Chats
[**searchChatsApiChatsSearchGet**](ChatApi.md#searchchatsapichatssearchget) | **GET** /api/chats/search | Search Chats


# **deleteChatApiChatsChatIdDelete**
> Object deleteChatApiChatsChatIdDelete(chatId)

Delete Chat

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ChatApi();
final chatId = chatId_example; // String | 

try {
    final result = api_instance.deleteChatApiChatsChatIdDelete(chatId);
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->deleteChatApiChatsChatIdDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatId** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **exportChatApiChatsChatIdExportGet**
> Object exportChatApiChatsChatIdExportGet(chatId)

Export Chat

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ChatApi();
final chatId = chatId_example; // String | 

try {
    final result = api_instance.exportChatApiChatsChatIdExportGet(chatId);
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->exportChatApiChatsChatIdExportGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatId** | **String**|  | 

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getChatApiChatsChatIdGet**
> List<ChatHistoryMessage> getChatApiChatsChatIdGet(chatId, limit, beforeSequence)

Get Chat

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ChatApi();
final chatId = chatId_example; // String | 
final limit = 56; // int | 
final beforeSequence = 56; // int | 

try {
    final result = api_instance.getChatApiChatsChatIdGet(chatId, limit, beforeSequence);
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->getChatApiChatsChatIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **chatId** | **String**|  | 
 **limit** | **int**|  | [optional] [default to 500]
 **beforeSequence** | **int**|  | [optional] 

### Return type

[**List<ChatHistoryMessage>**](ChatHistoryMessage.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listChatsApiChatsGet**
> ChatListResponse listChatsApiChatsGet(limit, offset)

List Chats

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ChatApi();
final limit = 56; // int | 
final offset = 56; // int | 

try {
    final result = api_instance.listChatsApiChatsGet(limit, offset);
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->listChatsApiChatsGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**|  | [optional] [default to 500]
 **offset** | **int**|  | [optional] [default to 0]

### Return type

[**ChatListResponse**](ChatListResponse.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **searchChatsApiChatsSearchGet**
> Object searchChatsApiChatsSearchGet(q, limit)

Search Chats

### Example
```dart
import 'package:idocit_client/api.dart';
// TODO Configure OAuth2 access token for authorization: OAuth2PasswordBearer
//defaultApiClient.getAuthentication<OAuth>('OAuth2PasswordBearer').accessToken = 'YOUR_ACCESS_TOKEN';

final api_instance = ChatApi();
final q = q_example; // String | 
final limit = 56; // int | 

try {
    final result = api_instance.searchChatsApiChatsSearchGet(q, limit);
    print(result);
} catch (e) {
    print('Exception when calling ChatApi->searchChatsApiChatsSearchGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**|  | 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**Object**](Object.md)

### Authorization

[OAuth2PasswordBearer](../README.md#OAuth2PasswordBearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

