import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';
import 'package:idocit/idocit/lib/api.dart';

class IdocGetChats implements UseCase<Either<Failure, List<ChatSummary>>, IdocItPage> {
  static const int limit = 500;
  final NetworkListenerService networkListenerService;
  final AuthBloc authBloc;
  final IdocItRemoteDataSource idocItRemoteDataSource;
  final AuthAutoSignIn authAutoSignIn;

  const IdocGetChats({
    required this.networkListenerService,
    required this.authBloc,
    required this.idocItRemoteDataSource,
    required this.authAutoSignIn,
  });

  @override
  Future<Either<Failure, List<ChatSummary>>> call(IdocItPage page) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    if (!await networkListenerService.checkNetworkConnection(() => call(page))) {
      return const Left(NetworkFailure());
    }
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final chatsResult = await idocItRemoteDataSource.getChats(token, limit: page.limit, offset: page.offset);
    return chatsResult.fold(
      (failure) async {
        if (failure is TokenExpiredFailure) {
          return (await authAutoSignIn.call(NoParams())).fold((authFailure) => Left(authFailure), (_) => call(page));
        } else {
          return Left(failure);
        }
      },
      (result) async {
        return Right(result);
      },
    );
  }
}

class IdocItPage {
  final int limit;
  final int offset;
  IdocItPage({required this.limit, required this.offset});
}
