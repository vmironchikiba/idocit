import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/domain/datasources/document_datasource.dart';
import 'package:idocit/idocit/lib/api.dart';

class GetDocumentById implements UseCase<Either<Failure, void>, GetDocumentPayload> {
  final NetworkListenerService networkListenerService;
  final DocumentBloc documentBloc;
  final AuthBloc authBloc;
  final DocumentRemoteDataSource documentRemoteDataSource;

  const GetDocumentById({
    required this.networkListenerService,
    required this.documentBloc,
    required this.authBloc,
    required this.documentRemoteDataSource,
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
        documentBloc.add(SetIsInProcess(isInProcess: false));
        return Left(NetworkFailure());
      },
      (result) async {
        documentBloc.add(SetDocumentResponseEvent(documentResponse: result));
        documentBloc.add(SetIsInProcess(isInProcess: false));
        return Right(null);
      },
    );
  }
}
