import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';

// ignore: must_be_immutable
class MicrophoneWidget extends StatelessWidget {
  Function()? onPressed;
  MicrophoneWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SttBloc, SttState>(
      builder: (context, state) {
        return Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: .26, spreadRadius: state.level * 1.5, color: Colors.black.withValues(alpha: .05)),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(50)),
          ),
          child: IconButton(icon: const Icon(Icons.mic), onPressed: () {}),
        );
      },
    );
  }
}
