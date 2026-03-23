import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/enums/stt_actions.dart';
import 'package:idocit/features/stt/domain/models/speech_to_text_config.dart';
import 'package:idocit/features/stt/domain/usecases/stt_lazy_init.dart';
import 'package:idocit/features/stt/domain/usecases/stt_start_stop.dart';
import 'package:idocit/features/stt/widgets/help_widget.dart';
import 'package:idocit/features/stt/widgets/init_speech_widget.dart';
import 'package:idocit/features/stt/widgets/recognition_results_widget.dart';
import 'package:idocit/features/stt/widgets/speech_control_widget.dart';
import 'package:idocit/features/stt/widgets/speech_error_widget.dart';
import 'package:idocit/features/stt/widgets/session_options_widget.dart';
import 'package:idocit/features/stt/widgets/speech_status_widget.dart';
import 'package:idocit/injection_container.dart';

class SttSettingsScreen extends StatefulWidget {
  const SttSettingsScreen({super.key});

  @override
  State<SttSettingsScreen> createState() => _SttSettingsScreenState();
}

/// The basic functionality of the
/// SpeechToText plugin for using the speech recognition capability
/// of the underlying platform.
class _SttSettingsScreenState extends State<SttSettingsScreen> {
  @override
  void initState() {
    locator<SttLazyInit>().call(SpeechToTextConfig.startOptions).then((result) {
      setState(() {
        result.fold((failure) {
          LoggerService.logDebug(failure.message);
        }, (_) {});
      });
    });
    super.initState();
  }

  /// This initializes SpeechToText. That only has to be done
  /// once per application, though calling it again is harmless
  /// it also does nothing. The UX of the sample app ensures that
  /// it can only be called once.
  Future<void> initSpeechState() async {
    locator<SttLazyInit>().call(SpeechToTextConfig.startOptions).then((result) {
      setState(() {
        result.fold((failure) {}, (_) {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Speech to Text Example')),
        body: Builder(
          builder: (ctx) => SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<SttBloc, SttState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Expanded(child: InitSpeechWidget(initSpeechState)),
                        TextButton.icon(
                          // key: ,
                          onPressed: () async {
                            final currentOptions = state.currentOptions;
                            if (currentOptions != null) {
                              final options = await showSetUp(ctx, currentOptions);
                              locator<SttBloc>().add(UpdateSttCurrentOptions(currentOptions: options));
                            }
                          },
                          icon: const Icon(Icons.settings),
                          label: const Text('Session Options'),
                        ),
                      ],
                    );
                  },
                ),
                SpeechControlWidget(startListening, stopListening, cancelListening),
                RecognitionResultsWidget(),
                SpeechStatusWidget(),
                SpeechErrorWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // This is called each time the users wants to start a new speech
  // recognition session
  void startListening() {
    locator<SttStartStop>().call(SttActions.start).then((result) {
      setState(() {
        result.fold((failure) {
          LoggerService.logDebug(failure.message);
        }, (_) => null);
      });
    });
  }

  void stopListening() {
    locator<SttStartStop>().call(SttActions.stop).then((result) {
      setState(() {
        result.fold((failure) {
          LoggerService.logDebug(failure.message);
        }, (_) => null);
      });
    });
  }

  void cancelListening() {
    locator<SttStartStop>().call(SttActions.cancel).then((result) {
      setState(() {
        result.fold((failure) {
          LoggerService.logDebug(failure.message);
        }, (_) => null);
      });
    });
  }
}

Future<SpeechToTextConfig> showSetUp(BuildContext context, SpeechToTextConfig currentOptions) async {
  var updatedOptions = currentOptions;
  var listenController = TextEditingController()..text = updatedOptions.listenFor.toString();
  var pauseController = TextEditingController()..text = updatedOptions.pauseFor.toString();
  var showHelp = false;
  await showModalBottomSheet(
    elevation: 0,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Material(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).copyWith().size.height * 0.75,
            minHeight: MediaQuery.of(context).copyWith().size.height * 0.5,
            maxWidth: double.infinity,
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Session Options", style: Theme.of(context).textTheme.titleMedium),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                        child: showHelp
                            ? const HelpWidget()
                            : SessionOptionsWidget(
                                onChange: (newOptions) {
                                  setState(() {
                                    updatedOptions = newOptions;
                                  });
                                },
                                listenForController: listenController,
                                pauseForController: pauseController,
                                options: updatedOptions,
                              ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0.0,
                  top: 0.0,
                  child: IconButton(
                    onPressed: () => setState(() => showHelp = !showHelp),
                    icon: Icon(showHelp ? Icons.settings : Icons.question_mark),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  updatedOptions = updatedOptions.copyWith(
    listenFor: int.tryParse(listenController.text) ?? updatedOptions.listenFor,
    pauseFor: int.tryParse(pauseController.text) ?? updatedOptions.pauseFor,
  );
  return updatedOptions;
}
