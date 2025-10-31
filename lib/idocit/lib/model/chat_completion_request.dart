//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatCompletionRequest {
  /// Returns a new [ChatCompletionRequest] instance.
  ChatCompletionRequest({
    required this.model,
    this.messages = const [],
    this.stream,
    this.extraParams,
  });

  String model;

  List<ChatMessage> messages;

  bool? stream;

  VerbaOptions? extraParams;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatCompletionRequest &&
    other.model == model &&
    _deepEquality.equals(other.messages, messages) &&
    other.stream == stream &&
    other.extraParams == extraParams;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (model.hashCode) +
    (messages.hashCode) +
    (stream == null ? 0 : stream!.hashCode) +
    (extraParams == null ? 0 : extraParams!.hashCode);

  @override
  String toString() => 'ChatCompletionRequest[model=$model, messages=$messages, stream=$stream, extraParams=$extraParams]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'model'] = this.model;
      json[r'messages'] = this.messages;
    if (this.stream != null) {
      json[r'stream'] = this.stream;
    } else {
      json[r'stream'] = null;
    }
    if (this.extraParams != null) {
      json[r'extra_params'] = this.extraParams;
    } else {
      json[r'extra_params'] = null;
    }
    return json;
  }

  /// Returns a new [ChatCompletionRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatCompletionRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatCompletionRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatCompletionRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatCompletionRequest(
        model: mapValueOfType<String>(json, r'model')!,
        messages: ChatMessage.listFromJson(json[r'messages']),
        stream: mapValueOfType<bool>(json, r'stream'),
        extraParams: VerbaOptions.fromJson(json[r'extra_params']),
      );
    }
    return null;
  }

  static List<ChatCompletionRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatCompletionRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatCompletionRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatCompletionRequest> mapFromJson(dynamic json) {
    final map = <String, ChatCompletionRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatCompletionRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatCompletionRequest-objects as value to a dart map
  static Map<String, List<ChatCompletionRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatCompletionRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatCompletionRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'model',
    'messages',
  };
}

