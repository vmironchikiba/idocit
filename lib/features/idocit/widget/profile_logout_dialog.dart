import 'package:flutter/material.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/widgets/dialogs/alert_dialog.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_out.dart';
import 'package:idocit/injection_container.dart';

class ProfileLogOutDialog extends StatefulWidget {
  const ProfileLogOutDialog({Key? key}) : super(key: key);

  @override
  State<ProfileLogOutDialog> createState() => _ProfileLogOutDialogState();
}

class _ProfileLogOutDialogState extends State<ProfileLogOutDialog> {
  bool _isRequestInProgress = false;

  void _onGoBackHandler() {
    Navigator.of(context).pop();
  }

  Future<void> _onLogOutHandler() async {
    if (_isRequestInProgress) {
      return;
    }

    if (mounted) {
      setState(() {
        _isRequestInProgress = true;
      });
    }

    await locator<AuthSignOut>().call(NoParams());

    if (mounted) {
      setState(() {
        _isRequestInProgress = false;
      });
    }
    // Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return IdocItAlertDialog(
      label: 'Logout',
      description: 'Are you sure you want to logout from IdocIt?',
      cancelButtonText: 'Cancel',
      actionButtonText: 'Logout',
      cancelButtonCallback: _onGoBackHandler,
      actionButtonCallback: _onLogOutHandler,
      isBlocked: _isRequestInProgress,
    );
  }
}
