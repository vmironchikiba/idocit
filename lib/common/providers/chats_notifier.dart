import 'package:flutter/material.dart';

class ChatsNotifier extends ChangeNotifier {
  ChatsEvent? event;
  void send(ChatsEvent e) {
    event = e;
    notifyListeners();
  }
}

enum ChatsEvent { close, open }
