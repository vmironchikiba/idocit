// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/widgets/input_fields/text_input_field.dart';
import 'package:idocit/common/widgets/wrappers/content_wrapper.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/usecases/chat_init.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';
import 'package:idocit/features/chat/domain/usecases/chat_suggestions_query.dart';
import 'package:idocit/injection_container.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> suggestions = [];
  @override
  initState() {
    super.initState();
    locator<ChatLazyInitSuggestions>().call(NoParams());
  }

  Future<void> fetchSuggestions(String query) async {
    // Your API call here
    // final result = ['AAA', 'BB', 'CCC'];
    await locator<ChatSuggestionsWithQuery>().call(query);

    ///await mySuggestionApi(query);
    setState(() {
      // suggestions = result; // update suggestions list
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        suggestions = List<String>.from(state.suggestionsResponse?.suggestions ?? []);
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = constraints.maxHeight;
              const inputHeight = 70.0;
              return Stack(
                children: [
                  /// Main content
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 100), // reserve space for input
                    itemCount: 20,
                    itemBuilder: (_, i) => ListTile(
                      title: Text("Message $i", style: TextStyle(color: Colors.red)),
                    ),
                  ),

                  /// Suggestions dropdown OVER background
                  if (suggestions.isNotEmpty)
                    Positioned(
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
                    ),

                  /// Input field at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onChanged: fetchSuggestions,
                              decoration: InputDecoration(hintText: "Type here...", border: OutlineInputBorder()),
                            ),
                          ),
                          IconButton(icon: const Icon(Icons.send), onPressed: () {}),
                        ],
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
  }
}
