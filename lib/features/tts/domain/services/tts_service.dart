import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/entities/tts_language.dart';
import 'package:idocit/features/tts/domain/entities/tts_voice.dart';
import 'package:idocit/features/tts/domain/enums/tts_state_enum.dart';
import 'package:idocit/injection_container.dart';

class TtsService {
  final DeviceService deviceService;
  // late FlutterTts flutterTts;
  // TtsStateEnum ttsState = TtsStateEnum.stopped;
  List<String?> rawEngines = [];
  List<TtsEngine?> rawEnginesTts = [];

  TtsEngine? engineTts;
  List<Map<String, String>?> rawVoices = [];
  List<TtsVoice?> rawVoicesTts = [];
  // List<DropdownMenuItem<Map<String, String>?>> voiceItems = [];
  Completer<void> _voiceDataReadyCompleter = Completer<void>();
  Completer<void> get voiceDataReadyCompleter => _voiceDataReadyCompleter;
  bool get voiceIsComplete => _voiceDataReadyCompleter.isCompleted;
  void setVoiceComplete() => _voiceDataReadyCompleter.complete();

  Map<String, String>? voice;
  TtsVoice? voiceTts;
  bool getDefaultVoiceRetried = false;
  List<String?> rawLanguages = [];
  String? language;
  TtsLanguage? languageTts;
  double volume = 0.8;
  double pitch = 1.0;
  double rate = !kIsWeb ? 0.5 : 0.9;
  bool isCurrentLanguageInstalled = false;
  List<String> engines = [];
  List<TtsEngine> enginesTts = [];
  List<String> languages = [];
  List<Map<String, String>> voices = [];
  List<TtsVoice> voicesTts = [];

  final _tts = FlutterTts();
  FlutterTts get tts => _tts;

  bool get isPlaying => locator<TtsBloc>().state.ttsState == TtsStateEnum.playing;
  bool get isStopped => locator<TtsBloc>().state.ttsState == TtsStateEnum.stopped;
  bool get isPaused => locator<TtsBloc>().state.ttsState == TtsStateEnum.paused;
  bool get isContinued => locator<TtsBloc>().state.ttsState == TtsStateEnum.continued;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  TtsService({required this.deviceService});

  Future<void> init() async {
    final _ = await tts.awaitSpeakCompletion(true);
    if (isAndroid) final _ = await tts.setQueueMode(1);
    tts.setStartHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.playing)));
    tts.setCompletionHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped)));
    tts.setCancelHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped)));
    tts.setPauseHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.paused)));
    tts.setContinueHandler(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.continued)));
    tts.setErrorHandler((msg) {
      LoggerService.logDebug(msg);
      locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped));
    });
  }

  Future<dynamic> get _getEnginesTts => tts.getEngines;
  Future<dynamic> get _getVoicesTts => tts.getVoices;
  Future<dynamic> get _getLanguagesTts => tts.getLanguages;
  Future<dynamic> get getDefaultEngineTts => tts.getDefaultEngine;

  Future<TtsEngine> getDefaultEngine() async => TtsEngine(await getDefaultEngineTts as String);

  Future<dynamic> getDefaultVoiceTts() async => await tts.getDefaultVoice;
  Future<dynamic> getMaxSpeechInputLengthTts() async => tts.getMaxSpeechInputLength;

  Future<dynamic> setVolume(double volume) async => await tts.setVolume(volume);
  Future<dynamic> setSpeechRate(double rate) async => await tts.setSpeechRate(rate);
  Future<dynamic> setPitch(double pitch) async => await tts.setPitch(pitch);

  Future<dynamic> speak(String text, {bool focus = false}) => tts.speak(text, focus: focus);
  Future<dynamic> awaitSpeakCompletion(bool awaitCompletion) => tts.awaitSpeakCompletion(awaitCompletion);
  Future<dynamic> setQueueMode(int queueMode) => tts.setQueueMode(queueMode);
  Future<dynamic> stop() => tts.stop();
  Future<dynamic> pause() => tts.pause();
  Future<dynamic> setEngine(String engine) => tts.setEngine(engine);
  Future<dynamic> setEngineTts(TtsEngine engine) => setEngine(engine.name);
  Future<dynamic> setVoice(Map<String, String> voice) => tts.setVoice(voice);
  Future<dynamic> setVoiceTts(TtsVoice voice) => tts.setVoice(voice.toJson());
  Future<dynamic> setLanguage(String language) => tts.setLanguage(language);
  Future<dynamic> setLanguageTts(TtsLanguage language) => tts.setLanguage(language.code);
  Future<dynamic> isLanguageInstalledTts(String language) => tts.isLanguageInstalled(language);
  Future<bool> isLanguageInstalled(TtsLanguage language) async => await isLanguageInstalledTts(language.code) as bool;

  Future<dynamic> synthesizeToFile(String text, String fileName, [bool isFullPath = false]) =>
      tts.synthesizeToFile(text, fileName, isFullPath);

  Future<List<TtsLanguage>> getLanguages() async {
    final raw = await _getLanguagesTts as List;
    return raw.whereType<String>().map((e) => TtsLanguage(e)).toList();
  }

  Future<List<TtsVoice>> getVoices() async {
    final raw = await _getVoicesTts as List;
    return raw.whereType<Map>().map((voice) => TtsVoice.fromJson(voice)).toList();
  }

  Future<List<TtsEngine>> getEngines() async {
    final raw = await _getEnginesTts as List;
    return raw.whereType<String>().map((e) => TtsEngine(e)).toList();
  }
}
