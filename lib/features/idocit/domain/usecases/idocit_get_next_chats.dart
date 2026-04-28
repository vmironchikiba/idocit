import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_get_chats.dart';

class IdocGetNextChats implements UseCase<Either<Failure, void>, NoParams> {
  final IdocItBloc idocItBloc;
  final IdocGetChats getChats;

  const IdocGetNextChats({required this.idocItBloc, required this.getChats});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final limit = idocItBloc.state.limit;
    final offset = idocItBloc.state.offset + limit;
    final canGoBack = offset > 0;

    final chatsResult = await getChats.call(IdocItPage(limit: limit, offset: offset));
    return chatsResult.fold((failure) => Left(failure), (chats) {
      if (chats.length > limit) return Left(NetworkFailure());
      final canGoForward = chats.length == limit;
      idocItBloc.add(
        SetChatsEvent(chats: chats, offset: offset, limit: limit, canGoBack: canGoBack, canGoForward: canGoForward),
      );
      return Right(null);
    });
  }
}
