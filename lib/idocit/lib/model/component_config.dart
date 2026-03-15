//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ComponentConfig {
  /// Returns a new [ComponentConfig] instance.
  ComponentConfig({
    this.readers = const [],
    this.chunker = const [],
    this.embedder = const [],
    this.retriever = const [],
    this.providers = const [],
    this.models = const [],
    this.enableCache = const [],
    this.preferredLanguages = const [],
    this.defaultLanguage = const [],
    this.defaultValues,
  });

  List<ComponentItem> readers;

  List<ComponentItem> chunker;

  List<ComponentItem> embedder;

  List<ComponentItem> retriever;

  List<Provider> providers;

  List<Model> models;

  List<bool> enableCache;

  List<String> preferredLanguages;

  List<String> defaultLanguage;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DefaultValues? defaultValues;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ComponentConfig &&
    _deepEquality.equals(other.readers, readers) &&
    _deepEquality.equals(other.chunker, chunker) &&
    _deepEquality.equals(other.embedder, embedder) &&
    _deepEquality.equals(other.retriever, retriever) &&
    _deepEquality.equals(other.providers, providers) &&
    _deepEquality.equals(other.models, models) &&
    _deepEquality.equals(other.enableCache, enableCache) &&
    _deepEquality.equals(other.preferredLanguages, preferredLanguages) &&
    _deepEquality.equals(other.defaultLanguage, defaultLanguage) &&
    other.defaultValues == defaultValues;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (readers.hashCode) +
    (chunker.hashCode) +
    (embedder.hashCode) +
    (retriever.hashCode) +
    (providers.hashCode) +
    (models.hashCode) +
    (enableCache.hashCode) +
    (preferredLanguages.hashCode) +
    (defaultLanguage.hashCode) +
    (defaultValues == null ? 0 : defaultValues!.hashCode);

  @override
  String toString() => 'ComponentConfig[readers=$readers, chunker=$chunker, embedder=$embedder, retriever=$retriever, providers=$providers, models=$models, enableCache=$enableCache, preferredLanguages=$preferredLanguages, defaultLanguage=$defaultLanguage, defaultValues=$defaultValues]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'readers'] = this.readers;
      json[r'chunker'] = this.chunker;
      json[r'embedder'] = this.embedder;
      json[r'retriever'] = this.retriever;
      json[r'providers'] = this.providers;
      json[r'models'] = this.models;
      json[r'enable_cache'] = this.enableCache;
      json[r'preferred_languages'] = this.preferredLanguages;
      json[r'default_language'] = this.defaultLanguage;
    if (this.defaultValues != null) {
      json[r'default_values'] = this.defaultValues;
    } else {
      json[r'default_values'] = null;
    }
    return json;
  }

  /// Returns a new [ComponentConfig] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ComponentConfig? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ComponentConfig[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ComponentConfig[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ComponentConfig(
        readers: ComponentItem.listFromJson(json[r'readers']),
        chunker: ComponentItem.listFromJson(json[r'chunker']),
        embedder: ComponentItem.listFromJson(json[r'embedder']),
        retriever: ComponentItem.listFromJson(json[r'retriever']),
        providers: Provider.listFromJson(json[r'providers']),
        models: Model.listFromJson(json[r'models']),
        enableCache: json[r'enable_cache'] is Iterable
            ? (json[r'enable_cache'] as Iterable).cast<bool>().toList(growable: false)
            : const [],
        preferredLanguages: json[r'preferred_languages'] is Iterable
            ? (json[r'preferred_languages'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        defaultLanguage: json[r'default_language'] is Iterable
            ? (json[r'default_language'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        defaultValues: DefaultValues.fromJson(json[r'default_values']),
      );
    }
    return null;
  }

  static List<ComponentConfig> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ComponentConfig>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ComponentConfig.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ComponentConfig> mapFromJson(dynamic json) {
    final map = <String, ComponentConfig>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ComponentConfig.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ComponentConfig-objects as value to a dart map
  static Map<String, List<ComponentConfig>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ComponentConfig>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ComponentConfig.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

