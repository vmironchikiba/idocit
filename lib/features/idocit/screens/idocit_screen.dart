// import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/widgets/buttons/text_button.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/common/widgets/wrappers/content_wrapper.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_out.dart';
import 'package:idocit/features/chat/domain/usecases/chat_reset.dart';
import 'package:idocit/features/chat/screens/chat_screen.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_reset.dart';
import 'package:idocit/injection_container.dart';

class IdocItScreen extends StatefulWidget {
  static const routeName = '/idocit';
  static const routeTabNumber = 0;
  static const routeTabName = 'Home';

  const IdocItScreen({super.key});

  @override
  State<IdocItScreen> createState() => _IdocItScreenState();
}

class _IdocItScreenState extends State<IdocItScreen> with AutomaticKeepAliveClientMixin<IdocItScreen> {
  bool _isRequestInProgress = false;
  // bool _isRefreshInProgress = false;

  @override
  void initState() {
    super.initState();
    _isRequestInProgress = true;
    locator<IdocItLazyInitChats>().call(NoParams()).then((onValue) {
      setState(() {
        _isRequestInProgress = false;
      });
    });
  }

  Future<void> _onChatClickHandler(String id) async {
    LoggerService.logDebug(id);
    // Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(chatId: id)));

    await Navigator.push(context, CupertinoPageRoute(builder: (_) => ChatScreen(chatId: id)));
    await locator<ChaReset>().call(NoParams());

    // Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        final result = await locator<AuthSignOut>().call(NoParams());
        if (result.isRight()) {
          await locator<IdocItReset>().call(NoParams());
          await locator<AuthSignOut>.call();
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (_, authState) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset(ImageConstants.igIdocIt, height: 56, width: 56)],
              ),
            ),
            body: BlocBuilder<IdocItBloc, IdocItState>(
              builder: (context, state) {
                final chatsButtons = state.chats
                    .map(
                      (chat) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: IdocItTextButton(
                          contentText: chat.title,
                          callback: () async {
                            await _onChatClickHandler(chat.id);
                          },
                          color: ColorConstants.black400,
                        ),
                      ),
                    )
                    .toList();
                final chatPreviewSvg = Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(ImageConstants.chatPreviewPng),
                    // SvgPicture.asset(ImageConstants.chatPreviewSvg),
                  ],
                );
                return SingleChildScrollView(
                  child: ContentWrapper(
                    child: Column(
                      children: [
                        chatPreviewSvg,
                        SizedBox(height: 10),
                        IdocItText(text: 'User name: ${authState.userData?.username ?? 'No username'}'),
                        IdocItText(text: 'Email: ${authState.userData?.email ?? 'No email'}'),
                        IdocItText(text: 'Role: ${authState.userData?.role ?? 'No role'}'),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: IdocItTextButton(
                            contentText: 'New chat',
                            callback: () async {
                              await _onChatClickHandler('');
                            },
                            color: ColorConstants.black400,
                          ),
                        ),

                        ...chatsButtons,
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
