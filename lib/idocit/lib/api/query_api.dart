//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class QueryApi {
  QueryApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Admin Query
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AdminQueryPayload] adminQueryPayload (required):
  Future<Response> adminQueryApiAdminQueryPostWithHttpInfo(AdminQueryPayload adminQueryPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/admin/query';

    // ignore: prefer_final_locals
    Object? postBody = adminQueryPayload;

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

  /// Admin Query
  ///
  /// Parameters:
  ///
  /// * [AdminQueryPayload] adminQueryPayload (required):
  Future<Object?> adminQueryApiAdminQueryPost(AdminQueryPayload adminQueryPayload,) async {
    final response = await adminQueryApiAdminQueryPostWithHttpInfo(adminQueryPayload,);
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

  /// Query
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [QueryPayload] queryPayload (required):
  Future<Response> queryApiQueryPostWithHttpInfo(QueryPayload queryPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/query';

    // ignore: prefer_final_locals
    Object? postBody = queryPayload;

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

  /// Query
  ///
  /// Parameters:
  ///
  /// * [QueryPayload] queryPayload (required):
  Future<Object?> queryApiQueryPost(QueryPayload queryPayload,) async {
    final response = await queryApiQueryPostWithHttpInfo(queryPayload,);
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
