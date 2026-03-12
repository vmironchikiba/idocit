import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';

class SpeechStatusWidget extends StatelessWidget {
  const SpeechStatusWidget({Key? key}) : super(key: key);

  // final String lastStatus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SttBloc, SttState>(
      buildWhen: (p, c) => p.lastStatus != c.lastStatus,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text('Status', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
            ),
            Center(child: SelectableText(state.lastStatus)),
          ],
        );
      },
    );
  }
}
