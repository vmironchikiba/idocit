import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/speech_to_text_config.dart';

class SessionOptionsWidget extends StatelessWidget {
  const SessionOptionsWidget({
    required this.options,
    super.key,
    required this.onChange,
    required this.listenForController,
    required this.pauseForController,
  });

  final SpeechToTextConfig options;

  final void Function(SpeechToTextConfig newOptions) onChange;
  final TextEditingController listenForController;
  final TextEditingController pauseForController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SttBloc, SttState>(
      buildWhen: (previous, current) => previous.localeNames.length != current.localeNames.length,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Row(
              children: [
                const Text('localeId: '),
                Expanded(
                  child: DropdownButton<String>(
                    value: state.localeNames.any((l) => l.localeId == options.localeId) ? options.localeId : null,
                    isExpanded: true,
                    onChanged: (selectedVal) => onChange(options.copyWith(localeId: selectedVal ?? options.localeId)),
                    items: state.localeNames
                        .map((localeName) => DropdownMenuItem(value: localeName.localeId, child: Text(localeName.name)))
                        .toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('pauseFor: '),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: 80,
                  child: TextFormField(controller: pauseForController),
                ),
              ],
            ),
            Row(
              children: [
                const Text('listenFor: '),
                Container(
                  padding: const EdgeInsets.only(left: 8),
                  width: 80,
                  child: TextFormField(controller: listenForController),
                ),
              ],
            ),
            Row(
              children: [
                const Text('partialResults: '),
                Checkbox(
                  value: options.options.partialResults,
                  onChanged: (value) {
                    onChange(options.copyWith(options: options.options.copyWith(partialResults: value)));
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('onDevice: '),
                Checkbox(
                  value: options.options.onDevice,
                  onChanged: (value) {
                    onChange(options.copyWith(options: options.options.copyWith(onDevice: value)));
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('cancelOnError: '),
                Checkbox(
                  value: options.options.cancelOnError,
                  onChanged: (value) {
                    onChange(options.copyWith(options: options.options.copyWith(cancelOnError: value)));
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('autoPunctuation: '),
                Checkbox(
                  value: options.options.autoPunctuation,
                  onChanged: (value) {
                    onChange(options.copyWith(options: options.options.copyWith(autoPunctuation: value)));
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('enableHapticFeedback: '),
                Checkbox(
                  value: options.options.enableHapticFeedback,
                  onChanged: (value) {
                    onChange(options.copyWith(options: options.options.copyWith(enableHapticFeedback: value)));
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('debugLogging: '),
                Checkbox(
                  value: options.debugLogging,
                  onChanged: (value) => onChange(options.copyWith(debugLogging: value)),
                ),
              ],
            ),
            Row(
              children: [
                const Text('Log events: '),
                Checkbox(
                  value: options.logEvents,
                  onChanged: (value) => onChange(options.copyWith(logEvents: value)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
