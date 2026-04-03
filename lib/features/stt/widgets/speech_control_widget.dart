import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';

class SpeechControlWidget extends StatelessWidget {
  const SpeechControlWidget(this.startListening, this.stopListening, this.cancelListening, {super.key});

  final void Function() startListening;
  final void Function() stopListening;
  final void Function() cancelListening;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SttBloc, SttState>(
      buildWhen: (p, c) => p.isEnabled != c.isEnabled || p.isStarted != c.isStarted,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextButton(
              onPressed: !state.isEnabled || state.isStarted ? null : startListening,
              child: const Text('Start'),
            ),
            TextButton(onPressed: state.isStarted ? stopListening : null, child: const Text('Stop')),
            TextButton(onPressed: state.isStarted ? cancelListening : null, child: const Text('Cancel')),
          ],
        );
      },
    );
  }
}
