import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/providers/chats_notifier.dart';
import 'package:idocit/common/utils/dialogs.dart';
import 'package:idocit/common/widgets/buttons/text_button.dart';
import 'package:idocit/common/widgets/indicators/loading_indicator.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_delete_chat.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
import 'package:idocit/features/idocit/widget/profile_logout_dialog.dart';
import 'package:idocit/features/idocit/widget/user_profile.dart';
import 'package:idocit/injection_container.dart';
import 'package:flutter/material.dart';

class SliderMenu extends StatefulWidget {
  final Function(String, String)? onItemClick;

  const SliderMenu({super.key, this.onItemClick});

  @override
  State<SliderMenu> createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  bool _isRequestInProgress = false;
  bool _isChatInProgress = false;
  String? _isChatInProgressId;
  bool _isNewChatAdded = false;
  bool _profileOpened = false;
  final ExpansibleController _controller = ExpansibleController();

  @override
  void initState() {
    super.initState();
    _isRequestInProgress = true;
    _isChatInProgress = false;
    _isNewChatAdded = true;
    locator<IdocItLazyInitChats>().call(NoParams()).then((onValue) {
      setState(() {
        _isRequestInProgress = false;
      });
    });

    locator<ChatsNotifier>().addListener(() {
      if (locator<ChatsNotifier>().event == ChatsEvent.close) {
        setState(() {
          _isNewChatAdded = false;
        });
      }
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      _isRequestInProgress = true;
    });
    await locator<IdocItLazyInitChats>().call(NoParams());

    setState(() {
      _isRequestInProgress = false;
    });
  }

  Future<void> _handleLogOut() async {
    if (_isRequestInProgress) {
      return;
    }

    setState(() {
      _isRequestInProgress = true;
    });
    final isCompleted = await idocitShowDialog(const ProfileLogOutDialog(), context: context);
    if (isCompleted == true) {
      return;
    }

    setState(() {
      _isRequestInProgress = false;
    });

    setState(() {
      _isRequestInProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.black300,
      padding: const EdgeInsets.only(top: 5, left: 4.0),
      child: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (p, c) => p.chatId != c.chatId,
        builder: (chatContext, chatState) {
          return BlocBuilder<IdocItBloc, IdocItState>(
            buildWhen: (previous, current) => previous.chats.hashCode != current.chats.hashCode,
            builder: (context, state) {
              final chatsButtons = state.chats.map((chat) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return SizeTransition(
                      sizeFactor: animation,
                      axisAlignment: -1,
                      child: FadeTransition(opacity: animation, child: child),
                    );
                  },
                  child: Padding(
                    key: ValueKey(chat.id), // ВАЖНО
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: IdocItTextButton(
                            contentText: chat.title,
                            callback: () async {
                              _isNewChatAdded = false;
                              setState(() {
                                _isChatInProgress = true;
                                _isChatInProgressId = chat.id;
                              });
                              if (widget.onItemClick == null) return;
                              await widget.onItemClick!(chat.id, chat.title);
                              setState(() {
                                _isChatInProgress = false;
                                _isChatInProgressId = null;
                              });
                            },
                            color: ColorConstants.black400,
                            isSelected: chat.id == chatState.chatId,
                          ),
                        ),
                        _isChatInProgressId != chat.id
                            ? InkWell(
                                onTap: () async {
                                  setState(() {
                                    _isChatInProgress = true;
                                    _isChatInProgressId = chat.id;
                                  });

                                  await locator<IdocItDeleteChat>().call(chat.id);
                                  await locator<IdocItLazyInitChats>().call(NoParams());

                                  setState(() {
                                    _isChatInProgress = false;
                                    _isChatInProgressId = null;
                                  });
                                },
                                borderRadius: BorderRadius.circular(4),
                                child: const Padding(
                                  padding: EdgeInsets.all(1),
                                  child: Icon(Icons.delete, size: 24, color: ColorConstants.white500),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: IdocItLoadingIndicator(color: ColorConstants.white500),
                              ),
                      ],
                    ),
                  ),
                );
              }).toList();
              return Material(
                // Добавлен Material виджет как предок для ListTile
                color: ColorConstants.black300,
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: _isRequestInProgress
                      ? Center(child: IdocItLoadingIndicator())
                      : ListView(
                          children: <Widget>[
                            ExpansionTile(
                              controller: _controller,
                              leading: Icon(
                                _profileOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                color: ColorConstants.white500,
                              ),
                              onExpansionChanged: (value) => setState(() => _profileOpened = value),
                              title: Text(
                                locator<AuthBloc>().state.userData?.username ?? 'No name',
                                style: const TextStyle(
                                  color: ColorConstants.white500,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              tilePadding: EdgeInsets.only(left: 5),
                              trailing: IconButton(
                                onPressed: _handleLogOut,
                                icon: const Icon(Icons.logout, color: ColorConstants.white500),
                                tooltip: 'Log out',
                                color: ColorConstants.white500,
                              ),
                              children: [UserProfile(onTap: () => _controller.collapse())],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Text('Chats', style: TextStyle(color: ColorConstants.white500, fontSize: 20.0)),
                                    SizedBox(width: 10.0),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(color: ColorConstants.white500, shape: BoxShape.circle),
                                      constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                                      child: Center(
                                        child: _isChatInProgress
                                            ? IdocItLoadingIndicator(size: 19)
                                            : Text(
                                                (chatsButtons.length + (_isNewChatAdded ? 1 : 0)).toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _isNewChatAdded = true;
                                    });
                                  },
                                  icon: Icon(Icons.add, color: ColorConstants.white500),
                                  color: ColorConstants.white500,
                                ),
                              ],
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return SizeTransition(
                                  sizeFactor: animation,
                                  axisAlignment: -1.0, // animate from top
                                  child: FadeTransition(opacity: animation, child: child),
                                );
                              },
                              child: _isNewChatAdded
                                  ? Padding(
                                      key: const ValueKey('new_chat'),
                                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IdocItTextButton(
                                              contentText: 'New chat',
                                              callback: () async {
                                                if (widget.onItemClick == null) return;
                                                await widget.onItemClick!('', 'New chat');
                                              },
                                              color: ColorConstants.black400,
                                              isSelected: (chatState.chatId ?? '').isEmpty,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _isNewChatAdded = false;
                                              });
                                              if (state.chats.isEmpty || widget.onItemClick == null) return;
                                              widget.onItemClick!(state.chats.first.id, state.chats.first.title);
                                            },
                                            borderRadius: BorderRadius.circular(4),
                                            child: const Padding(
                                              padding: EdgeInsets.all(2),
                                              child: Icon(Icons.delete, size: 24, color: ColorConstants.white500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(key: ValueKey('empty')),
                            ),
                            ...chatsButtons,
                            // UserProfile(),
                          ],
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
