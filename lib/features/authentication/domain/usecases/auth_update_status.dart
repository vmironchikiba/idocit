import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';

class AuthUpdateStatus implements UseCase<void, AuthType> {
  final AuthBloc authBloc;

  const AuthUpdateStatus({required this.authBloc});

  @override
  Future<void> call(AuthType type) async {
    LoggerService.logDebug('AuthUpdateStatus -> call(type: $type)');
    authBloc.add(UpdateAuthStatusEvent(authType: type));

    if (type == AuthType.authenticated) {
      authBloc.add(ClearAdditionalDataAuthEvent());
    }
  }
}
