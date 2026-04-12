import 'package:dartz/dartz.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';

class TtsGetEnabled implements UseCase<Either<Failure, void>, NoParams> {
  final NetworkListenerService networkListenerService;
  final TtsBloc ttsBloc;
  // final TtsService ttsService;
  final TtsPreferencesStorage ttsPreferencesStorage;

  const TtsGetEnabled({
    required this.networkListenerService,
    required this.ttsBloc,
    // required this.ttsService,
    required this.ttsPreferencesStorage,
  });

  @override
  Future<Either<Failure, void>> call(NoParams isEnabled) async {
    final isEnabled = await ttsPreferencesStorage.readIsEnabled();
    ttsBloc.add(UpdateTtsIsEnabled(isEnabled: isEnabled));
    return Right(null);
  }
}
