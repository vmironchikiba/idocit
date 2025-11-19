import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/strings.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/api/chat_remote_datasource.dart';
import 'package:idocit/features/chat/domain/models/completions_request.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';
import 'package:idocit/features/chat/domain/datasources/open_ai_stream_api.dart';
import 'package:idocit/idocit/lib/api.dart';

class ChatLazyInitSuggestions implements UseCase<Either<Failure, void>, CompletionRequest> {
  final NetworkListenerService networkListenerService;
  final ChatBloc chatBloc;
  final AuthBloc authBloc;
  final ChatRemoteDataSource chatRemoteDataSource;

  ChatLazyInitSuggestions({
    required this.networkListenerService,
    required this.chatBloc,
    required this.authBloc,
    required this.chatRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> call(CompletionRequest request) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    OpenAIStreamApi(basePath: StringsConstants.basePath)
        .streamChatCompletions(request.toChatCompletionRequest(), token.accessToken)
        .listen(
          (chunk) => chatBloc.add(SetChunkEvent(chunk: chunk)),
          onError: (err) => Left(CommonFailure(message: err.toString(), type: CommonErrorType.badResponseData)),
          onDone: () => LoggerService.logDebug('End-of-completions-streem'),
        );
    return Right(null);
  }
}
