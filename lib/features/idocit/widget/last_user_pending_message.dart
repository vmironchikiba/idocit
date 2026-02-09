import 'package:flutter/material.dart';
import 'package:idocit/constants/colors.dart';

class LastUserPendingMessage extends StatelessWidget {
  final String text;

  const LastUserPendingMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.blue500.withValues(alpha: 0.1),
      child: ListTile(
        title: Text(text, style: const TextStyle(color: ColorConstants.blue500)),
      ),
    );
  }
}
