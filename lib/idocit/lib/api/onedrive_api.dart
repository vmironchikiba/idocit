//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class OnedriveApi {
  OnedriveApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Authorize
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] redirectUrl (required):
  Future<Response> authorizeApiOnedriveAuthUriGetWithHttpInfo(String redirectUrl,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/onedrive/auth_uri';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'redirect_url', redirectUrl));

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

  /// Authorize
  ///
  /// Parameters:
  ///
  /// * [String] redirectUrl (required):
  Future<Object?> authorizeApiOnedriveAuthUriGet(String redirectUrl,) async {
    final response = await authorizeApiOnedriveAuthUriGetWithHttpInfo(redirectUrl,);
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

  /// Callback
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] state (required):
  Future<Response> callbackApiOnedriveAuthCallbackGetWithHttpInfo(String state,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/onedrive/auth/callback';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'state', state));

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

  /// Callback
  ///
  /// Parameters:
  ///
  /// * [String] state (required):
  Future<Object?> callbackApiOnedriveAuthCallbackGet(String state,) async {
    final response = await callbackApiOnedriveAuthCallbackGetWithHttpInfo(state,);
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

  /// Onedrive Read Files
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [OneDriveReadFilesPayload] oneDriveReadFilesPayload (required):
  Future<Response> onedriveReadFilesApiOnedriveReadFilesPostWithHttpInfo(OneDriveReadFilesPayload oneDriveReadFilesPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/onedrive/read_files';

    // ignore: prefer_final_locals
    Object? postBody = oneDriveReadFilesPayload;

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

  /// Onedrive Read Files
  ///
  /// Parameters:
  ///
  /// * [OneDriveReadFilesPayload] oneDriveReadFilesPayload (required):
  Future<Object?> onedriveReadFilesApiOnedriveReadFilesPost(OneDriveReadFilesPayload oneDriveReadFilesPayload,) async {
    final response = await onedriveReadFilesApiOnedriveReadFilesPostWithHttpInfo(oneDriveReadFilesPayload,);
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
