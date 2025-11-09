import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/widgets/appbar.dart';

class ScaffoldWrapper extends StatelessWidget {
  final Widget child;
  final FootprintAppBar? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool withSafeArea;
  final bool isBlocked;
  final bool resizeToAvoidBottomInset;

  const ScaffoldWrapper({
    Key? key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.withSafeArea = true,
    this.isBlocked = false,
    this.resizeToAvoidBottomInset = false,
  }) : super(key: key);

  // Future<bool> _onWillPopCallback() async {
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // onWillPop: isBlocked ? _onWillPopCallback : null,
      child: AbsorbPointer(
        absorbing: isBlocked,
        child: Scaffold(
          appBar: appBar,
          bottomNavigationBar: bottomNavigationBar,
          backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          body: SafeArea(top: withSafeArea, child: child),
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        ),
      ),
    );
  }
}
