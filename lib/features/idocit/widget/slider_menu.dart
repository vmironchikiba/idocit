import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/widgets/buttons/text_button.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/idocit/domain/blocs/idocit/idocit_bloc.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_lazy_init_chats.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.black300,
      padding: const EdgeInsets.only(top: 30, left: 4.0, right: 4.0),
      child: BlocBuilder<IdocItBloc, IdocItState>(
        builder: (context, state) {
          final chatsButtons = state.chats
              .map(
                (chat) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: IdocItTextButton(
                    contentText: chat.title,
                    callback: () async {
                      widget.onItemClick!(chat.id, chat.title);
                      // await _onChatClickHandler(chat.id);
                    },
                    color: ColorConstants.black400,
                  ),
                ),
              )
              .toList();
          return Material(
            // Добавлен Material виджет как предок для ListTile
            color: ColorConstants.black300,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: IdocItTextButton(
                    contentText: 'New chat',
                    callback: () async {
                      await widget.onItemClick!('', 'New chat');
                    },
                    color: ColorConstants.black400,
                  ),
                ),
                ...chatsButtons,
              ],
            ),
          );
        },
      ),
    );
  }
}
