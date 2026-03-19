import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/providers/chats_notifier.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/utils/dialogs.dart';
import 'package:idocit/common/widgets/buttons/long_press_button.dart';
import 'package:idocit/common/widgets/dialogs/warning_dialog.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/common/widgets/input_fields/text_input_field.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/components/domain/blocs/components_bloc.dart';
import 'package:idocit/features/components/domain/usecases/components_init_components.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_reset.dart';
import 'package:idocit/features/idocit/widget/inline_expandable_list.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/models/completions_request.dart';
import 'package:idocit/features/chat/domain/models/enums/role.dart';
import 'package:idocit/features/chat/domain/usecases/chat_completions_stream.dart';
import 'package:idocit/features/chat/domain/usecases/chat_history.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_query.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_reset.dart';
import 'package:idocit/features/idocit/widget/chat_history_list.dart';
import 'package:idocit/features/idocit/widget/last_completion_request_card.dart';
import 'package:idocit/features/idocit/widget/last_user_pending_message.dart';
import 'package:idocit/features/idocit/widget/system_response_card.dart';
import 'package:idocit/features/stt/domain/blocs/stt_bloc.dart';
import 'package:idocit/features/stt/domain/models/enums/stt_actions.dart';
import 'package:idocit/features/stt/domain/models/speech_to_text_config.dart';
import 'package:idocit/features/stt/domain/usecases/stt_start_stop.dart';
import 'package:idocit/features/stt/widgets/help_widget.dart';
import 'package:idocit/features/stt/widgets/microphone_widget.dart';
import 'package:idocit/features/stt/widgets/session_options_widget.dart';
import 'package:idocit/features/tts/domain/blocs/tts_bloc.dart';
import 'package:idocit/features/tts/domain/services/tts_service.dart';
import 'package:idocit/injection_container.dart';
import 'package:flutter/material.dart';

class IdocItChat extends StatefulWidget {
  const IdocItChat({super.key, /*required this.chatTitle,*/ required this.chatId});
  final String chatId;

  @override
  State<IdocItChat> createState() => _IdocItChatState();
}

class _IdocItChatState extends State<IdocItChat> {
  final TextEditingController _controller = TextEditingController();
  late final ScrollController _scrollController;
  List<String> suggestions = [];
  late bool _locals_presented;
  late StreamSubscription<SttState> sttStateSubscription;
  late StreamSubscription<ChatState> chatStateSubscription;

  @override
  initState() {
    super.initState();
    _locals_presented = false;
    _scrollController = ScrollController();

    List<String> preMessageArray = [];
    List<String> preMessageArraySpoken = [];

    locator<ComponentsInit>().call(NoParams()).then((result) {
      result.fold((failure) {}, (_) {});
    });

    locator<ChatLazyInitSuggestions>().call(NoParams());
    chatStateSubscription = locator<ChatBloc>().stream.listen(((state) {
      if (locator<TtsBloc>().state.isEnabled && preMessageArray.length != state.preMessageArray.length) {
        preMessageArraySpoken = preMessageArray;
        preMessageArray = state.preMessageArray;
        preMessageArray.removeWhere((element) => preMessageArraySpoken.contains(element));
        final text = preMessageArray.join(' ');
        _speak(text);
      }
      sttStateSubscription = locator<SttBloc>().stream.listen((sttState) {
        _controller.text = sttState.lastWords;
        if (sttState.finalResult) {
          locator<ChatSuggestionsWithQuery>().call(sttState.lastWords);
        }
        // if (sttState.finalResult && sttState.lastWords.isNotEmpty) {
        //   _controller.text = sttState.lastWords;
        //   locator<ChatSuggestionsWithQuery>().call(sttState.lastWords);
        // }
      });
      _scrollToBottom();
    }));
    locator<GetChatHistory>().call(widget.chatId).then((result) {
      if (result.isRight()) {
        _scrollToBottom();
      }
    });
  }

  @override
  dispose() {
    sttStateSubscription.cancel();
    chatStateSubscription.cancel();
    super.dispose();
  }

