//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SaveGlobalConfigPayload {
  /// Returns a new [SaveGlobalConfigPayload] instance.
  SaveGlobalConfigPayload({
    this.reader = '',
    this.chunker = '',
    this.embedder = '',
    this.retriever = '',
    this.generator = '',
    this.enableCache,
    this.preferredLanguages = const [],
    this.defaultLanguage,
    this.CONVERSATION_SUMMARY_PERCENT,
    this.CONVERSATION_SUMMARY_MESSAGE_LIMIT,
  });

  String reader;

  String chunker;

  String embedder;

  String retriever;

  String generator;

  bool? enableCache;

  List<String>? preferredLanguages;

  String? defaultLanguage;

  num? CONVERSATION_SUMMARY_PERCENT;

  int? CONVERSATION_SUMMARY_MESSAGE_LIMIT;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SaveGlobalConfigPayload &&
    other.reader == reader &&
    other.chunker == chunker &&
    other.embedder == embedder &&
    other.retriever == retriever &&
    other.generator == generator &&
    other.enableCache == enableCache &&
    _deepEquality.equals(other.preferredLanguages, preferredLanguages) &&
    other.defaultLanguage == defaultLanguage &&
    other.CONVERSATION_SUMMARY_PERCENT == CONVERSATION_SUMMARY_PERCENT &&
    other.CONVERSATION_SUMMARY_MESSAGE_LIMIT == CONVERSATION_SUMMARY_MESSAGE_LIMIT;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (reader.hashCode) +
    (chunker.hashCode) +
    (embedder.hashCode) +
    (retriever.hashCode) +
    (generator.hashCode) +
    (enableCache == null ? 0 : enableCache!.hashCode) +
    (preferredLanguages == null ? 0 : preferredLanguages!.hashCode) +
    (defaultLanguage == null ? 0 : defaultLanguage!.hashCode) +
    (CONVERSATION_SUMMARY_PERCENT == null ? 0 : CONVERSATION_SUMMARY_PERCENT!.hashCode) +
    (CONVERSATION_SUMMARY_MESSAGE_LIMIT == null ? 0 : CONVERSATION_SUMMARY_MESSAGE_LIMIT!.hashCode);

  @override
  String toString() => 'SaveGlobalConfigPayload[reader=$reader, chunker=$chunker, embedder=$embedder, retriever=$retriever, generator=$generator, enableCache=$enableCache, preferredLanguages=$preferredLanguages, defaultLanguage=$defaultLanguage, CONVERSATION_SUMMARY_PERCENT=$CONVERSATION_SUMMARY_PERCENT, CONVERSATION_SUMMARY_MESSAGE_LIMIT=$CONVERSATION_SUMMARY_MESSAGE_LIMIT]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'reader'] = this.reader;
      json[r'chunker'] = this.chunker;
      json[r'embedder'] = this.embedder;
      json[r'retriever'] = this.retriever;
      json[r'generator'] = this.generator;
    if (this.enableCache != null) {
      json[r'enable_cache'] = this.enableCache;
    } else {
      json[r'enable_cache'] = null;
    }
    if (this.preferredLanguages != null) {
      json[r'preferred_languages'] = this.preferredLanguages;
    } else {
      json[r'preferred_languages'] = null;
    }
    if (this.defaultLanguage != null) {
      json[r'default_language'] = this.defaultLanguage;
    } else {
      json[r'default_language'] = null;
    }
    if (this.CONVERSATION_SUMMARY_PERCENT != null) {
      json[r'CONVERSATION_SUMMARY_PERCENT'] = this.CONVERSATION_SUMMARY_PERCENT;
    } else {
      json[r'CONVERSATION_SUMMARY_PERCENT'] = null;
    }
    if (this.CONVERSATION_SUMMARY_MESSAGE_LIMIT != null) {
      json[r'CONVERSATION_SUMMARY_MESSAGE_LIMIT'] = this.CONVERSATION_SUMMARY_MESSAGE_LIMIT;
    } else {
      json[r'CONVERSATION_SUMMARY_MESSAGE_LIMIT'] = null;
    }
    return json;
  }

  /// Returns a new [SaveGlobalConfigPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SaveGlobalConfigPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "SaveGlobalConfigPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "SaveGlobalConfigPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return SaveGlobalConfigPayload(
        reader: mapValueOfType<String>(json, r'reader') ?? '',
        chunker: mapValueOfType<String>(json, r'chunker') ?? '',
        embedder: mapValueOfType<String>(json, r'embedder') ?? '',
        retriever: mapValueOfType<String>(json, r'retriever') ?? '',
        generator: mapValueOfType<String>(json, r'generator') ?? '',
        enableCache: mapValueOfType<bool>(json, r'enable_cache'),
        preferredLanguages: json[r'preferred_languages'] is Iterable
            ? (json[r'preferred_languages'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        defaultLanguage: mapValueOfType<String>(json, r'default_language'),
        CONVERSATION_SUMMARY_PERCENT: json[r'CONVERSATION_SUMMARY_PERCENT'] == null
            ? null
            : num.parse('${json[r'CONVERSATION_SUMMARY_PERCENT']}'),
        CONVERSATION_SUMMARY_MESSAGE_LIMIT: mapValueOfType<int>(json, r'CONVERSATION_SUMMARY_MESSAGE_LIMIT'),
      );
    }
    return null;
  }

  static List<SaveGlobalConfigPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SaveGlobalConfigPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SaveGlobalConfigPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SaveGlobalConfigPayload> mapFromJson(dynamic json) {
    final map = <String, SaveGlobalConfigPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SaveGlobalConfigPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SaveGlobalConfigPayload-objects as value to a dart map
  static Map<String, List<SaveGlobalConfigPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SaveGlobalConfigPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SaveGlobalConfigPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

