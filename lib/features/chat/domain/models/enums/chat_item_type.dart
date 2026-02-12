import 'package:flutter/material.dart';
import 'package:idocit/constants/colors.dart';

enum ChatItemType { userMessage, systemMessage, docName }

extension ChatItemTypeExtended on ChatItemType {
  Color color() {
    switch (this) {
      case ChatItemType.userMessage:
        return ColorConstants.green600;
      case ChatItemType.systemMessage:
        return ColorConstants.blue500;
      case ChatItemType.docName:
        return ColorConstants.red400;
    }
  }

  Decoration? decoration() {
    switch (this) {
      case ChatItemType.userMessage:
        return null;
      case ChatItemType.systemMessage:
        return null;
      case ChatItemType.docName:
        return BoxDecoration(
          border: Border.all(color: color(), width: 1),
          borderRadius: BorderRadius.circular(8),
        );
    }
  }
}
