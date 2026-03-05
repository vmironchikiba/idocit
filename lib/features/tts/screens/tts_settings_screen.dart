import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/entities/tts_engine.dart';
import 'package:idocit/features/tts/domain/entities/tts_voice.dart';
import 'package:idocit/features/tts/domain/enums/tts_state_enum.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/injection_container.dart';

// import 'language_helper.dart'; // Import the facade

class TtsSettingsScreen extends StatefulWidget {
  static const routeName = '/tts-settings';
  const TtsSettingsScreen({super.key});

  @override
  TtsSettingsScreenState createState() => TtsSettingsScreenState();
}

//enum TtsState { playing, stopped, paused, continued }

class TtsSettingsScreenState extends State<TtsSettingsScreen> {
  // late FlutterTts flutterTts;
  List<String?> rawEngines = [];
  List<DropdownMenuItem<String?>> engineItems = [];
  String? engine;
  TtsEngine? engineTts;
  List<Map<String, String>?> rawVoices = [];
  List<DropdownMenuItem<Map<String, String>?>> voiceItems = [];
  Completer<void> _voiceDataReadyCompleter = Completer<void>();
  Map<String, String>? voice;
  TtsVoice? voiceTts;
  bool getDefaultVoiceRetried = false;
  List<String?> rawLanguages = [];
  List<DropdownMenuItem<String?>> languageItems = [];
  String? language;
  bool isCurrentLanguageInstalled = false;

  int? _inputLength;

