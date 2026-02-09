import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
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
import 'package:idocit/injection_container.dart';
import 'package:flutter/material.dart';

class IdocItChat extends StatefulWidget {
  const IdocItChat({super.key, required this.chatId, required this.chatTitle});
  final String chatId;
  final String chatTitle;

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

    locator<ChatLazyInitSuggestions>().call(NoParams());
    locator<ChatBloc>().stream.listen(((state) {
      _scrollToBottom();
    }));
    locator<GetChatHistory>().call(widget.chatId).then((result) {
      if (result.isRight()) {
        _scrollToBottom();
      }
    });
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
                  return ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.only(bottom: 65),
                    children: [
                      ChatHistoryList(messages: state.chatHistoryMessages),

                      if (state.completionRequests.isNotEmpty)
                        LastCompletionRequestCard(text: state.completionRequests.last.content),

                      if (state.preMessageArray.isNotEmpty && state.generationResultSystem == null)
                        LastUserPendingMessage(text: state.preMessageArray.last),

                      if (state.generationResultSystem != null)
                        SystemResponseCard(message: state.generationResultSystem!),

                      InlineExpandableList(
                        items: state.queryResponse?.categories.expand((c) => c.knowledgeData).toList() ?? [],
                        onItemTap: (udid, index) {},
                      ),

                      // DocNamesExpandableList(
                      //   docNames: state.queryResponse?.categories.expand((c) => c.knowledgeData).toList() ?? [],
                      // ),
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
                        color: ColorConstants.progressBarBackground,
                        borderRadius: BorderRadius.circular(8),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (_, index) {
                            final text = suggestions[index];
                            return ListTile(
                              title: Text(text),
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
                buildWhen: (p, c) => p.isInProcess != c.isInProcess,
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
                                chatId: widget.chatId,
                                language: 'en-US',
                                content: _controller.text,
                                role: Role.user.asString(),
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
