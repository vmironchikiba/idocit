import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/providers/chats_notifier.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/image.dart';
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

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();

    List<String> preMessageArray = [];
    List<String> preMessageArraySpoken = [];

    locator<ChatLazyInitSuggestions>().call(NoParams());
    locator<ChatBloc>().stream.listen(((state) {
      if (locator<TtsBloc>().state.isEnabled && preMessageArray.length != state.preMessageArray.length) {
        preMessageArraySpoken = preMessageArray;
        preMessageArray = state.preMessageArray;
        preMessageArray.removeWhere((element) => preMessageArraySpoken.contains(element));
        final text = preMessageArray.join(' ');
        _speak(text);
      }
      _scrollToBottom();
    }));
    locator<GetChatHistory>().call(widget.chatId).then((result) {
      if (result.isRight()) {
        _scrollToBottom();
      }
    });
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
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onChanged: (v) => locator<ChatSuggestionsWithQuery>().call(v),
                              decoration: const InputDecoration(hintText: "Type here...", border: OutlineInputBorder()),
                            ),
                          ),
                          IconButton(
                            icon: state.isInProcess
                                ? IdocItLoadingIndicator(color: ColorConstants.white500)
                                : const Icon(Icons.send, color: ColorConstants.white500),
                            onPressed: () {
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
}
