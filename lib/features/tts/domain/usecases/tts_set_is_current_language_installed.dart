import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';

class TtsSetIsCurrentLanguageInstalled implements UseCase<void, bool> {
  final TtsBloc ttsBloc;

  const TtsSetIsCurrentLanguageInstalled({required this.ttsBloc});

  @override
  Future<void> call(bool isCurrentLanguageInstalled) async =>
      ttsBloc.add(UpdateTtsIsCurrentLanguageInstalled(isCurrentLanguageInstalled: isCurrentLanguageInstalled));
}
