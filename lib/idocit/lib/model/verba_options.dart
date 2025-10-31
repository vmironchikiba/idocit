//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VerbaOptions {
  /// Returns a new [VerbaOptions] instance.
  VerbaOptions({
    this.tenant,
    this.language,
    this.chatId,
    this.embedder,
    this.generator,
    this.retriever,
  });

  String? tenant;

  String? language;

  String? chatId;

  Object? embedder;

  Object? generator;

  Object? retriever;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VerbaOptions &&
    other.tenant == tenant &&
    other.language == language &&
    other.chatId == chatId &&
    other.embedder == embedder &&
    other.generator == generator &&
    other.retriever == retriever;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (tenant == null ? 0 : tenant!.hashCode) +
    (language == null ? 0 : language!.hashCode) +
    (chatId == null ? 0 : chatId!.hashCode) +
    (embedder == null ? 0 : embedder!.hashCode) +
    (generator == null ? 0 : generator!.hashCode) +
    (retriever == null ? 0 : retriever!.hashCode);

  @override
  String toString() => 'VerbaOptions[tenant=$tenant, language=$language, chatId=$chatId, embedder=$embedder, generator=$generator, retriever=$retriever]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.tenant != null) {
      json[r'tenant'] = this.tenant;
    } else {
      json[r'tenant'] = null;
    }
    if (this.language != null) {
      json[r'language'] = this.language;
    } else {
      json[r'language'] = null;
    }
    if (this.chatId != null) {
      json[r'chat_id'] = this.chatId;
    } else {
      json[r'chat_id'] = null;
    }
    if (this.embedder != null) {
      json[r'embedder'] = this.embedder;
    } else {
      json[r'embedder'] = null;
    }
    if (this.generator != null) {
      json[r'generator'] = this.generator;
    } else {
      json[r'generator'] = null;
    }
    if (this.retriever != null) {
      json[r'retriever'] = this.retriever;
    } else {
      json[r'retriever'] = null;
    }
    return json;
  }

  /// Returns a new [VerbaOptions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VerbaOptions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "VerbaOptions[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "VerbaOptions[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return VerbaOptions(
        tenant: mapValueOfType<String>(json, r'tenant'),
        language: mapValueOfType<String>(json, r'language'),
        chatId: mapValueOfType<String>(json, r'chat_id'),
        embedder: mapValueOfType<Object>(json, r'embedder'),
        generator: mapValueOfType<Object>(json, r'generator'),
        retriever: mapValueOfType<Object>(json, r'retriever'),
      );
    }
    return null;
  }

  static List<VerbaOptions> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VerbaOptions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VerbaOptions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VerbaOptions> mapFromJson(dynamic json) {
    final map = <String, VerbaOptions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VerbaOptions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VerbaOptions-objects as value to a dart map
  static Map<String, List<VerbaOptions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VerbaOptions>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VerbaOptions.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

