import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/models/in_app_toast_data.dart';
import 'package:idocit/common/usecases/core_update_in_app_toast.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/sizes.dart';
import 'package:idocit/constants/style.dart';
import 'package:idocit/injection_container.dart';

class InAppToastBackground extends StatefulWidget {
  final double margin;

  const InAppToastBackground({required Key? key, this.margin = 16.0}) : super(key: key);

  @override
  State<InAppToastBackground> createState() => _InAppToastBackgroundState();
}

class _InAppToastBackgroundState extends State<InAppToastBackground> {
  final _delayDuration = const Duration(milliseconds: 50);

  InAppToastData? _infoMessage;
  bool _isMessageShowing = false;

  Future<void> _onShowMessageHandler(InAppToastData infoMessage) async {
    if (_infoMessage != null) {
      return;
    }

    setState(() {
      _infoMessage = infoMessage;
      _isMessageShowing = true;
    });
  }

  Future<void> _onRemoveMessageHandler(InAppToastData? infoMessage) async {
    if (infoMessage != null && infoMessage.id != _infoMessage?.id) {
      return;
    }

    await _onHideMessageHandler();
    setState(() {
      _infoMessage = null;
    });

    await Future.delayed(_delayDuration);
    locator<CoreUpdateInAppToast>().call(null);
  }

  Future<void> _onReplaceMessageHandler(InAppToastData infoMessage) async {
    await _onHideMessageHandler();
    setState(() {
      _infoMessage = null;
    });

    await Future.delayed(_delayDuration);
    _onShowMessageHandler(infoMessage);
  }

  Future<void> _onHideMessageHandler() async {
    setState(() {
      _isMessageShowing = false;
    });
    await Future.delayed(StyleConstants.defaultAnimationDuration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoreBloc, CoreState>(
      key: widget.key,
      listenWhen: (prev, current) {
        return prev.inAppToastData?.id != current.inAppToastData?.id;
      },
      listener: (_, state) {
        if (widget.key != state.inAppToastData?.key) {
          return;
        }

        if ((state.inAppToastData == null || state.inAppToastData?.type == InAppToastType.empty) &&
            _infoMessage == null) {
          return;
        }

        if ((state.inAppToastData == null || state.inAppToastData?.type == InAppToastType.empty) &&
            _infoMessage != null) {
          _onRemoveMessageHandler(null);
          return;
        }

        if (state.inAppToastData != null) {
          if (_infoMessage == null) {
            _onShowMessageHandler(state.inAppToastData!);
          } else {
            _onReplaceMessageHandler(state.inAppToastData!);
          }
        }
      },
      child: GestureDetector(
        onTap: () => _onRemoveMessageHandler(_infoMessage),
        child: InAppToastBody(infoMessage: _infoMessage, isShowing: _isMessageShowing, messageMargin: widget.margin),
      ),
    );
  }
}

class InAppToastBody extends StatelessWidget {
  final dynamic infoMessage;
  final bool isShowing;
  final double messageMargin;

  const InAppToastBody({Key? key, required this.infoMessage, required this.isShowing, this.messageMargin = 16.0})
    : assert(infoMessage is InAppToastData || infoMessage is String || infoMessage == null),
      super(key: key);

  void _onResendConfirmationCodeHandler(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  Widget _buildInfoBody(BuildContext context) {
    if (infoMessage is InAppToastData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IdocItText(
            text: infoMessage?.message ?? '',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants.red500, height: 16.0 / 14.0),
            maxLines: 3,
          ),
          if (infoMessage?.type == InAppToastType.warningBadConfirmationCode) ...[
            const SizedBox(height: SizeConstants.defaultPadding),
            IdocItRichText(
              span: TextSpan(
                text: 'Send me verification code again.',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(decoration: TextDecoration.underline, height: 16.0 / 14.0),
                recognizer: TapGestureRecognizer()..onTap = () => _onResendConfirmationCodeHandler(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      );
    }

    if (infoMessage is String) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IdocItText(
            text: infoMessage,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants.red500, height: 16.0 / 14.0),
            maxLines: 3,
          ),
        ],
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: StyleConstants.defaultAnimationDuration,
      opacity: isShowing ? 1.0 : 0.0,
      child: AnimatedContainer(
        duration: StyleConstants.defaultAnimationDuration,
        padding: EdgeInsets.symmetric(vertical: isShowing ? 10.0 : 0.0, horizontal: 12.0),
        margin: EdgeInsets.only(top: isShowing ? messageMargin : 0.0),
        decoration: BoxDecoration(
          color: ColorConstants.red500.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        ),
        child: AnimatedAlign(
          duration: StyleConstants.defaultAnimationDuration,
          alignment: Alignment.centerLeft,
          heightFactor: isShowing ? 1.0 : 0.0,
          child: _buildInfoBody(context),
        ),
      ),
    );
  }
}
