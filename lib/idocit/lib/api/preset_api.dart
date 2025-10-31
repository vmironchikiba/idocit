//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PresetApi {
  PresetApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Preset
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreatePresetPayload] createPresetPayload (required):
  Future<Response> createPresetApiPresetsPostWithHttpInfo(CreatePresetPayload createPresetPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/presets';

    // ignore: prefer_final_locals
    Object? postBody = createPresetPayload;

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

  /// Create Preset
  ///
  /// Parameters:
  ///
  /// * [CreatePresetPayload] createPresetPayload (required):
  Future<Object?> createPresetApiPresetsPost(CreatePresetPayload createPresetPayload,) async {
    final response = await createPresetApiPresetsPostWithHttpInfo(createPresetPayload,);
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

  /// Delete Presets
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DeletePresetsPayload] deletePresetsPayload (required):
  Future<Response> deletePresetsApiPresetsDeleteWithHttpInfo(DeletePresetsPayload deletePresetsPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/presets';

    // ignore: prefer_final_locals
    Object? postBody = deletePresetsPayload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete Presets
  ///
  /// Parameters:
  ///
  /// * [DeletePresetsPayload] deletePresetsPayload (required):
  Future<Object?> deletePresetsApiPresetsDelete(DeletePresetsPayload deletePresetsPayload,) async {
    final response = await deletePresetsApiPresetsDeleteWithHttpInfo(deletePresetsPayload,);
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

  /// Get All Presets
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllPresetsApiPresetsGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/presets';

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

  /// Get All Presets
  Future<Object?> getAllPresetsApiPresetsGet() async {
    final response = await getAllPresetsApiPresetsGetWithHttpInfo();
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

  /// Get Preset
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] presetId (required):
  Future<Response> getPresetApiPresetsPresetIdGetWithHttpInfo(int presetId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/presets/{preset_id}'
      .replaceAll('{preset_id}', presetId.toString());

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

  /// Get Preset
  ///
  /// Parameters:
  ///
  /// * [int] presetId (required):
  Future<Object?> getPresetApiPresetsPresetIdGet(int presetId,) async {
    final response = await getPresetApiPresetsPresetIdGetWithHttpInfo(presetId,);
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

  /// Update Preset
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] presetId (required):
  ///
  /// * [UpdatePresetPayload] updatePresetPayload (required):
  Future<Response> updatePresetApiPresetsPresetIdPutWithHttpInfo(int presetId, UpdatePresetPayload updatePresetPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/presets/{preset_id}'
      .replaceAll('{preset_id}', presetId.toString());

    // ignore: prefer_final_locals
    Object? postBody = updatePresetPayload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update Preset
  ///
  /// Parameters:
  ///
  /// * [int] presetId (required):
  ///
  /// * [UpdatePresetPayload] updatePresetPayload (required):
  Future<Object?> updatePresetApiPresetsPresetIdPut(int presetId, UpdatePresetPayload updatePresetPayload,) async {
    final response = await updatePresetApiPresetsPresetIdPutWithHttpInfo(presetId, updatePresetPayload,);
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
