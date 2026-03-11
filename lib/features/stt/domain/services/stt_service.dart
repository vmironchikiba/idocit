import 'dart:async';
import 'dart:math';
import 'package:idocit/common/services/logger.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TtsService {
  final SpeechToText speech = SpeechToText();
  bool _hasSpeech = false;
  List<LocaleName> _localeNames = [];
  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';

  SpeechExampleConfig currentOptions = SpeechExampleConfig(
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
  TtsService() {
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
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        currentOptions = currentOptions.copyWith(localeId: systemLocale?.localeId ?? '');
      }

      _hasSpeech = hasSpeech;
    } catch (e) {
      lastError = 'Speech recognition failed: ${e.toString()}';
      _hasSpeech = false;
    }
  }

  void statusListener(String status) {
    _logEvent('Received listener status: $status, listening: ${speech.isListening}');

    lastStatus = status;
  }

  void errorListener(SpeechRecognitionError error) {
    _logEvent('Received error status: $error, listening: ${speech.isListening}');

    lastError = '${error.errorMsg} - ${error.permanent}';
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
    lastWords = '';
    lastError = '';
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

  void resultListener(SpeechRecognitionResult result) {
    _logEvent('Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');

    lastWords = '${result.recognizedWords} - ${result.finalResult}';
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
    this.level = level;
  }
}

class SpeechExampleConfig {
  final SpeechListenOptions options;
  final String localeId;
  final bool logEvents;
  final bool debugLogging;
  final int pauseFor;
  final int listenFor;

  SpeechExampleConfig(this.options, this.localeId, this.pauseFor, this.listenFor, this.logEvents, this.debugLogging);
  SpeechExampleConfig copyWith({
    SpeechListenOptions? options,
    String? localeId,
    bool? logEvents,
    int? pauseFor,
    int? listenFor,
    bool? debugLogging,
  }) {
    return SpeechExampleConfig(
      options ?? this.options,
      localeId ?? this.localeId,
      pauseFor ?? this.pauseFor,
      listenFor ?? this.listenFor,
      logEvents ?? this.logEvents,
      debugLogging ?? this.debugLogging,
    );
  }
}
