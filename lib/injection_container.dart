import 'package:get_it/get_it.dart';
import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/datasources/core_preferences_storage.dart';
import 'package:idocit/common/services/network_listener.dart';
import 'package:idocit/common/usecases/core_update_in_app_toast.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/common/providers/charles_provider.dart';
import 'package:idocit/common/providers/theme_provider.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/usecases/core_init.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_remote_datasource.dart';
import 'package:idocit/features/authentication/domain/datasources/auth_secure_storage.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_init.dart';
import 'package:idocit/features/authentication/domain/usecases/auth_update_status.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_auto_sign_in.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_in.dart';
import 'package:idocit/features/authentication/domain/usecases/user/auth_get_user_data.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/api/chat_remote_datasource.dart';
import 'package:idocit/features/chat/domain/usecases/chat_completions_stream.dart';
import 'package:idocit/features/chat/domain/usecases/chat_init.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_query.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_reset.dart';
import 'package:idocit/features/components/domain/blocs/components_bloc.dart';
import 'package:idocit/features/components/domain/datasources/components_remote_datasource.dart';
import 'package:idocit/features/components/domain/usecases/components_get_components.dart';
import 'package:idocit/features/components/domain/usecases/components_init_components.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_init.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
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
  locator.registerLazySingleton(() => IdocItBloc(IdocItState.initial()));
  locator.registerLazySingleton(() => ComponentsBloc(ComponentsState.initial()));
  locator.registerLazySingleton(() => ChatBloc(ChatState.initial()));
  locator.registerLazySingleton(
    () => IdocItInit(networkListenerService: locator<NetworkListenerService>(), idocItBloc: locator<IdocItBloc>()),
  );
  locator.registerLazySingleton(
    () => ChatInit(networkListenerService: locator<NetworkListenerService>(), idocItBloc: locator<ChatBloc>()),
  );
  locator.registerLazySingleton(
    () => ChatLazyInitSuggestions(
      networkListenerService: locator<NetworkListenerService>(),
      chatBloc: locator<ChatBloc>(),
      authBloc: locator<AuthBloc>(),
      chatRemoteDataSource: locator<ChatRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton(
    () => ChatSuggestionsWithQuery(
      networkListenerService: locator<NetworkListenerService>(),
      chatBloc: locator<ChatBloc>(),
      authBloc: locator<AuthBloc>(),
      chatRemoteDataSource: locator<ChatRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton(() => ChatSuggestionsReset(chatBloc: locator<ChatBloc>()));

  //ChatSuggestionsReset
  locator.registerLazySingleton(
    () => ChatStartCompletionsStream(
      networkListenerService: locator<NetworkListenerService>(),
      chatBloc: locator<ChatBloc>(),
      authBloc: locator<AuthBloc>(),
    ),
  );
  locator.registerLazySingleton(() => AuthBloc(AuthState.initial()));
  locator.registerLazySingleton(
    () => AuthInit(networkListenerService: locator<NetworkListenerService>(), idocItInit: locator<IdocItInit>()),
  );
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
  locator.registerLazySingleton(() => ApiClient(basePath: 'https://ai-assistant.ibagroupit.com/idocit'));
  locator.registerLazySingleton(() => AuthApi(locator<ApiClient>()));
  locator.registerLazySingleton(() => UsersApi(locator<ApiClient>()));

  locator.registerLazySingleton(() => AuthSecureStorage());

  locator.registerLazySingleton(
    () => AuthSignIn(
      networkListenerService: locator<NetworkListenerService>(),
      authBloc: locator<AuthBloc>(),
      authRemoteDataSource: locator<AuthRemoteDataSource>(),
      authSecureStorage: locator<AuthSecureStorage>(),
      authGetUserData: locator<AuthGetUserData>(),
      authUpdateStatus: locator<AuthUpdateStatus>(),
    ),
  );
  locator.registerLazySingleton(
    () => AuthAutoSignIn(
      authBloc: locator<AuthBloc>(),
      authGetUserData: locator<AuthGetUserData>(),
      authUpdateStatus: locator<AuthUpdateStatus>(),
    ),
  );
  locator.registerLazySingleton(() => AuthUpdateStatus(authBloc: locator<AuthBloc>()));
  locator.registerLazySingleton(() => CoreUpdateInAppToast(coreBloc: locator<CoreBloc>()));
  locator.registerLazySingleton(() => IdocItRemoteDataSource());
  locator.registerLazySingleton(() => ComponentsRemoteDataSource());
  locator.registerLazySingleton(() => ChatRemoteDataSource());
  locator.registerLazySingleton(
    () => IdocItLazyInitChats(
      networkListenerService: locator<NetworkListenerService>(),
      idocItBloc: locator<IdocItBloc>(),
      authBloc: locator<AuthBloc>(),
      idocItRemoteDataSource: locator<IdocItRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton(
    () => ComponentsInit(
      networkListenerService: locator<NetworkListenerService>(),
      componentsBloc: locator<ComponentsBloc>(),
    ),
  );
  locator.registerLazySingleton(
    () => ComponentsGetComponents(
      networkListenerService: locator<NetworkListenerService>(),
      componentsBloc: locator<ComponentsBloc>(),
      authBloc: locator<AuthBloc>(),
      componentsRemoteDataSource: locator<ComponentsRemoteDataSource>(),
    ),
  );
}
