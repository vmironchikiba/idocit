import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';

class OpenAIStreamApi {
  final http.Client httpClient;

  String basePath;
  String? token;

  OpenAIStreamApi({this.basePath = 'http://localhost', http.Client? httpClient})
    : httpClient = httpClient ?? http.Client();

  /// Stream NDJSON chat completions
  Stream<ChatCompletionChunk> streamChatCompletions(ChatCompletionRequest request, String? token) async* {
    final url = Uri.parse('$basePath/api/v1/chat/completions');

    // final token1 =
    //     'eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJmOE4tSHdqM2k0MWVoWTMxSVZIOVZsOG1XOHpQN29zX25MaXN1X3U2d3hnIn0.eyJleHAiOjE3NjI5NTk4ODksImlhdCI6MTc2Mjk1ODA4OSwianRpIjoiNTZiNmU4M2QtYTc0OS00MmU0LTlkODUtNjdkNWE3ZGQzZGE2IiwiaXNzIjoiaHR0cHM6Ly9hc3Npc3RhbnQtYXV0aC5pYmFncm91cGl0LmNvbS9yZWFsbXMvaURvY2l0IiwiYXVkIjoiYWNjb3VudCIsInN1YiI6ImM1ZDdhODdkLThjZjEtNDA2Mi05M2Q4LTgzNmY2Njg1ZjNkMyIsInR5cCI6IkJlYXJlciIsImF6cCI6Imlkb2NpdF9wcm9kIiwic2lkIjoiNDliMTE5MTktZjg3Yi00OWQyLTg2YmQtYmQwOTI0ZGE0Zjc1IiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyIqIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJpZG9jaXRfdXNlciIsImRlZmF1bHQtcm9sZXMtaWRvY2l0Iiwib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiJdfSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoib3BlbmlkIHByb2ZpbGUgZW1haWwiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsInJvbGVzIjpbImlkb2NpdF91c2VyIiwiZGVmYXVsdC1yb2xlcy1pZG9jaXQiLCJvZmZsaW5lX2FjY2VzcyIsInVtYV9hdXRob3JpemF0aW9uIl0sIm5hbWUiOiJLYXpha2hzdGFuIEF1ZGl0IiwicHJlZmVycmVkX3VzZXJuYW1lIjoia2F6X2F1ZGl0IiwiZ2l2ZW5fbmFtZSI6IkthemFraHN0YW4iLCJmYW1pbHlfbmFtZSI6IkF1ZGl0IiwidGVuYW50Ijoia2F6X2F1ZGl0IiwiZW1haWwiOiJrYXpfYXVkaXRAZGVtby5jb20ifQ.BWpZAJSIsq603pw9Nvjex2dppn50F69GrIgUCKIZP_WGZgx_eoWXFnTc_linVaDFrQND5GRmV4TdUh48Hs-DlGmTBWjGESazcBvAt340I8drX0qnrK7GyZFvb503T-n0NEt_xwY86YS_9Hjnm3RYz7PxarZpxowFkRNEcGUBocNP9seG_JTWsQ3dPS4EOIhHv45IOcmmV1FLBPEHreNTV15FxbkK3eXWtw6uP5c2a-ftBgVDTNDAUmTCW4V4gLeL6l1IsyZ9CI82tHTOUSciJx3Wx0G3r3bq0zyy2pyogE6q0KGEW8lZhmhvNNJOvqweHxMt00DiWcwBurzSb3OwFA';

    final streamedResponse = await httpClient.send(
      http.Request('POST', url)
        ..headers.addAll({'Content-Type': 'application/json', if (token != null) 'Authorization': 'Bearer $token'})
        ..body = jsonEncode(request.toJson()),
    );
    if (streamedResponse.statusCode < 200 || streamedResponse.statusCode >= 300) {
      final body = await streamedResponse.stream.bytesToString();
      throw Exception('API Error: HTTP ${streamedResponse.statusCode} → $body');
    }

    final lines = streamedResponse.stream.transform(utf8.decoder).transform(const LineSplitter());

    await for (final line in lines) {
      if (line.trim().isEmpty) continue;
      try {
        final chunk = ChatCompletionChunk.fromJson(jsonDecode(line) as Map<String, dynamic>);
        if (chunk != null) yield chunk;
      } catch (e) {
        LoggerService.logDebug(e.toString());
        continue;
      }
    }
  }
}
