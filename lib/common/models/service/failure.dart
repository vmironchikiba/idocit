import 'package:idocit/constants/errors.dart';

abstract class Failure {
  final String message;
  const Failure(this.message, [List props = const []]) : super();
}

class CommonFailure extends Failure {
  final CommonErrorType type;

  const CommonFailure({required String message, this.type = CommonErrorType.none}) : super(message);
}

class HTTPFailure extends Failure {
  final String? comment;
  final String? additional;
  final HttpErrorType type;

  const HTTPFailure({required String message, this.comment, this.additional, this.type = HttpErrorType.none})
    : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure() : super('No Internet connection');
}

class AuthFailure extends Failure {
  final AuthErrorType type;

  const AuthFailure({required String message, required this.type}) : super(message);
}

class ChunkFailure extends Failure {
  final AuthErrorType type;

  const ChunkFailure({required String message, required this.type}) : super(message);
}
