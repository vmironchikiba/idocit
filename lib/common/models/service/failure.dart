import 'package:idocit/constants/errors.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

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

class UnautorizedFailure extends Failure {
  const UnautorizedFailure() : super('Autorization failed');
}

class AuthFailure extends Failure {
  final AuthErrorType type;

  const AuthFailure({required String message, required this.type}) : super(message);
}

class TokenExpiredFailure extends Failure {
  final AuthErrorType type;

  const TokenExpiredFailure({required String message, required this.type}) : super(message);
}

class ChunkFailure extends Failure {
  final AuthErrorType type;

  const ChunkFailure({required String message, required this.type}) : super(message);
}

class SttNotExistsFailure extends Failure {
  const SttNotExistsFailure() : super('No speech-to-text');
}

class SttSpeechFailure extends Failure {
  final SpeechRecognitionError? error;
  const SttSpeechFailure({this.error}) : super('Speech error');
}
