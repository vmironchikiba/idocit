import 'package:flutter/material.dart';
import 'package:idocit/constants/colors.dart';

class SystemResponseCard extends StatelessWidget {
  final String message;

  const SystemResponseCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConstants.blue500.withValues(alpha: 0.1),
      child: ListTile(
        title: Text(message, style: const TextStyle(color: ColorConstants.blue500)),
      ),
    );
  }
}
