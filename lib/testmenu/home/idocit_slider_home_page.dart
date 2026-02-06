import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/chat/domain/bloc/chat_bloc.dart';
import 'package:idocit/features/chat/domain/usecases/chat_history.dart';
import 'package:idocit/features/chat/domain/usecases/chat_lazy_init_suggestions.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
import 'package:idocit/injection_container.dart';
import 'package:idocit/testmenu/home/widget/idocit_chat.dart';
import 'package:idocit/testmenu/home/widget/slider_menu.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class IdocItSliderHomePage extends StatefulWidget {
  const IdocItSliderHomePage({super.key});
  static const routeName = '/idocit';

  @override
  State<IdocItSliderHomePage> createState() => _IdocItSliderHomePageState();
}

class _IdocItSliderHomePageState extends State<IdocItSliderHomePage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey = GlobalKey<SliderDrawerState>();

  bool _isRequestInProgress = false;

  late String chatTitle;
  late String chatId;

  @override
  void initState() {
    chatTitle = "New Chat";
    chatId = "";
    super.initState();
    _isRequestInProgress = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, authState) {
        return SafeArea(
          child: SliderDrawer(
            key: _sliderDrawerKey,
            appBar: SliderAppBar(
              config: SliderAppBarConfig(
                title: Text(
                  chatTitle,
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
            sliderOpenSize: 300,
            slider: SliderMenu(
              onItemClick: (chatId, chatTitle) {
                locator<ChatLazyInitSuggestions>().call(NoParams());
                locator<ChatBloc>().stream.listen(((state) {
                  // _scrollToBottom();
                }));
                locator<GetChatHistory>().call(chatId).then((result) {
                  if (result.isRight()) {
                    // _scrollToBottom();
                  }
                });
                _sliderDrawerKey.currentState?.closeSlider();
                setState(() {
                  this.chatTitle = chatTitle;
                  this.chatId = chatId;
                });
              },
            ),
            child: IdocItChat(chatId: chatId, chatTitle: chatTitle),
          ),
        );
      },
    );
  }
}
