import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';

class InitSpeechWidget extends StatelessWidget {
  const InitSpeechWidget(this.initSpeechState, {super.key});

  // final bool hasSpeech;
  final Future<void> Function() initSpeechState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SttBloc, SttState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            OutlinedButton(onPressed: state.isEnabled ? null : initSpeechState, child: const Text('Initialize')),
          ],
        );
      },
    );
  }
}
