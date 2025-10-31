//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CategoryApi {
  CategoryApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Category
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateCategoryPayload] createCategoryPayload (required):
  Future<Response> createCategoryApiCategoriesPostWithHttpInfo(CreateCategoryPayload createCategoryPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/categories';

    // ignore: prefer_final_locals
    Object? postBody = createCategoryPayload;

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

  /// Create Category
  ///
  /// Parameters:
  ///
  /// * [CreateCategoryPayload] createCategoryPayload (required):
  Future<Object?> createCategoryApiCategoriesPost(CreateCategoryPayload createCategoryPayload,) async {
    final response = await createCategoryApiCategoriesPostWithHttpInfo(createCategoryPayload,);
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

  /// Delete Categories
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DeleteCategoriesPayload] deleteCategoriesPayload (required):
  Future<Response> deleteCategoriesApiCategoriesDeleteWithHttpInfo(DeleteCategoriesPayload deleteCategoriesPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/categories';

    // ignore: prefer_final_locals
    Object? postBody = deleteCategoriesPayload;

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

  /// Delete Categories
  ///
  /// Parameters:
  ///
  /// * [DeleteCategoriesPayload] deleteCategoriesPayload (required):
  Future<Object?> deleteCategoriesApiCategoriesDelete(DeleteCategoriesPayload deleteCategoriesPayload,) async {
    final response = await deleteCategoriesApiCategoriesDeleteWithHttpInfo(deleteCategoriesPayload,);
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

  /// Get Categories
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getCategoriesApiCategoriesGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/categories';

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

  /// Get Categories
  Future<Object?> getCategoriesApiCategoriesGet() async {
    final response = await getCategoriesApiCategoriesGetWithHttpInfo();
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

  /// Get Category
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  Future<Response> getCategoryApiCategoriesCategoryIdGetWithHttpInfo(int categoryId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/categories/{category_id}'
      .replaceAll('{category_id}', categoryId.toString());

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

  /// Get Category
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  Future<Object?> getCategoryApiCategoriesCategoryIdGet(int categoryId,) async {
    final response = await getCategoryApiCategoriesCategoryIdGetWithHttpInfo(categoryId,);
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

  /// Update Category
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [UpdateCategoryPayload] updateCategoryPayload (required):
  Future<Response> updateCategoryApiCategoriesCategoryIdPutWithHttpInfo(int categoryId, UpdateCategoryPayload updateCategoryPayload,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/categories/{category_id}'
      .replaceAll('{category_id}', categoryId.toString());

    // ignore: prefer_final_locals
    Object? postBody = updateCategoryPayload;

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

  /// Update Category
  ///
  /// Parameters:
  ///
  /// * [int] categoryId (required):
  ///
  /// * [UpdateCategoryPayload] updateCategoryPayload (required):
  Future<Object?> updateCategoryApiCategoriesCategoryIdPut(int categoryId, UpdateCategoryPayload updateCategoryPayload,) async {
    final response = await updateCategoryApiCategoriesCategoryIdPutWithHttpInfo(categoryId, updateCategoryPayload,);
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
