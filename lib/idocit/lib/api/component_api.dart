//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ComponentApi {
  ComponentApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get Component
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetComponentPayload] getComponentPayload (required):
  Future<Response> getComponentApiGetComponentPostWithHttpInfo(GetComponentPayload getComponentPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/get_component';

    // ignore: prefer_final_locals
    Object? postBody = getComponentPayload;

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

  /// Get Component
  ///
  /// Parameters:
  ///
  /// * [GetComponentPayload] getComponentPayload (required):
  Future<Object?> getComponentApiGetComponentPost(GetComponentPayload getComponentPayload,) async {
    final response = await getComponentApiGetComponentPostWithHttpInfo(getComponentPayload,);
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

  /// Get Components
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getComponentsApiComponentsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/components';

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

  /// Get Components
  Future<ComponentConfig?> getComponentsApiComponentsGet() async {
    final response = await getComponentsApiComponentsGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ComponentConfig',) as ComponentConfig;
    
    }
    return null;
  }

  /// Set Component
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetComponentPayload] setComponentPayload (required):
  Future<Response> setComponentApiComponentsPostWithHttpInfo(SetComponentPayload setComponentPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/components';

    // ignore: prefer_final_locals
    Object? postBody = setComponentPayload;

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

  /// Set Component
  ///
  /// Parameters:
  ///
  /// * [SetComponentPayload] setComponentPayload (required):
  Future<Object?> setComponentApiComponentsPost(SetComponentPayload setComponentPayload,) async {
    final response = await setComponentApiComponentsPostWithHttpInfo(setComponentPayload,);
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
