// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/services/logger.dart';
import 'package:idocit/common/widgets/wrappers/content_wrapper.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/components/domain/blocs/components_bloc.dart';
import 'package:idocit/features/components/domain/usecases/components_init_components.dart';
import 'package:idocit/features/idocit/domain/usecases/idocit_init.dart';
import 'package:idocit/injection_container.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';
  static const routeTabNumber = 0;
  static const routeTabName = 'Home';

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isRequestInProgress = false;
  // bool _isRefreshInProgress = false;

  @override
  void initState() {
    super.initState();
    _isRequestInProgress = true;
    locator<ComponentsInit>().call(NoParams()).then((onValue) {
      setState(() {
        _isRequestInProgress = false;
      });
    });
  }

  Future<void> _onChatClickHandler(String id) async {
    LoggerService.logDebug(id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentsBloc, ComponentsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SvgPicture.asset(ImageConstants.igIdocIt, height: 56, width: 56)],
            ),
          ),
          body: ContentWrapper(
            child: Column(
              children: state.componentConfig == null
                  ? []
                  : state.componentConfig!.preferredLanguages.map((langCode) {
                      return Text(langCode);
                    }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
