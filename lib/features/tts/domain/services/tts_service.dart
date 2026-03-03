import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/entities/tts_language.dart';
import 'package:idocit/features/tts/domain/entities/tts_voice.dart';
import 'package:idocit/features/tts/domain/enums/tts_state_enum.dart';
import 'package:idocit/injection_container.dart';

class TtsService {
  // late FlutterTts flutterTts;
  // TtsStateEnum ttsState = TtsStateEnum.stopped;
  String? engine;
  List<Map<String, String>?> rawVoices = [];
  // List<DropdownMenuItem<Map<String, String>?>> voiceItems = [];
  Completer<void> _voiceDataReadyCompleter = Completer<void>();
  Map<String, String>? voice;
  bool getDefaultVoiceRetried = false;
  List<String?> rawLanguages = [];
  String? language;
  double volume = 0.8;
  double pitch = 1.0;
  double rate = !kIsWeb ? 0.5 : 0.9;
  bool isCurrentLanguageInstalled = false;
  String? _newVoiceText;
  List<String> engines = [];
  List<String> languages = [];
  List<Map<String, String>> voices = [];

  final _tts = FlutterTts();
  FlutterTts get tts => _tts;

  bool get isPlaying => locator<TtsBloc>().state.ttsState == TtsStateEnum.playing;
  bool get isStopped => locator<TtsBloc>().state.ttsState == TtsStateEnum.stopped;
  bool get isPaused => locator<TtsBloc>().state.ttsState == TtsStateEnum.paused;
  bool get isContinued => locator<TtsBloc>().state.ttsState == TtsStateEnum.continued;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  TtsService() {
    initTts();
  }

  void initTts() {
    tts.awaitSpeakCompletion(true).then((onValue) {
      tts.setStartHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.playing)));
      tts.setCompletionHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped)));
      tts.setCancelHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped)));
      tts.setPauseHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.paused)));
      tts.setContinueHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.continued)));
      tts.setErrorHandler((msg) {
        LoggerService.logDebug(msg);
        locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped));
      });
    });
  }

  Future<dynamic> getEnginesTts() async => await tts.getEngines;
  Future<dynamic> getVoicesTts() async => await tts.getVoices;
  Future<dynamic> getLanguagesTts() async => await tts.getLanguages;
  Future<dynamic> getDefaultEngineTts() async => await tts.getDefaultEngine;
  Future<dynamic> getDefaultVoiceTts() async => await tts.getDefaultVoice;
  Future<dynamic> getMaxSpeechInputLengthTts() async => tts.getMaxSpeechInputLength;

  Future<dynamic> setVolume(double volume) async => await tts.setVolume(volume);
  Future<dynamic> setSpeechRate(double rate) async => await tts.setSpeechRate(rate);
  Future<dynamic> setPitch(double pitch) async => await tts.setPitch(pitch);

  Future<dynamic> speak(String text, {bool focus = false}) => tts.speak(text, focus: focus);
  Future<dynamic> awaitSpeakCompletion(bool awaitCompletion) => tts.awaitSpeakCompletion(awaitCompletion);
  Future<dynamic> stop() => tts.stop();
  Future<dynamic> pause() => tts.pause();
  Future<dynamic> setEngine(String engine) => setEngine(engine);
  Future<dynamic> setVoice(Map<String, String> voice) => tts.setVoice(voice);
  Future<dynamic> setVoiceTts(TtsVoice voice) => tts.setVoice(voice.toJson());
  Future<dynamic> setLanguage(String language) => tts.setLanguage(language);
  Future<dynamic> isLanguageInstalled(String language) => tts.isLanguageInstalled(language);
  Future<dynamic> synthesizeToFile(String text, String fileName, [bool isFullPath = false]) =>
      tts.synthesizeToFile(text, fileName, isFullPath);

  // Future<List<TtsVoice>> getVoices() async {
  //   final raw = await getVoicesTts();
  //   final voices = (raw as List)
  //       .whereType<Map>()
  //       .map((e) => TtsVoice(name: e['name'] ?? '', locale: e['locale'] ?? ''))
  //       .toList();

  //   return voices;
  // }

  Future<TtsVoice?> getDefaultVoice() async {
    final raw = await tts.getDefaultVoice;
    final voice = raw as Map?;
    return voice == null
        ? null
        : TtsVoice(name: voice['name'] ?? '', locale: voice['locale'] ?? '', quality: voice['quality'] ?? '');
  }

  Future<List<TtsLanguage>> getLanguages() async {
    final raw = await tts.getLanguages;

    return (raw as List).whereType<String>().map((e) => TtsLanguage(e)).toList();
  }

  Future<List<TtsEngine>> getEngineses() async {
    final raw = await getEnginesTts();

    return (raw as List)
        .whereType<String>()
        .map((e) => TtsEngine(e))
        .toList()
        .where((voice) => voice.name == 'en-US' || voice.name == 'ru-RU')
        .toList();
    ;
  }

  Future<TtsEngine?> getDefaultEngine() async {
    final raw = await _tts.getDefaultEngine;
    final engine = raw as String?;
    return engine == null ? null : TtsEngine(engine);
  }

  // Future<List<TtsVoice>> getVoices() async {
  //   final voices = await getVoicesTts() as List<dynamic>;
  //   rawVoices = voices.map((item) => Map<String, String>.from(item)).toList();
  //   rawVoices.sort((a, b) => a.toString().toLowerCase().compareTo(b.toString().toLowerCase()));
  //   return voices.map((voice) => voice != null ? TtsVoice.fromJson(voice) : null).whereType<TtsVoice>().toList();
  // }

  Future<List<TtsVoice>> getVoices() async {
    final List<dynamic> voices = await getVoicesTts();

    final convertedVoices = voices.map((item) {
      final map = Map<String, dynamic>.from(item as Map);
      return map;
    }).toList();

    rawVoices = convertedVoices.map((e) => Map<String, String>.from(e)).toList();
    rawVoices.sort((a, b) => a.toString().toLowerCase().compareTo(b.toString().toLowerCase()));
    final result = convertedVoices
        .map((voice) => TtsVoice.fromJson(voice))
        .toList()
        .where((voice) => voice.locale == 'en-US' || voice.locale == 'ru-RU')
        .toList();

    return result;
    // convertedVoices.map((voice) => TtsVoice.fromJson(voice)).toList();
  }
}
