import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marquee_plus/flutter_marquee_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/usecases/chat_history.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';
import 'package:idocit/features/chat/domain/usecases/chat_reset.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
import 'package:idocit/injection_container.dart';
import 'package:idocit/features/idocit/widget/idocit_chat.dart';
import 'package:idocit/features/idocit/widget/slider_menu.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class IdocItScreen extends StatefulWidget {
  const IdocItScreen({super.key});
  static const routeName = '/home';

  @override
  State<IdocItScreen> createState() => _IdocItScreenState();
}

class _IdocItScreenState extends State<IdocItScreen> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();

  bool _isRequestInProgress = false;

  @override
  void initState() {
    super.initState();
    _isRequestInProgress = true;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (authContext, authState) {
        return BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (p, c) => p.chatId != c.chatId || p.chatTitle != c.chatTitle,
          builder: (chatContext, chatState) {
            return SafeArea(
              child: SliderDrawer(
                key: _sliderDrawerKey,
                isDraggable: false,
                appBar: SliderAppBar(
                  config: SliderAppBarConfig(
                    title: Padding(
                      padding: EdgeInsetsGeometry.only(top: 15),
                      child: MarqueePlus(
                        text: chatState.chatTitle ?? "New Chat",
                        scrollAxis: Axis.horizontal,
                        velocity: 50.0,
                        gap: 20,
                        pauseAfterRound: Duration(seconds: 1),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          inherit: false,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: ColorConstants.white500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Text(
                    //   chatState.chatTitle ?? "New Chat",
                    //   textAlign: TextAlign.center,
                    //   style: const TextStyle(
                    //     inherit: false,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.w500,
                    //     fontStyle: FontStyle.normal,
                    //     color: ColorConstants.white500,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    backgroundColor: ColorConstants.black300,
                    drawerIconColor: ColorConstants.white500,
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(ImageConstants.igIdocIt, height: 28, width: 28),
                    ),
                  ),
                ),
                sliderOpenSize: width - 50,
                slider: SliderMenu(
                  onClose: () => _sliderDrawerKey.currentState?.closeSlider(),
                  onItemClick: (chatId, chatTitle) async {
                    _sliderDrawerKey.currentState?.closeSlider();
                    final scaffoldMessenger = ScaffoldMessenger.of(chatContext);
                    final reset = await locator<ChatReset>().call(NoParams());
                    reset.fold(
                      (failure) => scaffoldMessenger.showSnackBar(
                        SnackBar(key: UniqueKey(), content: Text(failure.message), duration: Duration(seconds: 5)),
                      ),
                      (_) async {
                        FocusScope.of(chatContext).unfocus();
                        final suggestions = await locator<ChatLazyInitSuggestions>().call(NoParams());
                        suggestions.fold(
                          (failure) => scaffoldMessenger.showSnackBar(
                            SnackBar(content: Text(failure.message), duration: Duration(seconds: 5)),
                          ),
                          (_) async {
                            final history = await locator<GetChatHistory>().call(chatId);
                            history.fold(
                              (failure) => scaffoldMessenger.showSnackBar(
                                SnackBar(
                                  key: UniqueKey(),
                                  content: Text(failure.message),
                                  duration: Duration(seconds: 5),
                                ),
                              ),
                              (_) async {
                                final chats = await locator<IdocItLazyInitChats>().call(NoParams());
                                chats.fold(
                                  (failure) => scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      key: UniqueKey(),
                                      content: Text(failure.message),
                                      duration: Duration(seconds: 5),
                                    ),
                                  ),
                                  (_) {
                                    locator<ChatBloc>().add(SetChatTitle(chatTitle: chatTitle));
                                    locator<ChatBloc>().add(SetChatId(chatId: chatId));
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                child: IdocItChat(chatId: chatState.chatId ?? '' /*, chatTitle: chatTitle*/),
              ),
            );
          },
        );
      },
    );
  }
}
