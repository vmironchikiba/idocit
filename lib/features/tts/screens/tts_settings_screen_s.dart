import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/entities/tts_language.dart';
import 'package:idocit/features/tts/domain/entities/tts_voice.dart';
import 'package:idocit/features/tts/domain/enums/tts_state_enum.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_enabled.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_enabled.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_engine.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_language.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_voice.dart';
import 'package:idocit/injection_container.dart';

// import 'language_helper.dart'; // Import the facade

class TtsSettingsScreen extends StatefulWidget {
  static const routeName = '/tts-settings';
  const TtsSettingsScreen({super.key});

  @override
  TtsSettingsScreenState createState() => TtsSettingsScreenState();
}

// enum TtsState { playing, stopped, paused, continued }

class TtsSettingsScreenState extends State<TtsSettingsScreen> {
  final ttsService = locator<TtsService>();
  List<String?> rawEngines = [];
  List<TtsEngine?> rawEnginesTts = [];
  List<DropdownMenuItem<String?>> engineItems = [];
  List<DropdownMenuItem<TtsEngine?>> engineItemsTts = [];
  String? engine;
  List<Map<String, String>?> rawVoices = [];
  List<TtsVoice> rawVoicesTts = [];
  List<DropdownMenuItem<Map<String, String>?>> voiceItems = [];
  List<DropdownMenuItem<TtsVoice?>> voiceItemsTts = [];
  Completer<void> _voiceDataReadyCompleter = Completer<void>();
  bool getDefaultVoiceRetried = false;
  List<String?> rawLanguages = [];
  List<DropdownMenuItem<String?>> languageItems = [];
  List<DropdownMenuItem<TtsLanguage?>> languageItemsTts = [];
  double volume = 0.8;
  double pitch = 1.0;
  double rate = !kIsWeb ? 0.5 : 0.9;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isIOS => !kIsWeb && Platform.isIOS;

