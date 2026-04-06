import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/presets/domain/blocs/presets_bloc.dart';
import 'package:idocit/features/presets/domain/datasources/presets_remote_datasource.dart';

class GetAllPresets implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final PresetsBloc presetsBloc;
  final AuthBloc authBloc;
  final PresetsRemoteDataSource presetsRemoteDataSource;

  const GetAllPresets({
    required this.networkListenerService,
    required this.presetsBloc,
    required this.authBloc,
    required this.presetsRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('ChatGetComponents -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    final componentsResult = await presetsRemoteDataSource.getAllPresets(token);
    return componentsResult.fold(
      (failure) async {
        return Left(failure);
      },
      (presets) async {
        presetsBloc.add(UpdatePresetsEvent(presets: presets));
        return Right(null);
      },
    );
  }
}
