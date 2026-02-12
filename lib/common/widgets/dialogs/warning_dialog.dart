import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/widgets/buttons/text_button.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/constants/sizes.dart';

class IdocItWarningDialog extends StatefulWidget {
  final String label;
  final dynamic description;
  final String? iconSrc;
  final String? buttonText;
  final Function()? buttonCallback;

  const IdocItWarningDialog({
    super.key,
    required this.label,
    required this.description,
    this.iconSrc,
    this.buttonText,
    this.buttonCallback,
  }) : assert(description is String || description is Widget);

  @override
  State<IdocItWarningDialog> createState() => _IdocItWarningDialogState();
}

class _IdocItWarningDialogState extends State<IdocItWarningDialog> {
  bool _isRequestInProgress = false;

  void _onGoBackHandler() {
    Navigator.of(context).pop(false);
  }

  Future<void> _onGoNextHandler() async {
    if (widget.buttonCallback != null) {
      setState(() {
        _isRequestInProgress = true;
      });

      await widget.buttonCallback!();

      setState(() {
        _isRequestInProgress = false;
      });
    }

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
      titlePadding: EdgeInsets.zero,
      title: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 36.0, bottom: 24.0, left: 24.0, right: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.iconSrc != null) ...[
                  SizedBox(height: 122.0, child: SvgPicture.asset(widget.iconSrc!)),
                  const SizedBox(height: 24.0),
                ],
                IdocItText(
                  text: widget.label,
                  style: Theme.of(context).dialogTheme.titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12.0),
                widget.description is Widget
                    ? widget.description
                    : IdocItText(
                        text: widget.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                if (widget.buttonText != null) ...[
                  const SizedBox(height: 24.0),
                  IdocItTextButton(
                    contentText: widget.buttonText!,
                    callback: _onGoNextHandler,
                    withProgress: _isRequestInProgress,
                  ),
                ],
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 12.0, bottom: 8.0),
              child: GestureDetector(
                onTap: _onGoBackHandler,
                child: SizedBox.square(
                  dimension: SizeConstants.defaultIconSize,
                  child: SvgPicture.asset(ImageConstants.icClose),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