  bool get isPlaying => locator<TtsBloc>().state.ttsState == TtsStateEnum.playing;
  bool get isStopped => locator<TtsBloc>().state.ttsState == TtsStateEnum.stopped;
  bool get isPaused => locator<TtsBloc>().state.ttsState == TtsStateEnum.paused;
  bool get isContinued => locator<TtsBloc>().state.ttsState == TtsStateEnum.continued;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isMacOS => !kIsWeb && Platform.isMacOS;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getDefaults(); // invoked after initial build of context is complete
    });
  }

  Future<void> _getDefaults() async {
    if (kDebugMode) debugPrint('_getDefaults...');
    if (isAndroid) await _getDefaultEngineTts();
    if (kIsWeb) setState(() {}); // Tickle the UI
    await _getDefaultVoice();
  }

  Future<void> _getDefaultEngine() async {
    if (!isAndroid) return; // safety-check
    if (kDebugMode) debugPrint('_getDefaultEngine...');
    var e = await locator<TtsService>().getDefaultEngine();
    if (e != null) {
      if (kDebugMode) debugPrint('Default Engine: $e');
      setState(() => engine = e as String);
    }
  }

  Future<void> _getDefaultEngineTts() async {
    if (!isAndroid) return; // safety-check
    if (kDebugMode) debugPrint('_getDefaultEngine...');
    var e = await locator<TtsService>().getDefaultEngine();
    if (e != null) {
      if (kDebugMode) debugPrint('Default Engine: ${e.name}');
      setState(() => engineTts = e);
    }
  }

  Future<void> _getDefaultVoice() async {
    if (kDebugMode) debugPrint('_getDefaultVoice..');
    try {
      await _voiceDataReadyCompleter.future.timeout(const Duration(seconds: 2));
    } on TimeoutException {
      if (kDebugMode) debugPrint("Timeout waiting for voice data");
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
    if (kDebugMode) {
      debugPrint('_voiceDataReadyCompleter.isCompleted, so continuing..');
    }
    if (kDebugMode) debugPrint("rawVoices count: ${rawVoices.length}");
    if (rawVoices.isEmpty) return;

    if (isAndroid) {
      var defVoice = await locator<TtsService>().getDefaultVoiceTts();
      if (kDebugMode) debugPrint('Android Default Voice: ${defVoice}');
      if (defVoice != null) {
        var rawVoice = rawVoices.firstWhere((v) => mapEquals(v, defVoice));
        voice = rawVoice;
        if (voice != null) changedVoicesDropDownItem(voice);
      }
    } else {
      String myLocale;
      // Web may return just the language code, e.g. "de", if the browser's
      // Settings/Language contains preferred language entries containing only
      // the language without a region (e.g. "German" and not "German (Germany)").
      Locale deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      if (kDebugMode) debugPrint('Device Locale (ISO): $deviceLocale');
      // TTS uses Unicode BCP47 Locale Identifiers instead of the ISO standard
      myLocale = deviceLocale.toLanguageTag();
      if (kDebugMode) debugPrint('Device/Browser Locale (BCP47): $myLocale');
      // TTS auto-selects the first matching raw voice with locale
      var rawVoice = rawVoices.firstWhere(
        (v) => v?['locale'] == myLocale,
        orElse: () => rawVoices.firstWhere((v) => v?['locale']?.startsWith(myLocale) ?? false, orElse: () => null),
      );
      voice = rawVoice;
      if (kDebugMode) debugPrint('Computed Default Voice: $voice');
      if (voice != null) changedVoicesDropDownItem(voice);
    }
  }

  Future<void> _speak() async {
    await locator<TtsService>().setVolume(locator<TtsBloc>().state.volume);
    await locator<TtsService>().setSpeechRate(locator<TtsBloc>().state.rate);
    await locator<TtsService>().setPitch(locator<TtsBloc>().state.pitch);

    if (locator<TtsBloc>().state.voiceText != null) {
      if (locator<TtsBloc>().state.voiceText!.isNotEmpty) {
        await locator<TtsService>().speak(locator<TtsBloc>().state.voiceText!);
      }
    }
  }

  Future<void> _stop() async {
    var result = await locator<TtsService>().stop();
    if (result == 1) setState(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.stopped)));
  }

  Future<void> _pause() async {
    var result = await locator<TtsService>().pause();
    if (result == 1) setState(() => locator<TtsBloc>().add(UpdateTtsState(ttsState: TtsStateEnum.paused)));
  }

  @override
  void dispose() {
    super.dispose();
    locator<TtsService>().stop();
  }

  List<DropdownMenuItem<String?>> getEnginesDropDownMenuItems(List<dynamic> engines) {
    if (kDebugMode) debugPrint('getEnginesDropDownMenuItems...');
    if (engineItems.isEmpty) {
      rawEngines.clear();
      for (dynamic item in engines) {
        // if (kDebugMode) debugPrint('Engine: $item');
        rawEngines.add(item);
        engineItems.add(DropdownMenuItem<String?>(value: item, child: Text(item)));
      }
    }
    return engineItems;
  }

  Future<void> changedEnginesDropDownItem(String? selectedEngine) async {
    if (selectedEngine == null || selectedEngine.trim().isEmpty) {
      return;
    }
    if (kDebugMode) debugPrint('changedEnginesDropDownItem...');
    await locator<TtsService>().setEngine(selectedEngine);
    engine = selectedEngine;
    voiceItems.clear();
    voice = null;
    languageItems.clear();
    language = null;
    isCurrentLanguageInstalled = false;
    _voiceDataReadyCompleter = Completer<void>(); // re-use
    setState(() {});
    getDefaultVoiceRetried = false;
    await _getDefaultVoice();
  }

  List<DropdownMenuItem<TtsVoice>> getVoicesDropDownMenuItemsTts(List<TtsVoice> voices) {
    final menuItems = voices
        .map((voice) => DropdownMenuItem<TtsVoice>(value: voice, child: Text("${voice.name} (${voice.locale})")))
        .toList();
    return menuItems;
  }

  Future<void> changedVoicesDropDownItem(Map<String, String>? selectedVoice) async {
    if (selectedVoice == null || selectedVoice.isEmpty) {
      return;
    }
    if (kDebugMode) debugPrint('changedVoicesDropDownItem...');
    await locator<TtsService>().setVoice(selectedVoice);
    voice = selectedVoice;
    language = selectedVoice['locale'];
    setState(() {});
  }

  Future<void> changedVoicesDropDownItemTts(TtsVoice? selectedVoice) async {
    setState(() async {
      if (selectedVoice != null) await locator<TtsService>().setVoiceTts(selectedVoice);
    });
  }

  List<DropdownMenuItem<String?>> getLanguagesDropDownMenuItems(List<dynamic> languages) {
    if (kDebugMode) debugPrint('getLanguagesDropDownMenuItems...');
    if (languageItems.isEmpty) {
      rawLanguages.clear();
      for (dynamic item in languages) {
        // if (kDebugMode) debugPrint('Language: $item');
        rawLanguages.add(item); // remains unsorted
        var menuItem = DropdownMenuItem<String?>(value: item, child: Text(item));
        if (!languageItems.any((element) => element.value == menuItem.value)) {
          languageItems.add(menuItem);
        }
      }
      languageItems.sort((a, b) {
        return a.child.toString().toLowerCase().compareTo(b.child.toString().toLowerCase());
      });
    }
    return languageItems;
  }

  Future<void> changedLanguagesDropDownItem(String? selectedLanguage) async {
    if (selectedLanguage == null || selectedLanguage.trim().isEmpty) {
      return;
    }
    if (kDebugMode) debugPrint('changedLanguagesDropDownItem...');
    await locator<TtsService>().setLanguage(selectedLanguage);
    language = selectedLanguage;
    if (isAndroid) {
      locator<TtsService>()
          .isLanguageInstalled(language!)
          .then((value) => isCurrentLanguageInstalled = (value as bool));
    } else {
      isCurrentLanguageInstalled = false;
    }

    // if the locale is changed, TTS auto-selects the first matching voice
    if (voiceItems.isNotEmpty) {
      var voiceItem = voiceItems.firstWhere((v) => v.value?['locale'] == selectedLanguage);
      voice = voiceItem.value;
      if (voice != null) changedVoicesDropDownItem(voice);
    }
  }

  void _onChange(String text) {
    locator<TtsBloc>().add(UpdateTtsVoiceText(voiceText: text));
    setState(() {});
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
    await locator<TtsService>().synthesizeToFile(text, fileName);
    if (kDebugMode) debugPrint('synthesized to: $fileName');
  }

  @override
  Widget build(BuildContext context) {
    // locator<TtsService>().getVoices().then((voices) {
    //   LoggerService.logDebug(voices.length.toString());
    // });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('TTS Settings')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              _inputSection(),
              _btnSection(),
              _engineSection(), // _getEngines
              _voiceSection(), // _getVoices
              _languageSection(), // _getLanguages
              _buildSliders(),
              if (isAndroid) _getMaxSpeechInputLengthSection(),
            ],
          ),
        ),
        floatingActionButton:
            (isAndroid || isIOS) &&
                locator<TtsBloc>().state.voiceText != null &&
                locator<TtsBloc>().state.voiceText!.trim().isNotEmpty
            ? FloatingActionButton(
                mini: true,
                onPressed: () => saveToFile(locator<TtsBloc>().state.voiceText),
                tooltip: 'Synthesize to File',
                child: const Icon(Icons.save),
              )
            : null,
      ),
    );
  }

  Widget _engineSection() {
    if (isAndroid) {
      if (engineItems.isNotEmpty) {
        return _enginesDropDownSection(<dynamic>[]);
      } else {
        return FutureBuilder<dynamic>(
          future: locator<TtsService>().getEnginesTts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return _enginesDropDownSection(snapshot.data as List<dynamic>);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('No data to load engines');
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading engines...');
            } else {
              // Other states (e.g., ConnectionState.none,
              // or if future is null initially)
              return const Text('Waiting to start loading engines...');
            }
          },
        );
      }
    } else {
      return const SizedBox(width: 0, height: 0);
    }
  }

  Widget _voiceSection() {
    if (voiceItems.isNotEmpty) {
      if (!_voiceDataReadyCompleter.isCompleted) {
        _voiceDataReadyCompleter.complete(); // Safety complete
      }
      return _voicesDropDownSectionTts(<TtsVoice>[]);
    } else {
      return FutureBuilder<List<TtsVoice>>(
        future: locator<TtsService>().getVoices(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _voicesDropDownSectionTts(snapshot.data);
            } else if (snapshot.hasError) {
              if (!_voiceDataReadyCompleter.isCompleted) {
                _voiceDataReadyCompleter.completeError(snapshot.error ?? "Unknown error loading voices");
              }
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No data to load voices');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading voices...');
          } else {
            // Other states (e.g., ConnectionState.none,
            // or if future is null initially)
            return const Text('Waiting to start loading voices...');
          }
        },
      );
    }
  }

  Widget _languageSection() {
    if (languageItems.isNotEmpty) {
      return _languageDropDownSection(<dynamic>[]);
    } else {
      return FutureBuilder<dynamic>(
        future: locator<TtsService>().getLanguagesTts(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return _languageDropDownSection(snapshot.data as List<dynamic>);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No data to load languages');
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading Languages...');
          } else {
            // Other states (e.g., ConnectionState.none,
            // or if future is null initially)
            return const Text('Waiting to start loading languages...');
          }
        },
      );
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

  Widget _enginesDropDownSection(List<dynamic> engines) {
    return Container(
      padding: const EdgeInsets.only(top: 50.0),
      child: DropdownButton<String?>(
        value: engine,
        hint: const IdocItText(
          text: 'Choose an engine',
          style: TextStyle(color: ColorConstants.white500, fontSize: 16),
        ),
        items: getEnginesDropDownMenuItems(engines),
        onChanged: changedEnginesDropDownItem,
      ),
    );
  }

  Widget _voicesDropDownSectionTts(List<TtsVoice>? voices) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: DropdownButton<TtsVoice>(
        value: voiceTts,
        hint: const IdocItText(
          text: 'Choose a voice',
          style: TextStyle(color: ColorConstants.white500, fontSize: 16),
        ),
        items: getVoicesDropDownMenuItemsTts(voices ?? []),
        onChanged: changedVoicesDropDownItemTts,
      ),
    );
  }

  Widget _languageDropDownSection(List<dynamic> languages) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String?>(
            value: language,
            hint: const IdocItText(
              text: 'Choose a language',
              style: TextStyle(color: ColorConstants.white500, fontSize: 16),
            ), //    Text('Choose a language'),
            items: getLanguagesDropDownMenuItems(languages),
            onChanged: changedLanguagesDropDownItem,
          ),
          const SizedBox(width: 5.0),
          Visibility(visible: isAndroid, child: Text("Is installed: $isCurrentLanguageInstalled")),
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon, String label, Function func) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon: Icon(icon), color: color, splashColor: splashColor, onPressed: () => func()),
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

  Widget _getMaxSpeechInputLengthSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ElevatedButton(
            child: const Text('Get max speech input length'),
            onPressed: () async {
              _inputLength = await locator<TtsService>().getMaxSpeechInputLengthTts();
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 10),
        Flexible(child: _inputLength == null ? Text("") : Text("$_inputLength characters")),
      ],
    );
  }

  Widget _buildSliders() {
    return Column(children: [_volume(), _pitch(), _rate()]);
  }

  Widget _volume() {
    return BlocBuilder<TtsBloc, TtsState>(
      buildWhen: (previous, current) => previous.volume != current.volume,
      builder: (context, state) {
        return ListTile(
          leading: Text(state.volume.toString(), style: TextStyle(color: ColorConstants.white500, fontSize: 16.0)),
          title: Center(
            child: Text('Volume', style: TextStyle(color: ColorConstants.white500, fontSize: 16.0)),
          ),
          subtitle: Slider(
            value: state.volume,
            onChanged: (newVolume) {
              setState(() => locator<TtsBloc>().add(UpdateTtsVolume(volume: newVolume))); // volume = newVolume);
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: "Volume: ${state.volume}",
          ),
        );
      },
    );
  }

  Widget _pitch() {
    return BlocBuilder<TtsBloc, TtsState>(
      buildWhen: (previous, current) => previous.pitch != current.pitch,
      builder: (context, state) {
        return ListTile(
          leading: Text(state.pitch.toString(), style: TextStyle(color: ColorConstants.white500, fontSize: 16.0)),
          title: Center(
            child: Text('Pitch', style: TextStyle(color: ColorConstants.white500, fontSize: 16.0)),
          ),
          subtitle: Slider(
            value: state.pitch,
            onChanged: (newPitch) {
              setState(() => locator<TtsBloc>().add(UpdateTtsPitch(pitch: newPitch)));
            },
            min: 0.5,
            max: 2.0,
            divisions: 15,
            label: "Pitch: ${state.pitch}",
            activeColor: Colors.red,
          ),
        );
      },
    );
  }

  Widget _rate() {
    return BlocBuilder<TtsBloc, TtsState>(
      buildWhen: (previous, current) => previous.rate != current.rate,
      builder: (context, state) {
        return ListTile(
          leading: Text(state.rate.toString(), style: TextStyle(color: ColorConstants.white500, fontSize: 16.0)),
          title: Center(
            child: Text('Rate', style: TextStyle(color: ColorConstants.white500, fontSize: 16.0)),
          ),
          subtitle: Slider(
            value: state.rate,
            onChanged: (newRate) {
              setState(() => locator<TtsBloc>().add(UpdateTtsRate(rate: newRate)));
            },
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: "Rate: ${state.rate}",
            activeColor: Colors.green,
          ),
        );
      },
    );
  }
}