  Future<void> _speak(String? text) async {
    await locator<TtsService>().tts.setVolume(locator<TtsBloc>().state.volume);
    await locator<TtsService>().tts.setSpeechRate(locator<TtsBloc>().state.rate);
    await locator<TtsService>().tts.setPitch(locator<TtsBloc>().state.pitch);

    if (text != null) {
      if (text.isNotEmpty) {
        await locator<TtsService>().tts.speak(text);
      }
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  // void _scrollToBottom() {
  //   if (!_scrollController.hasClients) return;

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _scrollController.animateTo(
  //       _scrollController.position.maxScrollExtent,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });
  // }

  Future<void> fetchSuggestions(String query) async {
    await locator<ChatSuggestionsWithQuery>().call(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          const inputHeight = 70.0;

          return Stack(
            children: [
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                  return Stack(
                    children: [
                      ListView(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 65),
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: !state.isInProcess
                                ? ChatHistoryList(
                                    key: const ValueKey('chat_history'),
                                    messages: state.chatHistoryMessages,
                                  )
                                : const SizedBox(key: ValueKey('empty_history')),
                          ),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: state.completionRequests.isNotEmpty
                                ? LastCompletionRequestCard(
                                    key: ValueKey(state.completionRequests.last.chatId),
                                    text: state.completionRequests.last.content,
                                  )
                                : const SizedBox(key: ValueKey('empty_completion')),
                          ),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: state.preMessageArray.isNotEmpty && state.generationResultSystem == null
                                ? LastUserPendingArray(
                                    key: const ValueKey('pending_array'),
                                    preMessageArray: state.preMessageArray,
                                  )
                                : const SizedBox(key: ValueKey('empty_pending')),
                          ),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: state.generationResultSystem != null
                                ? SystemResponseCard(
                                    key: ValueKey(state.generationResultSystem!.hashCode),
                                    message: state.generationResultSystem!,
                                  )
                                : const SizedBox(key: ValueKey('empty_system')),
                          ),

                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child:
                                (state.queryResponse?.categories.expand((c) => c.knowledgeData).toList() ?? [])
                                    .isNotEmpty
                                ? InlineExpandableList(
                                    key: const ValueKey('knowledge_list'),
                                    items: state.queryResponse!.categories.expand((c) => c.knowledgeData).toList(),
                                    onItemTap: (udid, index) {},
                                  )
                                : const SizedBox(key: ValueKey('empty_knowledge')),
                          ),
                        ],
                      ),
                      if (state.chatHistoryMessages.isEmpty &&
                          state.completionRequests.isEmpty &&
                          state.preMessageArray.isEmpty &&
                          state.generationResultSystem == null &&
                          state.queryResponse == null &&
                          !state.isInProcess)
                        Center(child: Image.asset(ImageConstants.chatPreviewPng)),
                      // if (state.isInProcess) Center(child: IdocItLoadingIndicator(size: 30.0)),
                    ],
                  );
                },
              ),

              // ======================================
              // SUGGESTIONS PANEL
              // ======================================
              BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (p, c) => p.suggestionsResponse?.suggestions != c.suggestionsResponse?.suggestions,
                builder: (context, state) {
                  final suggestions = List<String>.from(state.suggestionsResponse?.suggestions ?? []);

                  if (suggestions.isEmpty) return const SizedBox.shrink();

                  return Positioned(
                    bottom: inputHeight,
                    left: 0,
                    right: 0,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: screenHeight - inputHeight - 30),
                      child: Material(
                        elevation: 6,
                        color: ColorConstants.greyBlue450,
                        borderRadius: BorderRadius.circular(8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (_, index) {
                            final text = suggestions[index];
                            return ListTile(
                              title: Text(
                                text,
                                style: TextStyle(color: ColorConstants.black500, fontWeight: FontWeight.w500),
                              ),
                              onTap: () {
                                _controller.text = text;
                                locator<ChatSuggestionsReset>().call(NoParams());
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),

              // ======================================
              // LOCALS PANEL
              // ======================================
              Positioned(
                bottom: inputHeight,
                left: 0,
                right: 0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      axisAlignment: -1.0, // animate from top
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: _locals_presented
                      ? BlocBuilder<ComponentsBloc, ComponentsState>(
                          key: const ValueKey('opened_locals'),
                          buildWhen: (previous, current) =>
                              (previous.componentConfig?.defaultValues?.preferredLanguages ?? []).length !=
                              (current.componentConfig?.defaultValues?.preferredLanguages ?? []).length,
                          builder: (context, componentsState) {
                            return BlocBuilder<SttBloc, SttState>(
                              buildWhen: (p, c) =>
                                  p.localeNames.length != c.localeNames.length ||
                                  p.systemLocale?.name != c.systemLocale?.name,
                              builder: (context, state) {
                                return ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: screenHeight - inputHeight - 30),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        componentsState.componentConfig?.defaultValues?.preferredLanguages.length ?? 0,
                                    itemBuilder: (_, index) {
                                      final localName =
                                          componentsState.componentConfig?.defaultValues?.preferredLanguages[index];
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final currentOptions =
                                                  state.currentOptions ?? SpeechToTextConfig.startOptions;
                                              final localeNames = state.localeNames;
                                              final foundLocal = localeNames.firstWhereOrNull(
                                                (e) => e.localeId.replaceAll('_', '-') == localName,
                                              );
                                              if (foundLocal != null) {
                                                locator<SttBloc>().add(
                                                  UpdateSttCurrentOptions(
                                                    currentOptions: currentOptions.copyWith(
                                                      localeId: foundLocal.localeId,
                                                    ),
                                                  ),
                                                );
                                                final result = await locator<SttStartStop>().call(SttActions.start);
                                                result.fold((failure) {
                                                  LoggerService.logDebug(failure.message);
                                                }, (_) => null);
                                              } else {
                                                await idocitShowDialog(
                                                  IdocItWarningDialog(
                                                    label: 'STT Alert',
                                                    description: '${localName ?? ''} is not supported by STT',
                                                  ),
                                                );
                                              }
                                              setState(() {
                                                _locals_presented = false;
                                              });
                                            },
                                            icon: Container(
                                              decoration: BoxDecoration(
                                                color: ColorConstants.greyBlue450,
                                                borderRadius: BorderRadius.circular(6), // радиус скругления
                                              ),
                                              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                                              child: Text(
                                                textAlign: TextAlign.end,
                                                localName ?? "No locals",
                                                style: TextStyle(
                                                  color: ColorConstants.black450,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const SizedBox(key: ValueKey('closed_locals')),
                ),
              ),

              // ======================================
              // INPUT FIELD
              // ======================================
              BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (p, c) => p.isInProcess != c.isInProcess || p.chatId != c.chatId,
                builder: (context, state) {
                  return Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: ColorConstants.black200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: IdocItTextInputField(
                              controller: _controller,
                              keyboardType: TextInputType.text,
                              withClearButton: true,
                              onChanged: (v) => locator<ChatSuggestionsWithQuery>().call(v),
                            ),
                          ),
                          SizedBox(width: 3.0),
                          BlocBuilder<SttBloc, SttState>(
                            builder: (context, sttState) {
                              return state.isInProcess
                                  ? IdocItLoadingIndicator(color: ColorConstants.white500)
                                  : sttState.isStarted
                                  ? MicrophoneWidget()
                                  : LongPressButton(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        final request = CompletionRequest(
                                          tenant: locator<AuthBloc>().state.userData?.tenant ?? '',
                                          chatId: state.chatId ?? widget.chatId,
                                          language: 'en-US',
                                          content: _controller.text,
                                          role: Role.user.asString(),
                                          onDone: (chatId) async {
                                            final reset = await locator<IdocItReset>().call(NoParams());
                                            if (reset.isLeft()) return;
                                            locator<ChatBloc>().add(ResetRequestedData());
                                            final history = await locator<GetChatHistory>().call(chatId);
                                            if (history.isLeft()) return;
                                            final chats = await locator<IdocItLazyInitChats>().call(NoParams());
                                            if (chats.isLeft()) return;
                                            locator<ChatsNotifier>().send(ChatsEvent.close);
                                            setState(() {});
                                            LoggerService.logDebug('message');
                                          },
                                        );
                                        locator<ChatStartCompletionsStream>().call(request);
                                        _controller.clear();
                                        locator<ChatSuggestionsReset>().call(NoParams());
                                        _scrollToBottom();
                                      },
                                      onDoubleTap: () async {
                                        setState(() {
                                          _locals_presented = false;
                                        });
                                        final options = await showSetUp(
                                          context,
                                          sttState.currentOptions ?? SpeechToTextConfig.startOptions,
                                        );
                                      },
                                      onLongPress: () {
                                        setState(() {
                                          _locals_presented = !_locals_presented;
                                        });
                                      },
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Future<SpeechToTextConfig> showSetUp(BuildContext context, SpeechToTextConfig currentOptions) async {
    var updatedOptions = currentOptions;
    var listenController = TextEditingController()..text = updatedOptions.listenFor.toString();
    var pauseController = TextEditingController()..text = updatedOptions.pauseFor.toString();
    var showHelp = false;
    await showModalBottomSheet(
      elevation: 6,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Material(
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).copyWith().size.height * 0.75,
              minHeight: MediaQuery.of(context).copyWith().size.height * 0.5,
              maxWidth: double.infinity,
            ),
            child: StatefulBuilder(
              builder: (context, setState) => Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Session Options", style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                          child: showHelp
                              ? const HelpWidget()
                              : SessionOptionsWidget(
                                  onChange: (newOptions) {
                                    setState(() {
                                      updatedOptions = newOptions;
                                    });
                                  },
                                  listenForController: listenController,
                                  pauseForController: pauseController,
                                  options: updatedOptions,
                                ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: IconButton(
                      onPressed: () => setState(() => showHelp = !showHelp),
                      icon: Icon(showHelp ? Icons.settings : Icons.question_mark),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    updatedOptions = updatedOptions.copyWith(
      listenFor: int.tryParse(listenController.text) ?? updatedOptions.listenFor,
      pauseFor: int.tryParse(pauseController.text) ?? updatedOptions.pauseFor,
    );
    return updatedOptions;
  }
}
