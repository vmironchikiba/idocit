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
  List<String?> rawEngines = [];
  List<TtsEngine?> rawEnginesTts = [];

  String? engine;
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
  String? _newVoiceText;
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
  Future<dynamic> setEngine(String engine) => tts.setEngine(engine);
  Future<dynamic> setEngineTts(TtsEngine engine) => setEngine(engine.name);
  Future<dynamic> setVoice(Map<String, String> voice) => tts.setVoice(voice);
  Future<dynamic> setVoiceTts(TtsVoice voice) => tts.setVoice(voice.toJson());
  Future<dynamic> setLanguage(String language) => tts.setLanguage(language);
  Future<dynamic> setLanguageTts(TtsLanguage language) => tts.setLanguage(language.code);
  Future<dynamic> isLanguageInstalled(String language) => tts.isLanguageInstalled(language);
  Future<dynamic> isLanguageInstalledTts(TtsLanguage language) => tts.isLanguageInstalled(language.code);
  Future<dynamic> synthesizeToFile(String text, String fileName, [bool isFullPath = false]) =>
      tts.synthesizeToFile(text, fileName, isFullPath);

  List<TtsEngine> getEnginesDropDownMenuItemsTts(List<dynamic> engines) {
    if (kDebugMode) debugPrint('getEnginesDropDownMenuItems...');

    if (enginesTts.isEmpty) {
      rawEngines.clear();
      enginesTts = engines.map((e) => TtsEngine(e as String)).toList();
    }
    return enginesTts;
  }

  List<dynamic> getEnginesDropDownMenuItems(List<dynamic> engines) {
    if (kDebugMode) debugPrint('getEnginesDropDownMenuItems...');
    if (engines.isEmpty) {
      rawEngines.clear();
      for (dynamic item in engines) {
        // if (kDebugMode) debugPrint('Engine: $item');
        rawEngines.add(item);
        engines.add(item);
      }
    }
    return engines;
  }

  Future<TtsVoice?> getDefaultVoice() async {
    try {
      await _voiceDataReadyCompleter.future.timeout(const Duration(seconds: 2));
    } on TimeoutException {
      LoggerService.logDebug("Timeout waiting for voice data");
      if (!getDefaultVoiceRetried) {
        getDefaultVoiceRetried = true; // run only once
        _voiceDataReadyCompleter = Completer<void>(); // re-use
        // setState(() {}); // Tickle the UI
        getDefaultVoice();
      }
      return null;
    } catch (e) {
      LoggerService.logDebug("Error waiting for voice data: $e");
      return null;
    }
    LoggerService.logDebug('_voiceDataReadyCompleter.isCompleted, so continuing..');
    LoggerService.logDebug("rawVoices count: ${rawVoices.length}");

    if (rawVoices.isEmpty) return null;
    if (rawVoicesTts.isEmpty) return null;
    if (isAndroid) {
      var defVoice = await getDefaultVoiceTts();
      var defVoiceTts = defVoice == null ? null : TtsVoice.fromJson(defVoice);

      LoggerService.logDebug('Android Default Voice: $defVoice');
      LoggerService.logDebug('Android Default Voice: $defVoiceTts');
      // if (defVoice != null) {
      if (defVoice != null && defVoiceTts != null) {
        var rawVoice = rawVoices.firstWhere((v) => mapEquals(v, defVoice));
        var rawVoiceTts = rawVoicesTts.firstWhere((v) => v == defVoiceTts);

        //firstWhere((v) => mapEquals(v, defVoice));
        voice = rawVoice;
        voiceTts = rawVoiceTts;
        if (voice != null) changedVoicesDropDownItem(voice);
        if (voiceTts != null) changedVoicesDropDownItemTts(voiceTts);
      }
    } else {
      String myLocale;
      Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      LoggerService.logDebug('Device Locale (ISO): $deviceLocale');
      myLocale = deviceLocale.toLanguageTag();
      LoggerService.logDebug('Device/Browser Locale (BCP47): $myLocale');
      // TTS auto-selects the first matching raw voice with locale
      var rawVoice = rawVoices.firstWhere(
        (v) => v?['locale'] == myLocale,
        orElse: () => rawVoices.firstWhere((v) => v?['locale']?.startsWith(myLocale) ?? false),
      );
      var rawVoiceTts = rawVoicesTts.firstWhere(
        (v) => v?.locale == myLocale,
        orElse: () => rawVoicesTts.firstWhere((v) => v?.locale.startsWith(myLocale) ?? false),
      );
      voice = rawVoice;
      voiceTts = rawVoiceTts;
      LoggerService.logDebug('Computed Default Voice: $voice');
      if (voice != null) changedVoicesDropDownItem(voice);
      if (voiceTts != null) changedVoicesDropDownItemTts(voiceTts);
    }
  }

  Future<void> changedVoicesDropDownItem(Map<String, String>? selectedVoice) async {
    if (selectedVoice == null || selectedVoice.isEmpty) {
      return;
    }
    LoggerService.logDebug('changedVoicesDropDownItem...');
    await setVoice(selectedVoice);
    voice = selectedVoice;
    language = selectedVoice['locale'];
    // setState(() {});
  }

  //  Future<void> changedEnginesDropDownItemTts(TtsEngine? selectedEngine) async {
  //   if (selectedEngine == null || selectedEngine.trim().isEmpty) {
  //     return;
  //   }
  //   if (kDebugMode) debugPrint('changedEnginesDropDownItem...');
  //   await setEngineTts(selectedEngine);
  //   engineTts = selectedEngine;
  //   voicesTts.clear();
  //   voiceTts = null;
  //   languages.clear();
  //   language = null;
  //   isCurrentLanguageInstalled = false;
  //   _voiceDataReadyCompleter = Completer<void>(); // re-use
  //   setState(() {});
  //   getDefaultVoiceRetried = false;
  //   await _getDefaultVoice();
  // }

  Future<void> changedVoicesDropDownItemTts(TtsVoice? selectedVoice) async {
    if (selectedVoice == null || selectedVoice.name.isEmpty) {
      return;
    }
    LoggerService.logDebug('changedVoicesDropDownItem...');
    await setVoiceTts(selectedVoice);
    voiceTts = selectedVoice;
    languageTts = TtsLanguage(selectedVoice.locale);
    // setState(() {});
  }

  Future<void> changedLanguagesDropDownItem(String? selectedLanguage) async {
    if (selectedLanguage == null || selectedLanguage.trim().isEmpty) {
      return;
    }
    if (kDebugMode) debugPrint('changedLanguagesDropDownItem...');
    await setLanguage(selectedLanguage);
    language = selectedLanguage;
    if (isAndroid) {
      isLanguageInstalled(language!).then((value) => isCurrentLanguageInstalled = (value as bool));
    } else {
      isCurrentLanguageInstalled = false;
    }

    // if the locale is changed, TTS auto-selects the first matching voice
    if (voices.isNotEmpty) {
      var voice = voices.firstWhere((v) => v['locale'] == selectedLanguage, orElse: () => {});
      // var voiceItem = voiceItems.firstWhere((v) => v.value?['locale'] == selectedLanguage);
      this.voice = voice;
      if (voice.isNotEmpty) changedVoicesDropDownItem(voice);
    }
  }

  Future<void> changedLanguagesDropDownItemTts(TtsLanguage? selectedLanguage) async {
    if (selectedLanguage == null || selectedLanguage.code.isEmpty) {
      return;
    }
    if (kDebugMode) debugPrint('changedLanguagesDropDownItem...');
    await setLanguageTts(selectedLanguage);
    languageTts = selectedLanguage;
    if (isAndroid) {
      isLanguageInstalledTts(languageTts!).then((value) => isCurrentLanguageInstalled = (value as bool));
    } else {
      isCurrentLanguageInstalled = false;
    }

    // if the locale is changed, TTS auto-selects the first matching voice
    if (voicesTts.isNotEmpty) {
      var voiceTts = voicesTts.firstWhere((v) => v.locale == selectedLanguage.code, orElse: () => TtsVoice.nullVoice);
      // var voiceItem = voiceItems.firstWhere((v) => v.value?['locale'] == selectedLanguage);
      this.voiceTts = voiceTts;
      if (voiceTts != TtsVoice.nullVoice) changedVoicesDropDownItemTts(voiceTts);
    }
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
  }

  Future<void> getDefaultEngine() async {
    if (!isAndroid) return; // safety-check
    LoggerService.logDebug('_getDefaultEngine...');
    var e = await getDefaultEngineTts();
    if (e != null) {
      engine = e as String;
      LoggerService.logDebug('Default Engine: $e');
    }
  }

  Future<TtsEngine?> getDefaultEngineTts_() async {
    if (!isAndroid) return null;
    final e = await getDefaultEngineTts();
    final engine = e as String?;
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
