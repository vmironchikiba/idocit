import 'package:idocit/common/models/service/secure_datasource.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/idocit/lib/api.dart';
// import 'package:idocit/features/authentication/domain/models/tokens_data.dart';

class AuthSecureStorage extends AbstractSecureDatasource {
  AuthSecureStorage() : super(id: 'auth');

  Future<UserToken?> readTokensData() async {
    try {
      LoggerService.logDebug('AuthSecureStorage -> readTokensData()');
      final accessToken = await AuthSecureStorage().read('tokens.access_token');
      final refreshToken = await AuthSecureStorage().read('tokens.refresh_token');
      final expiresIn = await AuthSecureStorage().read('tokens.expires_in');
      final type = await AuthSecureStorage().read('tokens.token_type');

      if (accessToken != null && refreshToken != null && expiresIn != null && type != null) {
        return UserToken(
          accessToken: accessToken,
          tokenType: type,
          refreshToken: refreshToken,
          expiresIn: int.tryParse(expiresIn) ?? 0,
        );
      }
    } catch (e) {
      LoggerService.logDebug('AuthSecureStorage->readTokensData error: ${e.toString()}');
      return null;
    }

    return null;
  }

  Future<void> writeTokensData(UserToken data) async {
    try {
      LoggerService.logDebug('AuthSecureStorage -> writeTokensData()');
      await AuthSecureStorage().write('tokens.access_token', data.accessToken);
      await AuthSecureStorage().write('tokens.refresh_token', data.refreshToken);
      await AuthSecureStorage().write('tokens.expires_in', data.expiresIn.toString());
      await AuthSecureStorage().write('tokens.token_type', data.tokenType);
    } catch (e) {
      LoggerService.logDebug('AuthSecureStorage->writeTokensData error: ${e.toString()}');
    }
  }

  Future<void> deleteTokensData() async {
    try {
      LoggerService.logDebug('AuthSecureStorage -> deleteTokensData()');
      await AuthSecureStorage().delete('tokens.access_token');
      await AuthSecureStorage().delete('tokens.refresh_token');
      await AuthSecureStorage().delete('tokens.expires_in');
      await AuthSecureStorage().delete('tokens.token_type');
    } catch (e) {
      LoggerService.logDebug('AuthSecureStorage->deleteTokensData error: ${e.toString()}');
    }
  }
}
