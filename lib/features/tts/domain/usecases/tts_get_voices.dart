// import 'package:dartz/dartz.dart';
// import 'package:idocit/common/models/service/failure.dart';
// import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/logger.dart';
// import 'package:idocit/common/services/network_listener.dart';
// import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
// import 'package:idocit/features/tts/domain/services/tts_service.dart';

// class TtsGetVoices implements UseCase<Either<Failure, void>, NoParams> {
//   final NetworkListenerService networkListenerService;
//   final TtsBloc ttsBloc;
//   final TtsService ttsService;

//   const TtsGetVoices({required this.networkListenerService, required this.ttsBloc, required this.ttsService});

//   @override
//   Future<Either<Failure, void>> call(NoParams params) async {
//     LoggerService.logDebug('TtsGetVoices -> call()');
//     if (!await networkListenerService.checkNetworkConnection(() => call(params))) {
//       return const Left(NetworkFailure());
//     }
//     final voicesRaw = await ttsService.getVoices() as List<dynamic>;
//     final voices = ttsService.getAllVoices(voicesRaw).whereType<Map<String, String>>().toList();
//     ttsBloc.add(UpdateTtsVoices(voices: voices));

//     return Right(null);
//   }
// }
