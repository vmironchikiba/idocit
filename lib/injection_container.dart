import 'package:get_it/get_it.dart';
import 'package:idocit/common/blocs/core_bloc.dart';
import 'package:idocit/common/datasources/core_preferences_storage.dart';
import 'package:idocit/common/providers/chats_notifier.dart';
import 'package:idocit/common/services/firebase.dart';
import 'package:idocit/common/services/in_app_failures/in_app_failure_provider.dart';
import 'package:idocit/common/services/navigator.dart';
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
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_out.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_in.dart';
import 'package:idocit/features/authentication/domain/usecases/user/auth_get_user_data.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/datasources/chat_history_remote_datasource.dart';
import 'package:idocit/features/chat/domain/datasources/chat_suggestions_remote_data_source.dart';
import 'package:idocit/features/chat/domain/usecases/chat_completions_stream.dart';
import 'package:idocit/features/chat/domain/usecases/chat_history.dart';
import 'package:idocit/features/chat/domain/usecases/chat_reset.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_query.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_reset.dart';
import 'package:idocit/features/components/domain/blocs/components_bloc.dart';
import 'package:idocit/features/components/domain/datasources/components_remote_datasource.dart';
import 'package:idocit/features/components/domain/usecases/components_get_components.dart';
import 'package:idocit/features/components/domain/usecases/components_init_components.dart';
import 'package:idocit/features/document/domain/bloc/document_bloc.dart';
import 'package:idocit/features/document/domain/datasources/document_datasource.dart';
import 'package:idocit/features/document/domain/usecases/get_document_by_id.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/datasources/idocit_remote_datasource.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_delete_chat.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_reset.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
import 'package:idocit/features/presets/domain/blocs/presets_bloc.dart';
import 'package:idocit/features/presets/domain/datasources/presets_remote_datasource.dart';
import 'package:idocit/features/presets/domain/usecases/get_all_presets.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/services/stt_service.dart';
import 'package:idocit/features/stt/domain/usecases/stt_lazy_init.dart';
import 'package:idocit/features/stt/domain/usecases/stt_set_current_options.dart';
import 'package:idocit/features/stt/domain/usecases/stt_start_stop.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/datasources/tts_preferences_storage.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/features/tts/domain/usecases/get_max_speech_input_length.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_enabled.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_pitch.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_rate.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_get_volume.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_set_enabled.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_default_engine.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_default_voice.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_engines.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_is_current_language_installed.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_languages.dart';
import 'package:idocit/features/tts/domain/usecases/tts_get_voices.dart';
import 'package:idocit/features/tts/domain/usecases/tts_lazy_init.dart';
import 'package:idocit/features/tts/domain/usecases/tts_pause.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_current_engine.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_is_current_language_installed.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_language.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_set_pitch.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_set_rate.dart';
import 'package:idocit/features/tts/domain/usecases/tts_set_voice.dart';
import 'package:idocit/features/tts/domain/usecases/profile/tts_set_volume.dart';
import 'package:idocit/features/tts/domain/usecases/tts_stop.dart';
import 'package:idocit/idocit/lib/api.dart';

final locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton(() => CoreBloc(CoreState.initial()));
  locator.registerLazySingleton(() => TtsBloc(TtsState.initial()));
  locator.registerLazySingleton(() => DeviceService());
  locator.registerLazySingleton(() => TtsService(deviceService: locator<DeviceService>()));
  locator.registerLazySingleton(() => SttBloc(SttState.initial()));

  locator.registerLazySingleton(() => SttService(deviceService: locator<DeviceService>()));
  locator.registerLazySingleton(() => ThemeProvider());
  locator.registerLazySingleton(() => ChatsNotifier());
  locator.registerLazySingleton(() => CharlesProvider());
  locator.registerLazySingleton(() => InAppFailureProvider());
  locator.registerLazySingleton(() => LoggerService());

  locator.registerLazySingleton(() => FirebaseService(deviceService: locator<DeviceService>()));
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
  locator.registerLazySingleton(() => PresetsBloc(PresetsState.initial()));
  locator.registerLazySingleton(() => ChatBloc(ChatState.initial()));
  locator.registerLazySingleton(() => DocumentBloc(DocumentState.initial()));
  locator.registerLazySingleton(
    () => IdocItReset(networkListenerService: locator<NetworkListenerService>(), idocItBloc: locator<IdocItBloc>()),
  );
  locator.registerLazySingleton(
    () => ChatReset(networkListenerService: locator<NetworkListenerService>(), chatBloc: locator<ChatBloc>()),
  );
  locator.registerLazySingleton(
    () => ChatLazyInitSuggestions(
      networkListenerService: locator<NetworkListenerService>(),
      chatBloc: locator<ChatBloc>(),
      authBloc: locator<AuthBloc>(),
      chatRemoteDataSource: locator<ChatSuggestionsRemoteDataSource>(),
      authAutoSignIn: locator<AuthAutoSignIn>(),
    ),
  );
  locator.registerLazySingleton(
    () => ChatSuggestionsWithQuery(
      networkListenerService: locator<NetworkListenerService>(),
      chatBloc: locator<ChatBloc>(),
      authBloc: locator<AuthBloc>(),
      chatRemoteDataSource: locator<ChatSuggestionsRemoteDataSource>(),
      authAutoSignIn: locator<AuthAutoSignIn>(),
    ),
  );
  locator.registerLazySingleton(() => ChatSuggestionsReset(chatBloc: locator<ChatBloc>()));

  //ChatSuggestionsReset
  locator.registerLazySingleton(
    () => ChatStartCompletionsStream(
      networkListenerService: locator<NetworkListenerService>(),
      chatBloc: locator<ChatBloc>(),
      authBloc: locator<AuthBloc>(),
      ttsService: locator<TtsService>(),
    ),
  );
  locator.registerLazySingleton(() => AuthBloc(AuthState.initial()));
  locator.registerLazySingleton(() => AuthInit(networkListenerService: locator<NetworkListenerService>()));
  locator.registerLazySingleton(() => AuthRemoteDataSource());

  locator.registerLazySingleton(
    () => AuthGetUserData(
      networkListenerService: locator<NetworkListenerService>(),
      authBloc: locator<AuthBloc>(),
      authRemoteDataSource: locator<AuthRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton(() => NavigatorService());
  locator.registerLazySingleton(
    () => TtsSetEnabled(ttsBloc: locator<TtsBloc>(), ttsPreferencesStorage: locator<TtsPreferencesStorage>()),
  );
  locator.registerLazySingleton(
    () => TtsSetVolume(
      ttsBloc: locator<TtsBloc>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsService: locator<TtsService>(),
    ),
  );
  locator.registerLazySingleton(
    () => TtsSetPitch(
      ttsBloc: locator<TtsBloc>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsService: locator<TtsService>(),
    ),
  );
  locator.registerLazySingleton(
    () => TtsSetRate(
      ttsBloc: locator<TtsBloc>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsService: locator<TtsService>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsLazyInit(
      networkListenerService: locator<NetworkListenerService>(),
      ttsBloc: locator<TtsBloc>(),
      ttsService: locator<TtsService>(),
      ttsGetLanguages: locator<TtsGetLanguages>(),
      ttsGetVoices: locator<TtsGetVoices>(),
      ttsGetEnabled: locator<TtsGetEnabled>(),
      ttsGetPitch: locator<TtsGetPitch>(),
      ttsGetRate: locator<TtsGetRate>(),
      ttsGetVolume: locator<TtsGetVolume>(),
      ttsGetDefaultEngine: locator<TtsGetDefaultEngine>(),
      ttsGetEngines: locator<TtsGetEngines>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsGetEnabled(ttsBloc: locator<TtsBloc>(), ttsPreferencesStorage: locator<TtsPreferencesStorage>()),
  );

  locator.registerLazySingleton(
    () => TtsGetVolume(
      ttsBloc: locator<TtsBloc>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsService: locator<TtsService>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsGetPitch(
      ttsBloc: locator<TtsBloc>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsService: locator<TtsService>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsGetRate(
      ttsBloc: locator<TtsBloc>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsService: locator<TtsService>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsGetIsCurrentLanguageInstalled(ttsBloc: locator<TtsBloc>(), ttsService: locator<TtsService>()),
  );

  locator.registerLazySingleton(() => TtsSetIsCurrentLanguageInstalled(ttsBloc: locator<TtsBloc>()));

  locator.registerLazySingleton(
    () => TtsGetMaxSpeechInputLength(ttsBloc: locator<TtsBloc>(), ttsService: locator<TtsService>()),
  );

  locator.registerLazySingleton(
    () => TtsSetLanguage(
      networkListenerService: locator<NetworkListenerService>(),
      ttsBloc: locator<TtsBloc>(),
      ttsService: locator<TtsService>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsGetIsCurrentLanguageInstalled: locator<TtsGetIsCurrentLanguageInstalled>(),
    ),
  );
  locator.registerLazySingleton(
    () => TtsGetLanguages(
      networkListenerService: locator<NetworkListenerService>(),
      ttsBloc: locator<TtsBloc>(),
      ttsService: locator<TtsService>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsSetCurrentEngine(
      networkListenerService: locator<NetworkListenerService>(),
      ttsBloc: locator<TtsBloc>(),
      ttsService: locator<TtsService>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsGetDefaultEngine(
      networkListenerService: locator<NetworkListenerService>(),
      ttsBloc: locator<TtsBloc>(),
      ttsService: locator<TtsService>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
      ttsSetCurrentEngine: locator<TtsSetCurrentEngine>(),
    ),
  );
  locator.registerLazySingleton(() => TtsGetEngines(ttsBloc: locator<TtsBloc>(), ttsService: locator<TtsService>()));
  locator.registerLazySingleton(() => TtsGetVoices(ttsBloc: locator<TtsBloc>(), ttsService: locator<TtsService>()));
  locator.registerLazySingleton(
    () => TtsSetVoice(
      networkListenerService: locator<NetworkListenerService>(),
      ttsBloc: locator<TtsBloc>(),
      ttsService: locator<TtsService>(),
      ttsPreferencesStorage: locator<TtsPreferencesStorage>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsGetDefaultVoice(
      ttsBloc: locator<TtsBloc>(),
      ttsService: locator<TtsService>(),
      ttsSetVoice: locator<TtsSetVoice>(),
    ),
  );

  locator.registerLazySingleton(
    () => TtsStop(ttsService: locator<TtsService>(), chatStartCompletionsStream: locator<ChatStartCompletionsStream>()),
  );
  locator.registerLazySingleton(() => TtsPause(ttsService: locator<TtsService>()));

  locator.registerLazySingleton(() => TtsPreferencesStorage());
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
    () => AuthSignOut(
      networkListenerService: locator<NetworkListenerService>(),
      authBloc: locator<AuthBloc>(),
      authRemoteDataSource: locator<AuthRemoteDataSource>(),
      authSecureStorage: locator<AuthSecureStorage>(),
      authUpdateStatus: locator<AuthUpdateStatus>(),
    ),
  );
  locator.registerLazySingleton(
    () => AuthAutoSignIn(
      networkListenerService: locator<NetworkListenerService>(),
      authBloc: locator<AuthBloc>(),
      authGetUserData: locator<AuthGetUserData>(),
      authUpdateStatus: locator<AuthUpdateStatus>(),
      authSecureStorage: locator<AuthSecureStorage>(),
      authSignIn: locator<AuthSignIn>(),
      authRemoteDataSource: locator<AuthRemoteDataSource>(),
    ),
  );
  locator.registerLazySingleton(() => AuthUpdateStatus(authBloc: locator<AuthBloc>()));
  locator.registerLazySingleton(() => CoreUpdateInAppToast(coreBloc: locator<CoreBloc>()));
  locator.registerLazySingleton(() => IdocItRemoteDataSource());
  locator.registerLazySingleton(() => ComponentsRemoteDataSource());
  locator.registerLazySingleton(() => PresetsRemoteDataSource());
  locator.registerLazySingleton(() => ChatSuggestionsRemoteDataSource());
  locator.registerLazySingleton(() => ChatHistoryRemoteDataSource());

  locator.registerLazySingleton(() => DocumentRemoteDataSource());
  locator.registerLazySingleton(
    () => IdocItLazyInitChats(
      networkListenerService: locator<NetworkListenerService>(),
      idocItBloc: locator<IdocItBloc>(),
      authBloc: locator<AuthBloc>(),
      idocItRemoteDataSource: locator<IdocItRemoteDataSource>(),
      authAutoSignIn: locator<AuthAutoSignIn>(),
    ),
  );

  locator.registerLazySingleton(
    () => IdocItDeleteChat(
      networkListenerService: locator<NetworkListenerService>(),
      idocItBloc: locator<IdocItBloc>(),
      authBloc: locator<AuthBloc>(),
      idocItRemoteDataSource: locator<IdocItRemoteDataSource>(),
      idocItLazyInitChats: locator<IdocItLazyInitChats>(),
      authAutoSignIn: locator<AuthAutoSignIn>(),
    ),
  );
  //IdocItDeleteChat
  locator.registerLazySingleton(
    () => GetChatHistory(
      networkListenerService: locator<NetworkListenerService>(),
      chatBloc: locator<ChatBloc>(),
      authBloc: locator<AuthBloc>(),
      chatHistoryRemoteDataSource: locator<ChatHistoryRemoteDataSource>(),
      authAutoSignIn: locator<AuthAutoSignIn>(),
    ),
  );
  locator.registerLazySingleton(
    () => GetDocumentById(
      networkListenerService: locator<NetworkListenerService>(),
      documentBloc: locator<DocumentBloc>(),
      authBloc: locator<AuthBloc>(),
      documentRemoteDataSource: locator<DocumentRemoteDataSource>(),
      authAutoSignIn: locator<AuthAutoSignIn>(),
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
  locator.registerLazySingleton(
    () => GetAllPresets(
      networkListenerService: locator<NetworkListenerService>(),
      presetsBloc: locator<PresetsBloc>(),
      authBloc: locator<AuthBloc>(),
      presetsRemoteDataSource: locator<PresetsRemoteDataSource>(),
    ),
  );

  locator.registerLazySingleton(
    () => SttLazyInit(
      networkListenerService: locator<NetworkListenerService>(),
      sttBloc: locator<SttBloc>(),
      sttService: locator<SttService>(),
    ),
  );
  locator.registerLazySingleton(
    () => SttSetCurrentOptions(
      networkListenerService: locator<NetworkListenerService>(),
      sttBloc: locator<SttBloc>(),
      sttService: locator<SttService>(),
    ),
  );

  locator.registerLazySingleton(
    () => SttStartStop(
      networkListenerService: locator<NetworkListenerService>(),
      sttBloc: locator<SttBloc>(),
      sttService: locator<SttService>(),
    ),
  );
}
