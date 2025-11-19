import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';

import 'package:idocit/injection_container.dart';

class ChatInit implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final ChatBloc idocItBloc;

  const ChatInit({required this.networkListenerService, required this.idocItBloc});

  @override
  Future<Either<Failure, void>> call(NoParams params, {bool isCleanReset = false, bool withArchivedDate = true}) async {
    LoggerService.logDebug('IdocItInit -> call(isCleanReset: $isCleanReset, withArchivedDate: $withArchivedDate)');

    if (!await networkListenerService.checkNetworkConnection(
      () => call(params, isCleanReset: isCleanReset, withArchivedDate: withArchivedDate),
    )) {
      return const Left(NetworkFailure());
    }
    final chatsResult = await locator<ChatLazyInitSuggestions>().call(NoParams());
    return chatsResult.fold(
      (failure) async {
        return Left(failure);
      },
      (_) async {
        return Right(null);
      },
    );
  }
}
