import 'package:idocit/common/models/service/failure.dart';

enum CommonErrorType { badUsecaseData, badRequestData, badResponseData, badLink, none }

extension CommonErrorExtension on CommonErrorType {
  CommonFailure convertToFailure() {
    switch (this) {
      case CommonErrorType.badUsecaseData:
        return const CommonFailure(message: 'Bad usecase data', type: CommonErrorType.badUsecaseData);

      case CommonErrorType.badRequestData:
        return const CommonFailure(message: 'Bad request data', type: CommonErrorType.badRequestData);

      case CommonErrorType.badResponseData:
        return const CommonFailure(message: 'Bad response data', type: CommonErrorType.badResponseData);

      case CommonErrorType.badLink:
        return const CommonFailure(message: 'Bad link', type: CommonErrorType.badLink);

      default:
        return const CommonFailure(message: 'Unknown failure');
    }
  }
}

enum AuthErrorType { badCredentials, badTokensData, needConfirmUser, needConfirmPersonalData, needConfirmHome }

extension AuthErrorExtension on AuthErrorType {
  AuthFailure convertToFailure() {
    switch (this) {
      case AuthErrorType.badCredentials:
        return const AuthFailure(message: 'Bad credentials', type: AuthErrorType.badCredentials);

      case AuthErrorType.badTokensData:
        return const AuthFailure(message: 'Bad tokens data', type: AuthErrorType.badTokensData);

      case AuthErrorType.needConfirmUser:
        return const AuthFailure(message: 'Need confirm user', type: AuthErrorType.needConfirmUser);

      case AuthErrorType.needConfirmPersonalData:
        return const AuthFailure(message: 'Need confirm personal data', type: AuthErrorType.needConfirmPersonalData);

      case AuthErrorType.needConfirmHome:
        return const AuthFailure(message: 'Need confirm home', type: AuthErrorType.needConfirmHome);
    }
  }
}

enum HttpErrorType {
  badConfirmationCode,
  userNotConfirmed,
  badAuthToken,
  attemptLimitExceeded,
  badProviderResponse,
  none,
}

enum ChatErrorType { chunkError, none }

extension HttpErrorExtension on HttpErrorType {
  static HTTPFailure getErrorByCode(int? code, String? comment, String? additional) {
    switch (code) {
      case 400:
        {
          if (comment == 'Invalid verification code provided, please try again.') {
            return HTTPFailure(
              message: 'Auth failure',
              comment: 'Verification code is not valid.\nPlease try again.',
              additional: additional,
              type: HttpErrorType.badConfirmationCode,
            );
          }

          if (comment == 'User is not confirmed.') {
            return HTTPFailure(
              message: 'Request failure',
              comment: 'User not confirmed.\nPlease sent code.',
              additional: additional,
              type: HttpErrorType.userNotConfirmed,
            );
          }

          if (comment == 'Attempt limit exceeded, please try after some time.') {
            return HTTPFailure(
              message: 'Request failure',
              comment: comment,
              additional: additional,
              type: HttpErrorType.attemptLimitExceeded,
            );
          }

          if (comment == 'invalid_request') {
            return HTTPFailure(
              message: 'Invalid request',
              comment: 'Request is incorrect.\nPlease retry.',
              additional: additional,
              type: HttpErrorType.badProviderResponse,
            );
          }

          return HTTPFailure(message: 'Auth failure', comment: comment, additional: additional);
        }

      case 401:
        {
          if (comment == 'Access Token has expired' || comment == 'The incoming token has expired') {
            return HTTPFailure(
              message: 'Auth failure',
              comment: comment,
              additional: additional,
              type: HttpErrorType.badAuthToken,
            );
          }

          return HTTPFailure(message: 'Auth failure', comment: comment, additional: additional);
        }

      case 409:
        return HTTPFailure(message: 'Conflict failure', comment: comment, additional: additional);

      case 422:
        return HTTPFailure(message: 'Validation failure', comment: comment, additional: additional);

      default:
        return HTTPFailure(message: 'Unknown failure', comment: comment, additional: additional);
    }
  }
}
