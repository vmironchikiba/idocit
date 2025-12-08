import 'package:flutter/material.dart';

enum Role { user, assistant, unknown }

extension StringRole on Role {
  String asString() {
    switch (this) {
      case Role.user:
        return 'user';
      case Role.assistant:
        return 'assistant';
      case Role.unknown:
        return 'unknown';
    }
  }
}

extension RoleString on String {
  Role toRole() {
    switch (this) {
      case 'user':
        return Role.user;
      case 'assistant':
        return Role.assistant;
    }

    return Role.unknown;
  }
}
