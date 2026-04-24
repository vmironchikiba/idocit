import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/blocs/core_bloc.dart';
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
  final Function()? onClose;

  const SliderMenu({super.key, this.onItemClick, this.onClose});

  @override
  State<SliderMenu> createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  bool _isRequestInProgress = false;
  bool _isChatInProgress = false;
  String? _isChatInProgressId;
  bool _isNewChatAdded = false;
  bool _profileOpened = false;
  final ExpansibleController _expansibleController = ExpansibleController();
  final ScrollController _scrollController = ScrollController();
  bool _isFullVisible = true;

  void _checkScrollNeeded() {
    if (_scrollController.hasClients) {
      final maxExtent = _scrollController.position.maxScrollExtent;
      setState(() {
        _isFullVisible = maxExtent == 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isRequestInProgress = true;
    _isChatInProgress = false;
    _isNewChatAdded = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollNeeded();
    });
    locator<IdocItLazyInitChats>().call(NoParams()).then((chats) {
      if (!mounted) return;
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      chats.fold(
        (failure) => scaffoldMessenger.showSnackBar(
          SnackBar(key: UniqueKey(), content: Text(failure.message), duration: Duration(seconds: 5)),
        ),
        (_) => null,
      );
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
    _expansibleController.addListener(() {
      _checkScrollNeeded();
    });
  }

  Future<void> _onRefresh(BuildContext context) async {
    setState(() {
      _isRequestInProgress = true;
    });
    final chats = await locator<IdocItLazyInitChats>().call(NoParams());
    chats.fold((failure) {}, (_) => null);

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
    return Scaffold(
      body: Container(
        color: ColorConstants.black300,
        padding: const EdgeInsets.only(top: 5, left: 4.0),
        child: BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (p, c) => p.chatId != c.chatId,
          builder: (chatContext, chatState) {
            return BlocBuilder<IdocItBloc, IdocItState>(
              buildWhen: (previous, current) => previous.chats.hashCode != current.chats.hashCode,
              builder: (iDocItContext, iDocItState) {
                final chatsButtons = iDocItState.chats.map((chat) {
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
                                _expansibleController.collapse();
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
                                    _expansibleController.collapse();
                                    setState(() {
                                      _isChatInProgress = true;
                                      _isChatInProgressId = chat.id;
                                    });

                                    final delete = await locator<IdocItDeleteChat>().call(chat.id);
                                    delete.fold(
                                      (failure) => ScaffoldMessenger.of(iDocItContext).showSnackBar(
                                        SnackBar(
                                          key: UniqueKey(),
                                          content: Text(failure.message),
                                          duration: Duration(seconds: 5),
                                        ),
                                      ),
                                      (_) => null,
                                    );

                                    final chats = await locator<IdocItLazyInitChats>().call(NoParams());
                                    chats.fold(
                                      (failure) => ScaffoldMessenger.of(iDocItContext).showSnackBar(
                                        SnackBar(
                                          key: UniqueKey(),
                                          content: Text(failure.message),
                                          duration: Duration(seconds: 5),
                                        ),
                                      ),
                                      (_) => null,
                                    );

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
                    onRefresh: () => _onRefresh(iDocItContext),
                    child: _isRequestInProgress
                        ? Center(child: IdocItLoadingIndicator())
                        : ListView(
                            controller: _scrollController,
                            children: <Widget>[
                              ExpansionTile(
                                controller: _expansibleController,
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
                                children: [
                                  BlocBuilder<CoreBloc, CoreState>(
                                    buildWhen: (p, c) => p.screenLock != c.screenLock,
                                    builder: (coreContext, coreState) {
                                      return UserProfile(
                                        onTap: () {
                                          if (widget.onClose != null) {
                                            widget.onClose!();
                                          }
                                          _expansibleController.collapse();
                                        },
                                        screenLock: coreState.screenLock,
                                      );
                                    },
                                  ),
                                ],
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
                                        decoration: BoxDecoration(
                                          color: ColorConstants.white500,
                                          shape: BoxShape.circle,
                                        ),
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
                                                  _expansibleController.collapse();
                                                  if (widget.onItemClick == null) return;
                                                  await widget.onItemClick!('', 'New chat');
                                                },
                                                color: ColorConstants.black400,
                                                isSelected: (chatState.chatId ?? '').isEmpty,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                _expansibleController.collapse();
                                                setState(() {
                                                  _isNewChatAdded = false;
                                                });
                                                if (iDocItState.chats.isEmpty || widget.onItemClick == null) return;
                                                widget.onItemClick!(
                                                  iDocItState.chats.first.id,
                                                  iDocItState.chats.first.title,
                                                );
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
      ),
      floatingActionButton: _isFullVisible
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.small(
                  heroTag: "scrlUp",
                  onPressed: () => _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  tooltip: 'Прокрутка вверх',
                  backgroundColor: ColorConstants.loading.withValues(alpha: 0.5),
                  child: const Icon(Icons.arrow_upward, color: ColorConstants.black350),
                ),
                SizedBox(height: 10),
                FloatingActionButton.small(
                  heroTag: "scrlDown",
                  onPressed: () => _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                  tooltip: 'Прокрутка вниз',
                  backgroundColor: ColorConstants.loading.withValues(alpha: 0.5),
                  child: const Icon(Icons.arrow_downward, color: ColorConstants.black350),
                ),
              ],
            )
          : null,
    );
  }
}
