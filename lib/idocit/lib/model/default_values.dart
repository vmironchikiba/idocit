//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DefaultValues {
  /// Returns a new [DefaultValues] instance.
  DefaultValues({
    this.selectedReader,
    this.selectedChunker,
    this.selectedEmbedder,
    this.selectedRetriever,
    this.selectedProvider,
    this.selectedModel,
    this.enableCache,
    this.preferredLanguages = const [],
    this.defaultLanguage,
    this.CONVERSATION_SUMMARY_PERCENT,
    this.CONVERSATION_SUMMARY_MESSAGE_LIMIT,
    this.lastDocumentType,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ComponentItem? selectedReader;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ComponentItem? selectedChunker;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ComponentItem? selectedEmbedder;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  ComponentItem? selectedRetriever;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Provider? selectedProvider;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Model? selectedModel;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? enableCache;

  List<String> preferredLanguages;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? defaultLanguage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? CONVERSATION_SUMMARY_PERCENT;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? CONVERSATION_SUMMARY_MESSAGE_LIMIT;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? lastDocumentType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DefaultValues &&
    other.selectedReader == selectedReader &&
    other.selectedChunker == selectedChunker &&
    other.selectedEmbedder == selectedEmbedder &&
    other.selectedRetriever == selectedRetriever &&
    other.selectedProvider == selectedProvider &&
    other.selectedModel == selectedModel &&
    other.enableCache == enableCache &&
    _deepEquality.equals(other.preferredLanguages, preferredLanguages) &&
    other.defaultLanguage == defaultLanguage &&
    other.CONVERSATION_SUMMARY_PERCENT == CONVERSATION_SUMMARY_PERCENT &&
    other.CONVERSATION_SUMMARY_MESSAGE_LIMIT == CONVERSATION_SUMMARY_MESSAGE_LIMIT &&
    other.lastDocumentType == lastDocumentType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (selectedReader == null ? 0 : selectedReader!.hashCode) +
    (selectedChunker == null ? 0 : selectedChunker!.hashCode) +
    (selectedEmbedder == null ? 0 : selectedEmbedder!.hashCode) +
    (selectedRetriever == null ? 0 : selectedRetriever!.hashCode) +
    (selectedProvider == null ? 0 : selectedProvider!.hashCode) +
    (selectedModel == null ? 0 : selectedModel!.hashCode) +
    (enableCache == null ? 0 : enableCache!.hashCode) +
    (preferredLanguages.hashCode) +
    (defaultLanguage == null ? 0 : defaultLanguage!.hashCode) +
    (CONVERSATION_SUMMARY_PERCENT == null ? 0 : CONVERSATION_SUMMARY_PERCENT!.hashCode) +
    (CONVERSATION_SUMMARY_MESSAGE_LIMIT == null ? 0 : CONVERSATION_SUMMARY_MESSAGE_LIMIT!.hashCode) +
    (lastDocumentType == null ? 0 : lastDocumentType!.hashCode);

  @override
  String toString() => 'DefaultValues[selectedReader=$selectedReader, selectedChunker=$selectedChunker, selectedEmbedder=$selectedEmbedder, selectedRetriever=$selectedRetriever, selectedProvider=$selectedProvider, selectedModel=$selectedModel, enableCache=$enableCache, preferredLanguages=$preferredLanguages, defaultLanguage=$defaultLanguage, CONVERSATION_SUMMARY_PERCENT=$CONVERSATION_SUMMARY_PERCENT, CONVERSATION_SUMMARY_MESSAGE_LIMIT=$CONVERSATION_SUMMARY_MESSAGE_LIMIT, lastDocumentType=$lastDocumentType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.selectedReader != null) {
      json[r'selected_reader'] = this.selectedReader;
    } else {
      json[r'selected_reader'] = null;
    }
    if (this.selectedChunker != null) {
      json[r'selected_chunker'] = this.selectedChunker;
    } else {
      json[r'selected_chunker'] = null;
    }
    if (this.selectedEmbedder != null) {
      json[r'selected_embedder'] = this.selectedEmbedder;
    } else {
      json[r'selected_embedder'] = null;
    }
    if (this.selectedRetriever != null) {
      json[r'selected_retriever'] = this.selectedRetriever;
    } else {
      json[r'selected_retriever'] = null;
    }
    if (this.selectedProvider != null) {
      json[r'selected_provider'] = this.selectedProvider;
    } else {
      json[r'selected_provider'] = null;
    }
    if (this.selectedModel != null) {
      json[r'selected_model'] = this.selectedModel;
    } else {
      json[r'selected_model'] = null;
    }
    if (this.enableCache != null) {
      json[r'enable_cache'] = this.enableCache;
    } else {
      json[r'enable_cache'] = null;
    }
      json[r'preferred_languages'] = this.preferredLanguages;
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
    if (this.lastDocumentType != null) {
      json[r'last_document_type'] = this.lastDocumentType;
    } else {
      json[r'last_document_type'] = null;
    }
    return json;
  }

  /// Returns a new [DefaultValues] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DefaultValues? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DefaultValues[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DefaultValues[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DefaultValues(
        selectedReader: ComponentItem.fromJson(json[r'selected_reader']),
        selectedChunker: ComponentItem.fromJson(json[r'selected_chunker']),
        selectedEmbedder: ComponentItem.fromJson(json[r'selected_embedder']),
        selectedRetriever: ComponentItem.fromJson(json[r'selected_retriever']),
        selectedProvider: Provider.fromJson(json[r'selected_provider']),
        selectedModel: Model.fromJson(json[r'selected_model']),
        enableCache: mapValueOfType<bool>(json, r'enable_cache'),
        preferredLanguages: json[r'preferred_languages'] is Iterable
            ? (json[r'preferred_languages'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        defaultLanguage: mapValueOfType<String>(json, r'default_language'),
        CONVERSATION_SUMMARY_PERCENT: num.parse('${json[r'CONVERSATION_SUMMARY_PERCENT']}'),
        CONVERSATION_SUMMARY_MESSAGE_LIMIT: mapValueOfType<int>(json, r'CONVERSATION_SUMMARY_MESSAGE_LIMIT'),
        lastDocumentType: mapValueOfType<String>(json, r'last_document_type'),
      );
    }
    return null;
  }

  static List<DefaultValues> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DefaultValues>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DefaultValues.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DefaultValues> mapFromJson(dynamic json) {
    final map = <String, DefaultValues>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DefaultValues.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DefaultValues-objects as value to a dart map
  static Map<String, List<DefaultValues>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DefaultValues>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DefaultValues.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

