//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DataApi {
  DataApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Admin Load Data
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [AdminLoadPayload] adminLoadPayload (required):
  Future<Response> adminLoadDataApiAdminDataPostWithHttpInfo(AdminLoadPayload adminLoadPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/admin/data';

    // ignore: prefer_final_locals
    Object? postBody = adminLoadPayload;

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

  /// Admin Load Data
  ///
  /// Parameters:
  ///
  /// * [AdminLoadPayload] adminLoadPayload (required):
  Future<Object?> adminLoadDataApiAdminDataPost(AdminLoadPayload adminLoadPayload,) async {
    final response = await adminLoadDataApiAdminDataPostWithHttpInfo(adminLoadPayload,);
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

  /// Cancel Job
  ///
  /// Cancel an in-flight upload task. Processed files keep status; others become Canceled.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] jobId (required):
  Future<Response> cancelJobApiDataJobJobIdCancelPostWithHttpInfo(String jobId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/data/job/{job_id}/cancel'
      .replaceAll('{job_id}', jobId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Cancel Job
  ///
  /// Cancel an in-flight upload task. Processed files keep status; others become Canceled.
  ///
  /// Parameters:
  ///
  /// * [String] jobId (required):
  Future<Object?> cancelJobApiDataJobJobIdCancelPost(String jobId,) async {
    final response = await cancelJobApiDataJobJobIdCancelPostWithHttpInfo(jobId,);
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

  /// Get Job Status
  ///
  /// Get the status of a background job. Prefer DB-backed record, fallback to in-memory tracker.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] jobId (required):
  Future<Response> getJobStatusApiDataJobJobIdGetWithHttpInfo(String jobId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/data/job/{job_id}'
      .replaceAll('{job_id}', jobId);

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

  /// Get Job Status
  ///
  /// Get the status of a background job. Prefer DB-backed record, fallback to in-memory tracker.
  ///
  /// Parameters:
  ///
  /// * [String] jobId (required):
  Future<Object?> getJobStatusApiDataJobJobIdGet(String jobId,) async {
    final response = await getJobStatusApiDataJobJobIdGetWithHttpInfo(jobId,);
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

  /// List Jobs
  ///
  /// List recent upload tasks for current user (last 3 days).
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listJobsApiDataJobGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/data/job';

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

  /// List Jobs
  ///
  /// List recent upload tasks for current user (last 3 days).
  Future<Object?> listJobsApiDataJobGet() async {
    final response = await listJobsApiDataJobGetWithHttpInfo();
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

  /// Load Data
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [LoadPayload] loadPayload (required):
  Future<Response> loadDataApiDataPostWithHttpInfo(LoadPayload loadPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/data';

    // ignore: prefer_final_locals
    Object? postBody = loadPayload;

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

  /// Load Data
  ///
  /// Parameters:
  ///
  /// * [LoadPayload] loadPayload (required):
  Future<Object?> loadDataApiDataPost(LoadPayload loadPayload,) async {
    final response = await loadDataApiDataPostWithHttpInfo(loadPayload,);
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
