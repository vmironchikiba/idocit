import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idocit/common/utils/dialogs.dart';
import 'package:idocit/common/widgets/wrappers/dialog_wrapper.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/idocit/widget/profile_logout_dialog.dart';
import 'package:idocit/features/idocit/widget/profile_tile_item.dart';

class ProfileSettingsDialog extends StatefulWidget {
  static const routeName = '/profile-settings-dialog';

  const ProfileSettingsDialog({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsDialog> createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  bool _isDialogHidden = false;
  bool _isRequestInProgress = false;

  Future<void> _onLogOutHandler() async {
    if (_isRequestInProgress) {
      return;
    }

    setState(() {
      _isRequestInProgress = true;
      _isDialogHidden = true;
    });

    final isCompleted = await idocitShowDialog(const ProfileLogOutDialog(), context: context);

    if (isCompleted == true) {
      return;
    }

    setState(() {
      _isRequestInProgress = false;
      _isDialogHidden = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DialogWrapper(
      contentIndent: 0.0,
      padding: const EdgeInsets.all(24.0),
      isHidden: _isDialogHidden,
      withCloseButton: false,
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (prev, current) {
          return prev.userData != current.userData;
        },
        builder: (_, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileTileItem(iconSrc: ImageConstants.icProfileLogout, title: 'Logout', onTap: _onLogOutHandler),
            ],
          );
        },
      ),
    );
  }
}
