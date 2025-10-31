import 'package:get_it/get_it.dart';
import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/datasources/core_preferences_storage.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/common/providers/charles_provider.dart';
import 'package:idocit/common/providers/theme_provider.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/usecases/core_init.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_remote_datasource.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_update_status.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/authentication/domain/usecases/user/auth_get_user_data.dart';
import 'package:idocit/idocit/lib/api.dart';

final locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton(() => CoreBloc(CoreState.initial()));
  locator.registerLazySingleton(() => DeviceService());
  locator.registerLazySingleton(() => ThemeProvider());
  locator.registerLazySingleton(() => CharlesProvider());
  locator.registerLazySingleton(() => LoggerService());
  locator.registerLazySingleton(() => CorePreferencesStorage());
  locator.registerLazySingleton(() => NetworkListenerService());
  locator.registerLazySingleton(
    () => CoreInit(
      coreBloc: locator<CoreBloc>(),
      corePreferencesStorage: locator<CorePreferencesStorage>(),
      themeProvider: locator<ThemeProvider>(),
      charlesProvider: locator<CharlesProvider>(),
    ),
  );
  locator.registerLazySingleton(() => AuthBloc(AuthState.initial()));
  locator.registerLazySingleton(() => AuthRemoteDataSource());

  locator.registerLazySingleton(
    () => AuthGetUserData(
      networkListenerService: locator<NetworkListenerService>(),
      authBloc: locator<AuthBloc>(),
      authRemoteDataSource: locator<AuthRemoteDataSource>(),
    ),
  );
  // locator.registerLazySingleton(
  //   () => AuthGetUserData(
  //     networkListenerService: locator<NetworkListenerService>(),
  //     authBloc: locator<AuthBloc>(),
  //     authRemoteDataSource: locator<AuthRemoteDataSource>(),
  //   ),
  // );
  locator.registerLazySingleton(() => AuthApi(ApiClient(basePath: 'https://ai-assistant.ibagroupit.com/idocit')));
  locator.registerLazySingleton(
    () => AuthAutoSignIn(
      authBloc: locator<AuthBloc>(),
      authGetUserData: locator<AuthGetUserData>(),
      authUpdateStatus: locator<AuthUpdateStatus>(),
    ),
  );
  locator.registerLazySingleton(() => AuthUpdateStatus(authBloc: locator<AuthBloc>()));
}
