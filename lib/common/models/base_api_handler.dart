import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/api_message.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/idocit/lib/api.dart';

abstract class BaseRepository {
  /// Универсальный метод для выполнения запросов.
  /// [T] — тип успешного ответа (UserToken, String, List и т.д.)
  Future<Either<Failure, T>> makeRequest<T, V>(Future<T> Function() request) async {
    try {
      final result = await request();
      return Right(result); // Успех, возвращаем данные
    } on ApiException catch (e) {
      if (e.code == 400) {
        return Left(UnautorizedFailure());
      }
      if (e.code == 401) {
        return Left(TokenExpiredFailure(message: e.message ?? 'Token expired', type: AuthErrorType.tokenExpired));
      }
      ApiMessage? apiMessage;
      try {
        Map<String, dynamic> decodedData = jsonDecode(e.message ?? '');
        apiMessage = ApiMessage.fromJson(decodedData);
      } catch (e) {
        apiMessage = null;
      }
      return Left(ApiFailure(code: e.code, apiMessage: apiMessage));
    } on AssertionError catch (e) {
      return Left(AssertionFailure(object: e.message, message: e.toString(), stack: e.stackTrace));
    } catch (e) {
      // Обработка непредвиденных ошибок (проблемы с парсингом, null и т.д.)
      return Left(CommonFailure(message: e.toString()));
    }
  }
}
