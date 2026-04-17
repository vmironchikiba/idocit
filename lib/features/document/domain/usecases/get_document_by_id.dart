import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/domain/datasources/document_datasource.dart';
import 'package:idocit/idocit/lib/api.dart';

class GetDocumentById implements UseCase<Either<Failure, void>, GetDocumentPayload> {
  final NetworkListenerService networkListenerService;
  final DocumentBloc documentBloc;
  final AuthBloc authBloc;
  final DocumentRemoteDataSource documentRemoteDataSource;
  final AuthAutoSignIn authAutoSignIn;

  const GetDocumentById({
    required this.networkListenerService,
    required this.documentBloc,
    required this.authBloc,
    required this.documentRemoteDataSource,
    required this.authAutoSignIn,
  });

  @override
  Future<Either<Failure, void>> call(GetDocumentPayload payload) async {
    LoggerService.logDebug('IdocItLazyInitChats -> call()');
    final token = authBloc.state.userToken;
    if (token == null) return Left(AuthFailure(message: 'Token is empty', type: AuthErrorType.badTokensData));
    documentBloc.add(SetIsInProcess(isInProcess: true));
    final chatsResult = await documentRemoteDataSource.getDocument(token, payload);
    return chatsResult.fold(
      (failure) async {
        if (failure is TokenExpiredFailure) {
          return (await authAutoSignIn.call(NoParams())).fold((authFailure) => Left(authFailure), (_) => call(payload));
        } else {
          documentBloc.add(SetIsInProcess(isInProcess: false));
          return Left(failure);
        }
      },
      (result) async {
        documentBloc.add(SetDocumentResponseEvent(documentResponse: result));
        documentBloc.add(SetIsInProcess(isInProcess: false));
        return Right(null);
      },
    );
  }
}
