import 'package:flutter/material.dart';
// import 'package:idocit/common/utils/gif_builder.dart';
// import 'package:idocit/constants/image.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const SplashScreen({super.key, required this.onFinish});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000)).then((_) => widget.onFinish());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('TODO SPLASH'));
  }
}
