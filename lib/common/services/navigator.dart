import 'package:flutter/material.dart';
import 'package:idocit/constants/style.dart';
// import 'package:swipeable_page_route/swipeable_page_route.dart';

class NavigatorService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static PageRoute getPageRoute(Widget screen, {RouteSettings? settings, bool canSwipe = true, bool isAndroid = true}) {
    // if (isAndroid) {
    return MaterialPageRoute(settings: settings, builder: (context) => screen);
    // }

    // return SwipeablePageRoute(
    //   canSwipe: canSwipe,
    //   canOnlySwipeFromEdge: true,
    //   settings: settings,
    //   builder: (context) => screen,
    // );
  }

  static Future<dynamic>? navigateToKey(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => route.settings.name != routeName,
      arguments: arguments,
    );
  }

  static Future<dynamic>? navigateToContext(BuildContext context, {required String routeName, dynamic arguments}) {
    return Future.delayed(
      StyleConstants.defaultAnimationDuration,
      () => Navigator.of(context).pushNamed(routeName, arguments: arguments),
    );
  }
}
