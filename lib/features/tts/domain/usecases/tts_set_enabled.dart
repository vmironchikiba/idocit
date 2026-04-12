import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';

class TtsSetEnabled implements UseCase<void, bool> {
  final NetworkListenerService networkListenerService;
  final TtsBloc ttsBloc;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsSetEnabled({
    required this.networkListenerService,
    required this.ttsBloc,
    required this.ttsPreferencesStorage,
  });

  @override
  Future<void> call(bool isEnabled) async {
    LoggerService.logDebug('TtsSetEnabled -> call($isEnabled)');
    await ttsPreferencesStorage.writeIsEnabled(isEnabled);
    ttsBloc.add(UpdateTtsIsEnabled(isEnabled: isEnabled));
  }
}
