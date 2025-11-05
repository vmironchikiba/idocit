import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/providers/theme_provider.dart';
import 'package:idocit/common/services/navigator.dart';
import 'package:idocit/constants/theme.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/common/models/service/shared_preferences_datasource.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/common/usecases/core_init.dart';
import 'package:idocit/features/authentication/screens/login_screen.dart';
import 'package:idocit/features/idocit/screens/idocit_screen.dart';
import 'package:idocit/features/screen_builder.dart';
import 'package:idocit/idocit/lib/api.dart';
import 'package:idocit/injection_container.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLocator();
  await locator<DeviceService>().init();
  await AbstractSharedPreferencesDatasource.init();
  // Future.wait([locator<DeviceService>().init(), AbstractSharedPreferencesDatasource.init()]);
  runApp(const IDocItApp());
}

class IDocItApp extends StatefulWidget {
  const IDocItApp({super.key});

  final String title = 'Flutter Demo Home Page';

  @override
  State<IDocItApp> createState() => _IDocItAppState();
}

class _IDocItAppState extends State<IDocItApp> {
  @override
  initState() {
    super.initState();
    locator<NetworkListenerService>().listenNetworkChanges();
    locator<CoreInit>().call(NoParams());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<CoreBloc>()),
        BlocProvider.value(value: locator<AuthBloc>()),
      ],
      child: MultiProvider(
        providers: [ChangeNotifierProvider.value(value: locator<ThemeProvider>())],
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeConstants.getTheme(context.watch<ThemeProvider>().type),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en', 'EN')],
            initialRoute: ScreenBuilder.routeName,
            routes: {ScreenBuilder.routeName: (context) => ScreenBuilder()},
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case LoginScreen.routeName:
                  return NavigatorService.getPageRoute(
                    LoginScreen(isFromResetDialog: settings.arguments is bool ? settings.arguments as bool : false),
                  );
                case IdocItScreen.routeName:
                  return NavigatorService.getPageRoute(const IdocItScreen());
                default:
                  return null;
              }
            },
            builder: (context, widget) {
              return Stack(
                children: <Widget>[
                  if (widget != null) Positioned.fill(child: widget),
                  // const SafeArea(
                  //   child: InAppNotificationBackground(),
                  // ),
                  // const Positioned.fill(
                  //   child: InAppFailureBackground(),
                  // ),
                  // if (locator<DeviceService>().currentBuildMode() != BuildMode.prod)
                  //   const Positioned(bottom: 0.0, right: 0.0, child: FootprintBuildVersionBanner()),
                ],
              );
            },
          );
        },
      ),
      /*     Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('You have pushed the button this many times:'),
              Text('---', style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ), */
    );
  }
}
