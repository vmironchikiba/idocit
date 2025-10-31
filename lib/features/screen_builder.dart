import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/common/models/service/usecase.dart';
// import 'package:idocit/common/services/push/push_notifications_service.dart';
// import 'package:idocit/common/widgets/indicators/progress_indicator.dart';
// import 'package:idocit/common/widgets/navigation_bar.dart';
import 'package:idocit/constants/colors.dart';
// import 'package:idocit/constants/image.dart';
// import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_init.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/authentication/screens/login_screen.dart';
// import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
// import 'package:idocit/features/authentication/screens/welcome_screen.dart';
import 'package:idocit/features/dashboard/screens/dashboard_screen.dart';
// import 'package:idocit/features/eco_kit/screens/eco_kit_screen.dart';
// import 'package:idocit/features/profile/screens/profile_screen.dart';
import 'package:idocit/features/splash_screen.dart';
import 'package:idocit/injection_container.dart';

class ScreenBuilder extends StatefulWidget {
  static const routeName = '/';
  static final contextKey = GlobalKey();

  ScreenBuilder({super.key}) {
    debugPrint('TEST');
  }

  @override
  State<ScreenBuilder> createState() => _ScreenBuilderState();
}

class _ScreenBuilderState extends State<ScreenBuilder> with SingleTickerProviderStateMixin {
  final _routeController = PageController();
  late final AnimationController _animationController;
  late final Animation<double> _animatedOpacity;

  int _selectedRouteNumber = DashboardScreen.routeTabNumber;
  bool _isAuthInit = false;
  bool _isSplashInit = false;
  bool _isBlocsInit = false;
  bool _isAnimationInProgress = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100));

    _animatedOpacity = Tween(
      begin: 1.0,
      end: 0.3,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.linear));

    locator<AuthAutoSignIn>().call(NoParams()).then((_) {
      if (mounted) {
        setState(() {
          _isAuthInit = true;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ImageConstants.precacheAssets(context);
  }

  void _onSplashInitHandler() {
    if (_isSplashInit) {
      return;
    }

    setState(() {
      _isSplashInit = true;
    });
  }

  Future<void> _onInitBlocsHandler() async {
    if (_isBlocsInit) {
      return;
    }

    await locator<AuthInit>().call(NoParams());

    setState(() {
      _isBlocsInit = true;
    });
  }

  // Future<void> _updateSelectedRouteNumber(int index) async {
  //   if (_isAnimationInProgress) {
  //     return;
  //   }

  //   if (_selectedRouteNumber == index) {
  //     return;
  //   }

  //   _isAnimationInProgress = true;
  //   await _animationController.forward();

  //   setState(() {
  //     _selectedRouteNumber = index;
  //     _routeController.jumpToPage(index);
  //   });

  //   await _animationController.reverse();
  //   _isAnimationInProgress = false;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      key: ScreenBuilder.contextKey,
      listenWhen: (prev, current) {
        return prev.authType != current.authType;
      },
      listener: (_, state) {
        Navigator.of(context).popUntil(ModalRoute.withName(ScreenBuilder.routeName));

        if (state.authType == AuthType.authenticated) {
          _onInitBlocsHandler();
          // locator<PushNotificationsService>().context = ScreenBuilder.contextKey.currentContext;
        }

        if (state.authType == AuthType.unauthenticated) {
          setState(() {
            _selectedRouteNumber = DashboardScreen.routeTabNumber;
            _isBlocsInit = false;
          });
          // locator<PushNotificationsService>().context = null;
        }
      },
      buildWhen: (prev, current) {
        return prev.authType != current.authType;
      },
      builder: (_, state) {
        if (_isSplashInit == false || _isAuthInit == false) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(systemNavigationBarColor: ColorConstants.black500),
            child: SplashScreen(onFinish: _onSplashInitHandler),
          );
        }

        switch (state.authType) {
          case AuthType.unauthenticated:
            return const AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(systemNavigationBarColor: ColorConstants.black500),
              child: LoginScreen(),
            );

          case AuthType.authenticated:
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(systemNavigationBarColor: ColorConstants.black450),
              child: AbsorbPointer(
                absorbing: !_isBlocsInit,
                child: SafeArea(
                  top: false,
                  child: Column(children: [Expanded(child: DashboardScreen())]),
                ),
              ),
            );
        }
      },
    );
  }
}
