import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';

class TtsGetLanguages implements UseCase<void, NoParams> {
  final NetworkListenerService networkListenerService;
  final TtsBloc ttsBloc;
  final TtsService ttsService;

  const TtsGetLanguages({required this.networkListenerService, required this.ttsBloc, required this.ttsService});

  @override
  Future<void> call(NoParams params) async {
    LoggerService.logDebug('TtsGetLanguages -> call()');
    final languages = await ttsService.getLanguages();
    ttsBloc.add(UpdateTtsLanguages(languages: languages));
  }
}