  @override
  initState() {
    super.initState();
    init();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDefaults(); // invoked after initial build of context is complete
    });
  }

  // from initState()
  void init() {
    locator<TtsService>().init().then((_) async {
      await ttsService.getLanguagesTts();
      await ttsService.getVoicesTts();
      await ttsService.getEnginesTts();
    });
    locator<TtsGetEnabled>().call(NoParams());
    ttsService.getMaxSpeechInputLengthTts().then((onValue) => _inputLength = onValue);
  }

  Future<void> _getDefaults() async {
    if (kDebugMode) debugPrint('_getDefaults...');
    if (isAndroid) await _getDefaultEngine();
    if (kIsWeb) setState(() {}); // Tickle the UI
    await _getDefaultVoice();
  }

  Future<void> _getDefaultEngine() async {
    if (!isAndroid) return; // safety-check
    LoggerService.logDebug('_getDefaultEngine...');
    var e = await ttsService.getDefaultEngineTts();
    if (e != null) {
      LoggerService.logDebug('Default Engine: $e');
      locator<TtsSetEngine>().call(TtsEngine(e as String));
    }
  }

  Future<void> _getDefaultVoice() async {
    LoggerService.logDebug('_getDefaultVoice..');
    try {
      await _voiceDataReadyCompleter.future.timeout(const Duration(seconds: 2));
    } on TimeoutException {
      LoggerService.logDebug("Timeout waiting for voice data");
      if (!getDefaultVoiceRetried) {
        getDefaultVoiceRetried = true; // run only once
        _voiceDataReadyCompleter = Completer<void>(); // re-use
        setState(() {}); // Tickle the UI
        _getDefaultVoice();
      }
      return;
    } catch (e) {
      if (kDebugMode) debugPrint("Error waiting for voice data: $e");
      return;
    }

    LoggerService.logDebug('_voiceDataReadyCompleter.isCompleted, so continuing..');
    LoggerService.logDebug("rawVoices count: ${rawVoicesTts.length}");
    if (rawVoicesTts.isEmpty) return;

    if (isAndroid) {
      var defVoice = await ttsService.getDefaultVoiceTts();
      LoggerService.logDebug('Android Default Voice: $defVoice');
      if (defVoice != null) {
        var rawVoice = rawVoicesTts.firstWhere(
          (v) => v == defVoice,
          orElse: () => TtsVoice.nullVoice,
        ); //  mapEquals(v, defVoice));
        await locator<TtsSetVoice>().call(rawVoice.optional);
        final voiceTts = locator<TtsBloc>().state.currentVoice;
        if (voiceTts != null) changedVoicesDropDownItem(voiceTts);
      }
    } else {
      String myLocale;
      Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      LoggerService.logDebug('Device Locale (ISO): $deviceLocale');
      // TTS uses Unicode BCP47 Locale Identifiers instead of the ISO standard
      myLocale = deviceLocale.toLanguageTag();
      LoggerService.logDebug('Device/Browser Locale (BCP47): $myLocale');
      // TTS auto-selects the first matching raw voice with locale
      var rawVoiceTts = rawVoicesTts.firstWhere(
        (v) => v.locale == myLocale,
        orElse: () => rawVoicesTts.firstWhere((v) => v.locale.startsWith(myLocale)),
      );
      await locator<TtsSetVoice>().call(rawVoiceTts.optional);
      final voiceTts = locator<TtsBloc>().state.currentVoice;
      LoggerService.logDebug('Computed Default Voice: ${voiceTts?.name}');
      if (voiceTts != null) changedVoicesDropDownItem(voiceTts);
    }
  }

  Future<void> _speak() async {
    await ttsService.setVolume(volume);
    await ttsService.setSpeechRate(rate);
    await ttsService.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText!.isNotEmpty) {
        await ttsService.speak(_newVoiceText!);
      }
    }
  }

  Future<void> _stop() async {
    var result = await ttsService.stop();
    if (result == 1) setState(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped)));
  }

  Future<void> _pause() async {
    var result = await ttsService.pause();
    // if (result == 1) setState(() => ttsState = TtsStateEnum.paused);
    if (result == 1) setState(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.paused)));
  }

  @override
  void dispose() {
    super.dispose();
    ttsService.stop();
  }

  List<DropdownMenuItem<TtsEngine?>> getEnginesDropDownMenuItems(List<TtsEngine> engines) {
    if (kDebugMode) debugPrint('getEnginesDropDownMenuItems...');
    if (engineItemsTts.isEmpty) {
      rawEnginesTts.clear();
      for (TtsEngine item in engines) {
        rawEnginesTts.add(item);
        engineItemsTts.add(DropdownMenuItem<TtsEngine?>(value: item, child: Text(item.name)));
      }
    }
    return engineItemsTts;
  }

  Future<void> changedEnginesDropDownItem(TtsEngine? selectedEngine) async {
    if (selectedEngine == null || selectedEngine.name.trim().isEmpty) {
      return;
    }
    if (kDebugMode) debugPrint('changedEnginesDropDownItem...');
    await ttsService.setEngineTts(selectedEngine);
    locator<TtsBloc>().add(UpdateTtsCurrentEngine(currentEngine: selectedEngine));
    voiceItemsTts.clear();
    locator<TtsSetVoice>().call(null);
    languageItemsTts.clear();
    await locator<TtsSetLanguage>().call(null);
    isCurrentLanguageInstalled = false;
    _voiceDataReadyCompleter = Completer<void>(); // re-use
    setState(() {});
    getDefaultVoiceRetried = false;
    await _getDefaultVoice();
  }

  List<DropdownMenuItem<TtsVoice?>> getVoicesDropDownMenuItems(List<TtsVoice> voices) {
    if (kDebugMode) {
      debugPrint('getVoicesDropDownMenuItems: voices count: ${voices.length}');
    }
    if (kDebugMode) debugPrint("voiceItems.count: ${voiceItems.length}");
    if (voiceItems.isEmpty) {
      rawVoicesTts.clear();
      for (TtsVoice item in voices) {
        rawVoicesTts.add(item); // remains unsorted
        var menuItem = DropdownMenuItem<TtsVoice?>(value: item, child: Text("${item.name} (${item.locale})"));
        if (!voiceItemsTts.any((element) => element.value?.name == menuItem.value?.name)) {
          voiceItemsTts.add(menuItem);
        }
      }
      voiceItemsTts.sort((a, b) {
        return a.child.toString().toLowerCase().compareTo(b.child.toString().toLowerCase());
      });
    }
    if (voiceItemsTts.isNotEmpty && !_voiceDataReadyCompleter.isCompleted) {
      _voiceDataReadyCompleter.complete();
      if (kDebugMode) {
        debugPrint('_voiceDataReadyCompleter completed with ${voiceItems.length} voiceItems');
      }
    }
    return voiceItemsTts;
  }

  Future<void> changedVoicesDropDownItem(TtsVoice? selectedVoice) async {
    if (selectedVoice == null || selectedVoice == TtsVoice.nullVoice) {
      return;
    }
    if (kDebugMode) debugPrint('changedVoicesDropDownItem...');
    await ttsService.setVoiceTts(selectedVoice);
    await locator<TtsSetVoice>().call(selectedVoice);
    await locator<TtsSetLanguage>().call(TtsLanguage(selectedVoice.locale));
    setState(() {});
  }

  List<DropdownMenuItem<TtsLanguage?>> getLanguagesDropDownMenuItems(List<TtsLanguage> languages) {
    if (kDebugMode) debugPrint('getLanguagesDropDownMenuItems...');
    if (languageItemsTts.isEmpty) {
      rawLanguages.clear();
      for (TtsLanguage item in languages) {
        rawLanguages.add(item.code); // remains unsorted
        var menuItem = DropdownMenuItem<TtsLanguage?>(value: item, child: Text(item.code));
        if (!languageItemsTts.any((element) => element.value == menuItem.value)) {
          languageItemsTts.add(menuItem);
        }
      }
      languageItemsTts.sort((a, b) {
        return a.child.toString().toLowerCase().compareTo(b.child.toString().toLowerCase());
      });
    }
    return languageItemsTts;
  }

  Future<void> changedLanguagesDropDownItem(TtsLanguage? selectedLanguage) async {
    if (selectedLanguage == null || selectedLanguage.code.trim().isEmpty) {
      return;
    }
    if (kDebugMode) debugPrint('changedLanguagesDropDownItem...');
    await ttsService.setLanguage(selectedLanguage.code);
    await locator<TtsSetLanguage>().call(selectedLanguage);
    await locator<TtsSetLanguage>().call(selectedLanguage);
    if (isAndroid) {
      ttsService
          .isLanguageInstalled(locator<TtsBloc>().state.currentLanguage?.code ?? '')
          .then((value) => isCurrentLanguageInstalled = (value as bool));
    } else {
      isCurrentLanguageInstalled = false;
    }

    // if the locale is changed, TTS auto-selects the first matching voice
    if (voiceItemsTts.isNotEmpty) {
      var voiceItem = voiceItemsTts.firstWhere((v) => v.value?.locale == selectedLanguage.code);
      locator<TtsSetVoice>().call(voiceItem.value);
      if (voiceItem.value != null) changedVoicesDropDownItem(voiceItem.value);
    }
  }

  void _onChange(String text) {
    locator<TtsBloc>().add(UpdateTtsVoiceText(voiceText: text));
    setState(() {
      _newVoiceText = text;
    });
  }

  Future<void> saveToFile(String? text) async {
    if (text == null || text.trim().isEmpty) return;
    // Mangle text to a filename
    String myText = text.trim();
    myText = myText.replaceAll(RegExp(r'\s+'), '_'); // one or more spaces
    myText = myText.replaceAll(
      RegExp(r'[^\p{L}\p{M}\p{N}_]', unicode: true),
      '',
    ); // \p{L} for letters, \p{M} for combining marks ("diacritics"), \p{N}
    myText = myText.substring(0, min(myText.length, 40));
    if (myText.isEmpty) return;
    String fileName = isAndroid ? '$myText.mp3' : '$myText.caf';
    await ttsService.synthesizeToFile(text, fileName);
    if (kDebugMode) debugPrint('synthesized to: $fileName');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Flutter TTS')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocBuilder<TtsBloc, TtsState>(
            // buildWhen: (previous, current) => previous.isEnabled != current.isEnabled,
            builder: (context, state) {
              return Column(
                children: [
                  SwitchListTile(
                    title: const Text("Enabled", style: TextStyle(color: ColorConstants.white500)),
                    value: state.isEnabled,
                    onChanged: (value) async => await locator<TtsSetEnabled>().call(value),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        axisAlignment: -1.0, // animate from top
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: state.isEnabled
                        ? Column(
                            key: const ValueKey(true),
                            children: [
                              _inputSection(),
                              _btnSection(),
                              _engineSection(state), // _getEngines
                              _voiceSection(state), // _getVoices
                              _languageDropDownSection(state),
                              _buildSliders(),
                              if (isAndroid) Text("Input length $_inputLength characters"),
                            ],
                          )
                        : const SizedBox.shrink(key: ValueKey(false)),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButton: (isAndroid || isIOS) && _newVoiceText != null && _newVoiceText!.trim().isNotEmpty
            ? FloatingActionButton(
                mini: true,
                onPressed: () => saveToFile(_newVoiceText),
                tooltip: 'Synthesize to File',
                child: const Icon(Icons.save),
              )
            : null,
      ),
    );
  }

  Widget _engineSection(TtsState state) =>
      isAndroid ? _enginesDropDownSection(state.engines) : const SizedBox(width: 0, height: 0);

  Widget _voiceSection(TtsState state) {
    if (voiceItemsTts.isNotEmpty) {
      if (!_voiceDataReadyCompleter.isCompleted) {
        _voiceDataReadyCompleter.complete(); // Safety complete
      }
      return _voicesDropDownSection(state);
    } else {
      return _voicesDropDownSection(state);
    }
  }

  Widget _inputSection() => Container(
    alignment: Alignment.topCenter,
    padding: const EdgeInsets.only(top: 25.0, left: 25.0, right: 25.0),
    child: TextField(
      maxLines: 11,
      minLines: 6,
      onChanged: (String value) {
        _onChange(value);
      },
    ),
  );

  Widget _btnSection() {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow, 'PLAY', _speak),
          _buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
          _buildButtonColumn(Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
        ],
      ),
    );
  }

  Widget _enginesDropDownSection(List<TtsEngine> engines) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: DropdownButton<TtsEngine?>(
        value: locator<TtsBloc>().state.currentEngine,
        icon: Icon(Icons.settings, color: ColorConstants.white500),
        hint: const Text('Choose an engine'),
        items: getEnginesDropDownMenuItems(engines),
        onChanged: changedEnginesDropDownItem,
      ),
    );
  }

  Widget _voicesDropDownSection(TtsState state) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: DropdownButton<TtsVoice?>(
        value: state.currentVoice,
        icon: Icon(Icons.record_voice_over, color: ColorConstants.white500),
        hint: const Text('Choose a voice'),
        items: getVoicesDropDownMenuItems(state.voices),
        onChanged: changedVoicesDropDownItem,
      ),
    );
  }

  Widget _languageDropDownSection(TtsState state) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<TtsLanguage?>(
            value: state.currentLanguage, // languageTts,
            icon: Icon(Icons.language, color: ColorConstants.white500),
            hint: const Text('Choose a language', style: TextStyle(color: ColorConstants.red600)),
            items: getLanguagesDropDownMenuItems(state.languages),
            onChanged: changedLanguagesDropDownItem,
          ),
          const SizedBox(width: 5.0),
          Visibility(visible: isAndroid, child: Text("Installed: $isCurrentLanguageInstalled")),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon, String label, Function func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          color: color,
          splashColor: splashColor,
          onPressed: () {
            FocusScope.of(context).unfocus();
            func();
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
          ),
        ),
      ],
    );
  }

  Widget _buildSliders() {
    return Column(children: [_volume(), _pitch(), _rate()]);
  }

  Widget _volume() {
    return Slider(
      value: volume,
      onChanged: (newVolume) {
        locator<TtsBloc>().add(UpdateTtsVolume(volume: newVolume));
        setState(() => volume = newVolume);
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Volume: $volume",
    );
  }

  Widget _pitch() {
    return Slider(
      value: pitch,
      onChanged: (newPitch) {
        locator<TtsBloc>().add(UpdateTtsPitch(pitch: newPitch));
        setState(() => pitch = newPitch);
      },
      min: 0.5,
      max: 2.0,
      divisions: 15,
      label: "Pitch: $pitch",
      activeColor: Colors.red,
    );
  }

  Widget _rate() {
    return Slider(
      value: rate,
      onChanged: (newRate) {
        locator<TtsBloc>().add(UpdateTtsRate(rate: newRate));
        setState(() => rate = newRate);
      },
      min: 0.0,
      max: 1.0,
      divisions: 10,
      label: "Rate: $rate",
      activeColor: Colors.green,
    );
  }
}
