//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DocumentApi {
  DocumentApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete Document
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetDocumentPayload] getDocumentPayload (required):
  Future<Response> deleteDocumentApiDeleteDocumentPostWithHttpInfo(GetDocumentPayload getDocumentPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/delete_document';

    // ignore: prefer_final_locals
    Object? postBody = getDocumentPayload;

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

  /// Delete Document
  ///
  /// Parameters:
  ///
  /// * [GetDocumentPayload] getDocumentPayload (required):
  Future<Object?> deleteDocumentApiDeleteDocumentPost(GetDocumentPayload getDocumentPayload,) async {
    final response = await deleteDocumentApiDeleteDocumentPostWithHttpInfo(getDocumentPayload,);
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

  /// Delete Documents
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DeleteDocumentsPayload] deleteDocumentsPayload (required):
  Future<Response> deleteDocumentsApiDeleteDocumentsPostWithHttpInfo(DeleteDocumentsPayload deleteDocumentsPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/delete_documents';

    // ignore: prefer_final_locals
    Object? postBody = deleteDocumentsPayload;

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

  /// Delete Documents
  ///
  /// Parameters:
  ///
  /// * [DeleteDocumentsPayload] deleteDocumentsPayload (required):
  Future<Object?> deleteDocumentsApiDeleteDocumentsPost(DeleteDocumentsPayload deleteDocumentsPayload,) async {
    final response = await deleteDocumentsApiDeleteDocumentsPostWithHttpInfo(deleteDocumentsPayload,);
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

  /// Get All Documents Admin
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllDocumentsAdminApiAdminGetAllDocumentsPostWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/admin/get_all_documents';

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

  /// Get All Documents Admin
  Future<Object?> getAllDocumentsAdminApiAdminGetAllDocumentsPost() async {
    final response = await getAllDocumentsAdminApiAdminGetAllDocumentsPostWithHttpInfo();
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

  /// Get All Documents
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAllDocumentsApiGetAllDocumentsPostWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/get_all_documents';

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

  /// Get All Documents
  Future<Object?> getAllDocumentsApiGetAllDocumentsPost() async {
    final response = await getAllDocumentsApiGetAllDocumentsPostWithHttpInfo();
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

  /// Get Document
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GetDocumentPayload] getDocumentPayload (required):
  Future<Response> getDocumentApiGetDocumentPostWithHttpInfo(GetDocumentPayload getDocumentPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/get_document';

    // ignore: prefer_final_locals
    Object? postBody = getDocumentPayload;

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

  /// Get Document
  ///
  /// Parameters:
  ///
  /// * [GetDocumentPayload] getDocumentPayload (required):
  Future<Object?> getDocumentApiGetDocumentPost(GetDocumentPayload getDocumentPayload,) async {
    final response = await getDocumentApiGetDocumentPostWithHttpInfo(getDocumentPayload,);
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

  /// Search Documents
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SearchQueryPayload] searchQueryPayload (required):
  Future<Response> searchDocumentsApiSearchDocumentsPostWithHttpInfo(SearchQueryPayload searchQueryPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/search_documents';

    // ignore: prefer_final_locals
    Object? postBody = searchQueryPayload;

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

  /// Search Documents
  ///
  /// Parameters:
  ///
  /// * [SearchQueryPayload] searchQueryPayload (required):
  Future<Object?> searchDocumentsApiSearchDocumentsPost(SearchQueryPayload searchQueryPayload,) async {
    final response = await searchDocumentsApiSearchDocumentsPostWithHttpInfo(searchQueryPayload,);
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

  /// Update Documents
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [UpdateDocumentsPayload] updateDocumentsPayload (required):
  Future<Response> updateDocumentsApiDocumentsPutWithHttpInfo(UpdateDocumentsPayload updateDocumentsPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/documents';

    // ignore: prefer_final_locals
    Object? postBody = updateDocumentsPayload;

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

  /// Update Documents
  ///
  /// Parameters:
  ///
  /// * [UpdateDocumentsPayload] updateDocumentsPayload (required):
  Future<Object?> updateDocumentsApiDocumentsPut(UpdateDocumentsPayload updateDocumentsPayload,) async {
    final response = await updateDocumentsApiDocumentsPutWithHttpInfo(updateDocumentsPayload,);
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
