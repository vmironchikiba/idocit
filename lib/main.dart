import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/providers/theme_provider.dart';
import 'package:idocit/common/services/firebase.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_widget.dart';
import 'package:idocit/common/services/navigator.dart';
import 'package:idocit/constants/theme.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/common/models/service/shared_preferences_datasource.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/common/usecases/core_init.dart';
import 'package:idocit/features/authentication/screens/login_screen.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/components/domain/blocs/components_bloc.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/screens/idocit_screen.dart';
import 'package:idocit/features/presets/domain/blocs/presets_bloc.dart';
import 'package:idocit/features/screen_builder.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/speech_to_text_config.dart';
import 'package:idocit/features/stt/domain/usecases/stt_lazy_init.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/features/tts/domain/usecases/tts_lazy_init.dart';
import 'package:idocit/injection_container.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  if (Platform.isIOS) {
    WebViewPlatform.instance = WebKitWebViewPlatform();
  }
  initLocator();
  await locator<DeviceService>().init();
  await locator<TtsService>().init();
  await AbstractSharedPreferencesDatasource.init();
  Future.wait([AbstractSharedPreferencesDatasource.init()]);
  runApp(const IDocItApp());
}

class IDocItApp extends StatefulWidget {
  const IDocItApp({super.key});

  @override
  State<IDocItApp> createState() => _IDocItAppState();
}

class _IDocItAppState extends State<IDocItApp> {
  @override
  initState() {
    super.initState();
    locator<NetworkListenerService>().listenNetworkChanges();
    locator<CoreInit>().call(NoParams());
    locator<FirebaseService>().init();
    locator<SttLazyInit>().call(SpeechToTextConfig.startOptions);
    locator<TtsLazyInit>().call(NoParams());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<CoreBloc>()),
        BlocProvider.value(value: locator<TtsBloc>()),
        BlocProvider.value(value: locator<SttBloc>()),
        BlocProvider.value(value: locator<AuthBloc>()),
        BlocProvider.value(value: locator<IdocItBloc>()),
        BlocProvider.value(value: locator<ComponentsBloc>()),
        BlocProvider.value(value: locator<ChatBloc>()),
        BlocProvider.value(value: locator<DocumentBloc>()),
        BlocProvider.value(value: locator<PresetsBloc>()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: locator<ThemeProvider>()),
          ChangeNotifierProvider.value(value: locator<InAppFailureProvider>()),
        ],
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
                  const Positioned.fill(child: InAppFailureBackground()),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
