import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';

import 'package:idocit/injection_container.dart';

class ChaReset implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;

  const ChaReset({required this.networkListenerService, required this.chatBloc});

  @override
  Future<Either<Failure, void>> call(NoParams params, {bool isCleanReset = false, bool withArchivedDate = true}) async {
    LoggerService.logDebug('ChatInit -> call(isCleanReset: $isCleanReset, withArchivedDate: $withArchivedDate)');

    if (!await networkListenerService.checkNetworkConnection(
      () => call(params, isCleanReset: isCleanReset, withArchivedDate: withArchivedDate),
    )) {
      return const Left(NetworkFailure());
    }
    chatBloc.add(ChatResettEvent());
    return Right(null);
  }
}
