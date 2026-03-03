// import 'package:dartz/dartz.dart';
// import 'package:idocit/common/models/service/failure.dart';
// import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/logger.dart';
// import 'package:idocit/common/services/network_listener.dart';
// import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
// import 'package:idocit/features/tts/domain/services/tts_service.dart';

// class TtsGetEngines implements UseCase<Either<Failure, void>, double> {
//   final NetworkListenerService networkListenerService;
//   final TtsBloc ttsBloc;
//   final TtsService ttsService;

//   const TtsGetEngines({required this.networkListenerService, required this.ttsBloc, required this.ttsService});

//   @override
//   Future<Either<Failure, void>> call(double voice) async {
//     LoggerService.logDebug('TtsGetEngines -> call()');
//     if (!await networkListenerService.checkNetworkConnection(() => call(voice))) {
//       return const Left(NetworkFailure());
//     }
//     final enginesRaw = await ttsService.getEngines() as List<dynamic>;
//     final engines = ttsService.getAllEngines(enginesRaw).whereType<String>().toList();
//     ttsBloc.add(UpdateTtsEngines(engines: engines));

//     return Right(null);
//   }
// }
