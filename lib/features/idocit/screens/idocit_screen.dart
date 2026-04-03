import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:flutter/widgets.dart';
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
      builder: (_, authState) {
        return BlocBuilder<ChatBloc, ChatState>(
          buildWhen: (p, c) => p.chatId != c.chatId || p.chatTitle != c.chatTitle,
          builder: (context, chatState) {
            return SafeArea(
              child: SliderDrawer(
                key: _sliderDrawerKey,
                isDraggable: false,
                appBar: SliderAppBar(
                  config: SliderAppBarConfig(
                    title: Text(
                      chatState.chatTitle ?? "New Chat",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.white500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                  onItemClick: (chatId, chatTitle) async {
                    final reset = await locator<ChaReset>().call(NoParams());
                    if (reset.isLeft()) return _sliderDrawerKey.currentState?.closeSlider();
                    final suggestions = await locator<ChatLazyInitSuggestions>().call(NoParams());
                    if (suggestions.isLeft()) return _sliderDrawerKey.currentState?.closeSlider();
                    final history = await locator<GetChatHistory>().call(chatId);
                    final chats = await locator<IdocItLazyInitChats>().call(NoParams());
                    if (history.isLeft() || chats.isLeft()) return _sliderDrawerKey.currentState?.closeSlider();
                    _sliderDrawerKey.currentState?.closeSlider();
                    locator<ChatBloc>().add(SetChatTitle(chatTitle: chatTitle));
                    locator<ChatBloc>().add(SetChatId(chatId: chatId));
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
