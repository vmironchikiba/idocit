import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/common/utils/dialogs.dart';
import 'package:idocit/common/widgets/buttons/icon_button.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/idocit/widget/profile_logout_dialog.dart';
import 'package:idocit/features/stt/screens/stt_settings_creen.dart';
import 'package:idocit/features/tts/screens/tts_settings_screen_s.dart';
import 'package:idocit/injection_container.dart';

class UserProfile extends StatefulWidget {
  UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isDialogHidden = false;
  bool _isRequestInProgress = false;

  Future<void> _handleLogOut() async {
    if (_isRequestInProgress) {
      return;
    }

    setState(() {
      _isRequestInProgress = true;
    });
    final isCompleted = await idocitShowDialog(const ProfileLogOutDialog(), context: context);
    if (isCompleted == true) {
      return;
    }

    setState(() {
      _isRequestInProgress = false;
      _isDialogHidden = false;
    });

    setState(() {
      _isRequestInProgress = false;
    });
  }

  Future<void> _handleTtsSettings() async {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => SttSettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and logout button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profile Information', style: TextStyle(color: ColorConstants.white500, fontSize: 18)),
              IconButton(
                onPressed: _handleLogOut,
                icon: const Icon(Icons.logout, color: ColorConstants.white500),
                tooltip: 'Log out',
                color: ColorConstants.white500,
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // User Name Field
          _buildTextField(
            context: context,
            value: locator<AuthBloc>().state.userData?.username ?? '',
            icon: Icons.person,
          ),
          const SizedBox(height: 4.0),

          // Email Field
          _buildTextField(context: context, value: locator<AuthBloc>().state.userData?.email ?? '', icon: Icons.email),
          const SizedBox(height: 4.0),

          // Role Field
          _buildTextField(
            context: context,
            value: locator<AuthBloc>().state.userData?.role ?? '',
            icon: Icons.verified_user,
          ),
          const SizedBox(height: 20.0),

          // Role Field
          Row(
            children: [
              IdocItImageButton(
                image: SvgPicture.asset(
                  ImageConstants.microphoneSvg,
                  width: 22.0,
                  height: 22.0,
                  color: ColorConstants.white500,
                ),
                callback: _handleTtsSettings,
              ),
              Text('TTS Settings'),
            ],
          ),
          SizedBox(height: 10.0),
          Text(locator<DeviceService>().currentBuildBanner()),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    // required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 2.0),
          child: Row(
            children: [
              Icon(icon, color: ColorConstants.white500),
              const SizedBox(width: 12.0),
              Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyLarge)),
            ],
          ),
        ),
      ],
    );
  }
}
