import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/enums/stt_actions.dart';
import 'package:idocit/features/stt/domain/usecases/stt_start_stop.dart';
import 'package:idocit/features/stt/widgets/microphone_widget.dart';
import 'package:idocit/injection_container.dart';

class RecognitionResultsWidget extends StatelessWidget {
  const RecognitionResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SttBloc, SttState>(
      buildWhen: (p, c) => p.speechRecognitionResult != c.speechRecognitionResult || p.level != c.level,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            Center(child: Text('Recognized Words', style: Theme.of(context).textTheme.titleMedium)),
            Stack(
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints(minHeight: 200),
                  color: Theme.of(context).secondaryHeaderColor,
                  child: Center(
                    child: Text(
                      state.speechRecognitionResult?.recognizedWords ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: ColorConstants.black500),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: MicrophoneWidget(
                      onPressed: () {
                        locator<SttStartStop>().call(SttActions.cancel);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
