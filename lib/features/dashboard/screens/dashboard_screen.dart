// import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:idocit/common/services/logger.dart';
// import 'package:idocit/common/widgets/wrappers/scaffold_wrapper.dart';
// import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
// import 'package:idocit/injection_container.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  static const routeTabNumber = 0;
  static const routeTabName = 'Home';

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with AutomaticKeepAliveClientMixin<DashboardScreen> {
  // bool _isRequestInProgress = false;
  // bool _isRefreshInProgress = false;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // Future<void> _onRefreshHandler() async {
  //   if (_isRefreshInProgress) {
  //     return;
  //   }

  //   setState(() {
  //     _isRefreshInProgress = true;
  //   });

  //   setState(() {
  //     _isRefreshInProgress = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: Center(child: Text('TODO DASHBOARD')));
  }

  @override
  bool get wantKeepAlive => true;
}
