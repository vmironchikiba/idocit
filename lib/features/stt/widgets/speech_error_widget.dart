import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';

class SpeechErrorWidget extends StatelessWidget {
  const SpeechErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SttBloc, SttState>(
      builder: (context, state) {
        return (state.lastFailure?.error?.errorMsg ?? '').isNotEmpty
            ? Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Error', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
                  ),
                  Center(child: SelectableText((state.lastFailure?.error?.errorMsg ?? ''))),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
