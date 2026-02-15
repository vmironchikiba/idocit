import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/constants/colors.dart';

class IdocItAlertDialog extends StatelessWidget {
  final String label;
  final dynamic description;
  final String cancelButtonText;
  final String actionButtonText;
  final VoidCallback cancelButtonCallback;
  final VoidCallback actionButtonCallback;
  final bool isBlocked;

  const IdocItAlertDialog({
    super.key,
    required this.label,
    this.description,
    required this.cancelButtonText,
    required this.actionButtonText,
    required this.cancelButtonCallback,
    required this.actionButtonCallback,
    this.isBlocked = false,
  }) : assert(description is String || description is Widget);

  Widget _buildMaterialDialog(BuildContext context) {
    return AlertDialog(
      title: IdocItText(text: label, style: Theme.of(context).dialogTheme.titleTextStyle),
      content: description is Widget
          ? description
          : IdocItText(text: description!, style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        TextButton(
          onPressed: cancelButtonCallback,
          child: IdocItText(text: cancelButtonText.toUpperCase(), maxLines: 1),
        ),
        TextButton(
          onPressed: actionButtonCallback,
          child: IdocItText(text: actionButtonText.toUpperCase(), maxLines: 1),
        ),
      ],
    );
  }

  Widget _buildCupertinoDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Center(
        child: IdocItText(
          text: label,
          style: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            height: 22.0 / 16.0,
            color: ColorConstants.black500,
          ),
        ),
      ),
      content: Center(
        child: description is Widget
            ? description
            : IdocItText(
                text: description!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'OpenSans',
                  height: 18.0 / 13.0,
                  color: ColorConstants.black500.withValues(alpha: 0.8),
                ),
              ),
      ),
      actions: [
        TextButton(
          onPressed: cancelButtonCallback,
          child: IdocItText(
            text: cancelButtonText,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              height: 22.0 / 16.0,
              color: ColorConstants.blue400,
            ),
            maxLines: 1,
          ),
        ),
        TextButton(
          onPressed: actionButtonCallback,
          child: IdocItText(
            text: actionButtonText,
            style: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              height: 22.0 / 16.0,
              color: ColorConstants.blue400,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isBlocked;
      },
      child: AbsorbPointer(
        absorbing: isBlocked,
        child: Platform.isAndroid ? _buildMaterialDialog(context) : _buildCupertinoDialog(context),
      ),
    );
  }
}
