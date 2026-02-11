import 'package:flutter/material.dart';
import 'package:idocit/common/widgets/wrappers/dialog_wrapper.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/screen_builder.dart';

Future<T?> idocitShowBottomSheet<T>(
  Widget dialog, {
  BuildContext? context,
  DialogWrapperType type = DialogWrapperType.none,
  bool withBackgroundColor = true,
  bool withBackgroundShadow = true,
  bool isDraggable = true,
  bool isDismissible = true,
}) async {
  final dialogContext = context ?? ScreenBuilder.contextKey.currentContext!;
  final customBackgroundColor = type == DialogWrapperType.webview ? ColorConstants.black500 : null;

  return await showModalBottomSheet<T>(
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))),
    barrierColor: withBackgroundShadow ? null : ColorConstants.transparent,
    backgroundColor: withBackgroundColor ? customBackgroundColor : ColorConstants.transparent,
    isScrollControlled: true,
    enableDrag: isDraggable,
    isDismissible: isDismissible,
    context: dialogContext,
    builder: (_) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(dialogContext).size.height - MediaQuery.of(dialogContext).viewPadding.vertical,
        ),
        child: dialog,
      );
    },
  );
}

Future<T?> idocitShowDialog<T>(Widget dialog, {BuildContext? context}) async {
  final dialogContext = context ?? ScreenBuilder.contextKey.currentContext!;
  return await showDialog<T>(context: dialogContext, builder: (_) => dialog);
}
