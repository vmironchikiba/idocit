//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/api_keys_api.dart';
part 'api/app_status_api.dart';
part 'api/auth_api.dart';
part 'api/category_api.dart';
part 'api/category_type_api.dart';
part 'api/chat_api.dart';
part 'api/component_api.dart';
part 'api/config_api.dart';
part 'api/data_api.dart';
part 'api/doc_type_api.dart';
part 'api/document_api.dart';
part 'api/execute_api.dart';
part 'api/feedback_api.dart';
part 'api/import_export_api.dart';
part 'api/langgraph_api.dart';
part 'api/onedrive_api.dart';
part 'api/open_ai_api.dart';
part 'api/preset_api.dart';
part 'api/query_api.dart';
part 'api/reset_api.dart';
part 'api/suggestions_api.dart';
part 'api/users_api.dart';

part 'model/admin_load_payload.dart';
part 'model/admin_query_payload.dart';
part 'model/chat_completion_request.dart';
part 'model/chat_list_response.dart';
part 'model/chat_message.dart';
part 'model/chat_summary.dart';
part 'model/component_config.dart';
part 'model/component_item.dart';
part 'model/conversation_item.dart';
part 'model/create_category_payload.dart';
part 'model/create_key_request.dart';
part 'model/create_preset_payload.dart';
part 'model/delete_categories_payload.dart';
part 'model/delete_documents_payload.dart';
part 'model/delete_presets_payload.dart';
part 'model/execute_python_payload.dart';
part 'model/feedback_payload.dart';
part 'model/generate_payload.dart';
part 'model/get_component_payload.dart';
part 'model/get_document_payload.dart';
part 'model/http_validation_error.dart';
part 'model/keycloak_user.dart';
part 'model/load_payload.dart';
part 'model/logout_request.dart';
part 'model/one_drive_read_files_payload.dart';
part 'model/query_payload.dart';
part 'model/query_related_category_payload.dart';
part 'model/refresh_token_request.dart';
part 'model/reset_schema_payload.dart';
part 'model/save_global_config_payload.dart';
part 'model/search_query_payload.dart';
part 'model/selected_component.dart';
part 'model/set_component_payload.dart';
part 'model/update_category_payload.dart';
part 'model/update_documents_payload.dart';
part 'model/update_preset_payload.dart';
part 'model/user_token.dart';
part 'model/validation_error.dart';
part 'model/validation_error_loc_inner.dart';
part 'model/verba_options.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
