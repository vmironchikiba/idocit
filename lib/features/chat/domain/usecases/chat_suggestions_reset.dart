import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/api/chat_remote_datasource.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';

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
