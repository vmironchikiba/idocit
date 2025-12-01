// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/common/widgets/inline_expandable_list.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/models/completions_request.dart';
import 'package:idocit/features/chat/domain/usecases/chat_completions_stream.dart';
import 'package:idocit/features/chat/domain/usecases/chat_history.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_query.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_reset.dart';
import 'package:idocit/injection_container.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> suggestions = [];
  // final test = CompletionRequest(
  //   tenant: "kaz_audit",
  //   chatId: 'chatcmpl-17ce01bf839b4fcda2376390fa419ea0',
  //   language: 'en-US',
  //   content:
  //       'В каком формате должна представляться информация в Единую базу данных через шлюз "электронного правительства"?',
  //   role: 'user',
  // );

  @override
  initState() {
    super.initState();
    locator<ChatLazyInitSuggestions>().call(NoParams());
    locator<ChatBloc>().stream.listen(((state) {}));
    locator<GetChatHistory>().call('chatcmpl-17ce01bf839b4fcda2376390fa419ea0');
  }

  Future<void> fetchSuggestions(String query) async {
    await locator<ChatSuggestionsWithQuery>().call(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: SvgPicture.asset(ImageConstants.igIdocIt, height: 56, width: 56)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          const inputHeight = 70.0;

          return Stack(
            children: [
              BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  final docNames =
                      state.queryResponse?.categories.expand((c) => c.knowledgeData.map((d) => d.text)).toList() ?? [];

                  return ListView(
                    padding: const EdgeInsets.only(bottom: 120),
                    children: [
                      if (state.completionRequests.isNotEmpty)
                        Card(
                          color: ColorConstants.black200,
                          child: ListTile(
                            leading: SvgPicture.asset(ImageConstants.userChatAvatarSvg, height: 21, width: 21),
                            title: Text(
                              state.completionRequests.last.content,
                              style: const TextStyle(color: ColorConstants.white500),
                            ),
                          ),
                        ),
                      // -------------------------------------------
                      // 1) USER messages — expandable
                      // -------------------------------------------
                      if (state.preMessageArray.isNotEmpty && state.generationResultSystem == null)
                        Card(
                          color: ColorConstants.blue500.withValues(alpha: 0.1),
                          child: ListTile(
                            title: Text(
                              state.preMessageArray.last,
                              style: const TextStyle(color: ColorConstants.blue500),
                            ),
                          ),
                        ),

                      // InlineExpandableList(
                      //   items: state.preMessageArray,
                      //   onItemTap: (index) {
                      //     // Optional action on tap
                      //   },
                      // ),
                      const SizedBox(height: 10),

                      // -------------------------------------------
                      // 2) SYSTEM message — a single string
                      // -------------------------------------------
                      if (state.generationResultSystem != null)
                        Card(
                          color: ColorConstants.blue500.withValues(alpha: 0.1),
                          child: ListTile(
                            title: Text(
                              state.generationResultSystem!,
                              style: const TextStyle(color: ColorConstants.blue500),
                            ),
                          ),
                        ),

                      const SizedBox(height: 10),

                      // -------------------------------------------
                      // 3) DOCUMENT NAMES — expandable
                      // -------------------------------------------
                      if (docNames.isNotEmpty)
                        InlineExpandableList(
                          items: docNames,
                          onItemTap: (index) {
                            // Optional: scroll to doc, fill input, etc.
                          },
                        ),
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
                        color: Colors.white,
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
                      color: ColorConstants.greyBlue800,
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
                                tenant: "kaz_audit",
                                chatId: 'chatcmpl-17ce01bf839b4fcda2376390fa419ea0',
                                language: 'en-US',
                                content: _controller.text,
                                role: 'user',
                              );
                              locator<ChatStartCompletionsStream>().call(request);
                              _controller.clear();
                              locator<ChatSuggestionsReset>().call(NoParams());
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

enum ChatItemType { userMessage, systemMessage, docName }

extension ChatItemTypeExtended on ChatItemType {
  Color color() {
    switch (this) {
      case ChatItemType.userMessage:
        return ColorConstants.green600;
      case ChatItemType.systemMessage:
        return ColorConstants.blue500;
      case ChatItemType.docName:
        return ColorConstants.red400;
    }
  }

  Decoration? decoration() {
    switch (this) {
      case ChatItemType.userMessage:
        return null;
      case ChatItemType.systemMessage:
        return null;
      case ChatItemType.docName:
        return BoxDecoration(
          border: Border.all(color: color(), width: 1),
          borderRadius: BorderRadius.circular(8),
        );
    }
  }
}

class ChatItem {
  final ChatItemType type;
  final String text;

  ChatItem(this.type, this.text);
}
