import 'package:idocit/idocit/lib/api.dart';

class QueryRelatedCategories {
  String id;
  String type;
  String name;
  String description;
  String context;
  List<KnowledgeData> knowledgeData;
  QueryRelatedCategories({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.context,
    required this.knowledgeData,
  });
  static QueryRelatedCategories? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        for (var key in requiredKeys) {
          assert(json.containsKey(key), 'Required key "DeleteCategoriesPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteCategoriesPayload[$key]" has a null value in JSON.');
        }
        return true;
      }());

      // --- Parse the list as usual ---
      List<KnowledgeData> parsedList = (json[r'knowledge_data'] as List? ?? [])
          .map((element) => KnowledgeData.fromJson(element))
          .whereType<KnowledgeData>()
          .toList();

      // --- SORT by numeric score (DESCENDING) ---
      parsedList.sort((a, b) {
        final double scoreA = double.tryParse(a.score) ?? 0.0;
        final double scoreB = double.tryParse(b.score) ?? 0.0;
        return scoreB.compareTo(scoreA); // high → low
      });

      return QueryRelatedCategories(
        id: mapValueOfType<String>(json, r'id') ?? '',
        type: mapValueOfType<String>(json, r'type') ?? '',
        name: mapValueOfType<String>(json, r'name') ?? '',
        description: mapValueOfType<String>(json, r'description') ?? '',
        context: mapValueOfType<String>(json, r'context') ?? '',
        knowledgeData: (mapValueOfType<List>(json, r'knowledge_data') ?? {})
            .map((elemnt) => KnowledgeData.fromJson(elemnt))
            .whereType<KnowledgeData>()
            .toList(),
      );
    }
    return null;
  }

  static const requiredKeys = <String>{'id', 'type', 'name', 'description', 'context'};
}

class QueryResponse {
  List<QueryRelatedCategories> categories;
  String? sessionId;
  QueryResponse({required this.categories, this.sessionId});
  static QueryResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        for (var key in requiredKeys) {
          assert(json.containsKey(key), 'Required key "DeleteCategoriesPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DeleteCategoriesPayload[$key]" has a null value in JSON.');
        }
        return true;
      }());

      return QueryResponse(
        categories: ((json[r'categories'] as List?) ?? [])
            .map((element) => QueryRelatedCategories.fromJson(element))
            .whereType<QueryRelatedCategories>()
            .toList(),
        sessionId: mapValueOfType<String>(json, r'session_id'),
      );
    }
    return null;
  }

  static const requiredKeys = <String>{'categories'};
}
