// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/models/completions_request.dart';
import 'package:idocit/features/chat/domain/usecases/chat_completions_stream.dart';
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
                // buildWhen: (previous, current) =>
                //     previous.queryResponse?.categories != current.queryResponse?.categories ||
                //     previous.preMessageArray != current.preMessageArray ||
                //     previous.generationResultSystem != current.generationResultSystem,
                builder: (context, state) {
                  final docNames =
                      state.queryResponse?.categories
                          .expand((category) => category.knowledgeData.map((data) => data.text.split('\n').first))
                          .toList() ??
                      [];

                  final List<ChatItem> items = [
                    ...state.preMessageArray.map((msg) => ChatItem(ChatItemType.userMessage, msg)),

                    if (state.generationResultSystem != null)
                      ChatItem(ChatItemType.systemMessage, state.generationResultSystem!),

                    ...docNames.map((name) => ChatItem(ChatItemType.docName, name)),
                  ];

                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100), // reserve space for input
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final item = items[i];

                      Color color = item.type.color();
                      Decoration? decoration = item.type.decoration();
                      return ListTile(
                        title: Container(
                          padding: const EdgeInsets.all(8), // optional, makes it look nicer
                          decoration: decoration,
                          child: Text(item.text, style: TextStyle(color: color)),
                        ),
                      );
                    },
                  );
                },
              ),

              /// Suggestions dropdown OVER background
              BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (previous, current) =>
                    previous.suggestionsResponse?.suggestions != current.suggestionsResponse?.suggestions,
                builder: (context, state) {
                  suggestions = List<String>.from(state.suggestionsResponse?.suggestions ?? []);
                  return suggestions.isNotEmpty
                      ? Positioned(
                          bottom: inputHeight, // <-- just above input field
                          left: 0,
                          right: 0,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: screenHeight - inputHeight - 30),
                            child: Material(
                              elevation: 6,
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: suggestions.length,
                                itemBuilder: (_, index) => ListTile(
                                  title: Text(suggestions[index]),
                                  onTap: () {
                                    _controller.text = suggestions[index];
                                    setState(() {
                                      suggestions.clear();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),

              /// Input field at bottom
              BlocBuilder<ChatBloc, ChatState>(
                buildWhen: (previous, current) => previous.isInProcess != current.isInProcess,
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
                              key: const ValueKey("chat_input"),
                              controller: _controller,
                              onChanged: fetchSuggestions,
                              decoration: InputDecoration(hintText: "Type here...", border: OutlineInputBorder()),
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
