//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class OpenAIApi {
  OpenAIApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Chat Completions
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ChatCompletionRequest] chatCompletionRequest (required):
  Future<Response> chatCompletionsApiV1ChatCompletionsPostWithHttpInfo(ChatCompletionRequest chatCompletionRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/chat/completions';

    // ignore: prefer_final_locals
    Object? postBody = chatCompletionRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Chat Completions
  ///
  /// Parameters:
  ///
  /// * [ChatCompletionRequest] chatCompletionRequest (required):
  Future<ChatCompletionChunk?> chatCompletionsApiV1ChatCompletionsPost(ChatCompletionRequest chatCompletionRequest,) async {
    final response = await chatCompletionsApiV1ChatCompletionsPostWithHttpInfo(chatCompletionRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChatCompletionChunk',) as ChatCompletionChunk;
    
    }
    return null;
  }

  /// Get Models
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getModelsApiV1ModelsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/models';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get Models
  Future<Object?> getModelsApiV1ModelsGet() async {
    final response = await getModelsApiV1ModelsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }
}
