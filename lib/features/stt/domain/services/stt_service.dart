import 'dart:async';
import 'dart:math';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/speech_to_text_config.dart';
import 'package:idocit/injection_container.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SttService {
  final SpeechToText speech = SpeechToText();
  bool _hasSpeech = false;
  bool get hasSpeech => _hasSpeech;
  // List<LocaleName> _localeNames = [];

  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;

  SttBloc sttBloc = locator<SttBloc>();

  SpeechToTextConfig currentOptions = SpeechToTextConfig(
    SpeechListenOptions(
      listenMode: ListenMode.confirmation,
      onDevice: false,
      cancelOnError: true,
      partialResults: true,
      autoPunctuation: true,
      enableHapticFeedback: true,
    ),
    "",
    3,
    30,
    false,
    false,
  );

  SttService() {
    //initTts();
  }

  Future<void> initSpeechState() async {
    LoggerService.logDebug('Initialize');
    try {
      var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: currentOptions.debugLogging,
      );
      if (hasSpeech) {
        speech.unexpectedPhraseAggregator = _punctAggregator;
        // Get the list of languages installed on the supporting platform so they
        // can be displayed in the UI for selection by the user.
        sttBloc.add(UpdateSttLocalNames(localeNames: await speech.locales()));
        var systemLocale = await speech.systemLocale();
        sttBloc.add(UpdateSttSystemLocale(systemLocale: await speech.systemLocale()));
        currentOptions = currentOptions.copyWith(localeId: systemLocale?.localeId ?? '');
      }

      _hasSpeech = hasSpeech;
    } catch (e) {
      _hasSpeech = false;
    }
  }

  void statusListener(String status) {
    _logEvent('Received listener status: $status, listening: ${speech.isListening}');
    sttBloc.add(UpdateSttLastStatus(lastStatus: status));
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent('Received error status: $error, listening: ${speech.isListening}');
    sttBloc.add(UpdateSttLastError(lastError: error));
  }

  void _logEvent(String eventDescription) {
    if (currentOptions.logEvents) {
      var eventTime = DateTime.now().toIso8601String();
      LoggerService.logDebug('$eventTime $eventDescription');
    }
  }

  String _punctAggregator(List<String> phrases) {
    return phrases.join('. ');
  }

  void startListening() {
    _logEvent('start listening');
    sttBloc.add(UpdateSttLastWords(lastWords: ''));
    sttBloc.add(UpdateSttLastError(lastError: null));

    // Note that `listenFor` is the maximum, not the minimum, on some
    // systems recognition will be stopped before this value is reached.
    // Similarly `pauseFor` is a maximum not a minimum and may be ignored
    // on some devices.
    speech.listen(
      onResult: resultListener,
      listenFor: Duration(seconds: currentOptions.listenFor),
      pauseFor: Duration(seconds: currentOptions.pauseFor),
      localeId: currentOptions.localeId,
      onSoundLevelChange: soundLevelListener,
      listenOptions: currentOptions.options,
    );
  }

  void stopListening() {
    _logEvent('stop');
    speech.stop();
    sttBloc.add(UpdateSttLevel(level: 0.0));
  }

  void resultListener(SpeechRecognitionResult result) {
    _logEvent('Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');

    // lastWords = '${result.recognizedWords} - ${result.finalResult}';
    sttBloc.add(UpdateSttFinalResult(finalResult: result.finalResult));
    sttBloc.add(UpdateSttLastWords(lastWords: result.recognizedWords));
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    sttBloc.add(UpdateSttLevel(level: level));
  }
}
