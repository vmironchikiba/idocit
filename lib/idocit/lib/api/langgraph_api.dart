//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class LanggraphApi {
  LanggraphApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Stream Langgraph Agent
  ///
  /// SSE stream for LangGraph: sends events as they are ready. Each event is a block in the form:   event: <name>   data: <json>  Events:   - node_started/node_finished/node_update (technical statuses)   - token (partial generation tokens)   - final (final message with full_text and categories)   - error (on exceptions)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GeneratePayload] generatePayload (required):
  Future<Response> streamLanggraphAgentApiLanggraphStreamPostWithHttpInfo(GeneratePayload generatePayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/langgraph/stream';

    // ignore: prefer_final_locals
    Object? postBody = generatePayload;

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

  /// Stream Langgraph Agent
  ///
  /// SSE stream for LangGraph: sends events as they are ready. Each event is a block in the form:   event: <name>   data: <json>  Events:   - node_started/node_finished/node_update (technical statuses)   - token (partial generation tokens)   - final (final message with full_text and categories)   - error (on exceptions)
  ///
  /// Parameters:
  ///
  /// * [GeneratePayload] generatePayload (required):
  Future<Object?> streamLanggraphAgentApiLanggraphStreamPost(GeneratePayload generatePayload,) async {
    final response = await streamLanggraphAgentApiLanggraphStreamPostWithHttpInfo(generatePayload,);
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
