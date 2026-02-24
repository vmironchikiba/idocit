import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';

class ChatSuggestionsReset implements UseCase<Either<Failure, void>, NoParams> {
  final ChatBloc chatBloc;

  const ChatSuggestionsReset({required this.chatBloc});

  @override
  Future<Either<Failure, void>> call(params) async {
    LoggerService.logDebug('ChatSuggestionsReset -> call()');
    chatBloc.add(ResetSuggestionsEvent());
    return Right(null);
  }
}
