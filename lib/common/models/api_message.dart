import 'package:idocit/idocit/lib/api.dart';

class ApiMessage {
  final String statusMessage;
  ApiMessage({required this.statusMessage});
  static ApiMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();
      return ApiMessage(statusMessage: mapValueOfType<String>(json, r'status_msg') ?? 'unknown');
    }
    return null;
  }
}
