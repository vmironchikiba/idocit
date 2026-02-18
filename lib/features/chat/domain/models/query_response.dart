import 'package:idocit/idocit/lib/api.dart' as api;

class QueryRelatedCategories {
  String id;
  String type;
  String name;
  String description;
  String context;
  List<api.KnowledgeData> knowledgeData;
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
      List<api.KnowledgeData> parsedList = (json[r'knowledge_data'] as List? ?? [])
          .map((element) => api.KnowledgeData.fromJson(element))
          .whereType<api.KnowledgeData>()
          .toList();

      // --- SORT by numeric score (DESCENDING) ---
      parsedList.sort((a, b) {
        final double scoreA = double.tryParse(a.score) ?? 0.0;
        final double scoreB = double.tryParse(b.score) ?? 0.0;
        return scoreB.compareTo(scoreA); // high → low
      });

      return QueryRelatedCategories(
        id: api.mapValueOfType<String>(json, r'id') ?? '',
        type: api.mapValueOfType<String>(json, r'type') ?? '',
        name: api.mapValueOfType<String>(json, r'name') ?? '',
        description: api.mapValueOfType<String>(json, r'description') ?? '',
        context: api.mapValueOfType<String>(json, r'context') ?? '',
        knowledgeData: (api.mapValueOfType<List>(json, r'knowledge_data') ?? {})
            .map((elemnt) => api.KnowledgeData.fromJson(elemnt))
            .whereType<api.KnowledgeData>()
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
        sessionId: api.mapValueOfType<String>(json, r'session_id'),
      );
    }
    return null;
  }

  static const requiredKeys = <String>{'categories'};
}

class ToolCall {
  final String? id;
  final ToolFunction? function;

  ToolCall({this.id, this.function});

  factory ToolCall.fromJson(Map<String, dynamic> json) {
    return ToolCall(
      id: json['id'] as String?,
      function: json['function'] != null ? ToolFunction.fromJson(json['function']) : null,
    );
  }
}

class ToolFunction {
  final String? name;
  final ToolArguments? arguments;

  ToolFunction({this.name, this.arguments});

  factory ToolFunction.fromJson(Map<String, dynamic> json) {
    return ToolFunction(
      name: json['name'] as String?,
      arguments: json['arguments'] != null ? ToolArguments.fromJson(json['arguments']) : null,
    );
  }
}

class ToolArguments {
  final String? type;
  final String? node;

  final List? data;
  final num? elapsedMs;
  final Map<String, dynamic>? meta;
  final String? message;
  final String? traceId;
  final String? finishReason;

  ToolArguments({
    this.type,
    this.node,
    this.data,
    this.elapsedMs,
    this.meta,
    this.message,
    this.traceId,
    this.finishReason,
  });

  factory ToolArguments.fromJson(Map<String, dynamic> json) {
    return ToolArguments(
      type: json['type'] as String?,
      node: json['node'] as String?,
      data: json['data'] as List?,
      elapsedMs: json['elapsed_ms'] as num?,
      meta: json['meta'] as Map<String, dynamic>?,
      message: json['message'] as String?,
      traceId: json['trace_id'] as String?,
      finishReason: json['finish_reason'] as String?,
    );
  }
}

class GenerationResult {
  final String? system;

  GenerationResult({this.system});

  factory GenerationResult.fromJson(Map<String, dynamic> json) {
    return GenerationResult(system: json['system'] as String?);
  }
}

class Generation {
  final QueryResponse? knowledge;
  final GenerationResult? generationResult;

  Generation({this.knowledge, this.generationResult});

  factory Generation.fromJson(Map<String, dynamic> json) {
    return Generation(
      knowledge: json['knowledge'] != null ? QueryResponse.fromJson(json['knowledge']) : null,
      generationResult: json['generation_result'] != null ? GenerationResult.fromJson(json['generation_result']) : null,
    );
  }
}

class UpdatesPayload {
  final Generation? generation;

  UpdatesPayload({this.generation});

  factory UpdatesPayload.fromJson(Map<String, dynamic> json) {
    return UpdatesPayload(generation: json['generation'] != null ? Generation.fromJson(json['generation']) : null);
  }
}

extension ToolArgumentsX on ToolArguments {
  UpdatesPayload? get updatesPayload {
    if (data == null || data!.length < 2) return null;
    if (data![0] != 'updates') return null;

    final map = data![1];
    if (map is! Map<String, dynamic>) return null;

    return UpdatesPayload.fromJson(map);
  }
}

class Delta {
  final List<dynamic>? toolCalls;
  final String? content;

  Delta({required this.toolCalls, required this.content});
  factory Delta.fromJson(Map<String, dynamic> json) {
    return Delta(toolCalls: json['tool_calls'], content: json['content']);
  }
}
