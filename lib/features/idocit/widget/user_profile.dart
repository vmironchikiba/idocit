import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/tts/screens/tts_settings_screen_s.dart';
import 'package:idocit/injection_container.dart';

// ignore: must_be_immutable
class UserProfile extends StatelessWidget {
  Function()? onTap;
  UserProfile({super.key, this.onTap});

  Future<void> _handleTtsSettings(BuildContext context) async {
    Navigator.push(context, CupertinoPageRoute(builder: (_) => TtsSettingsScreen()));
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
          GestureDetector(
            onTap: onTap,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profile Information', style: TextStyle(color: ColorConstants.white500, fontSize: 18)),
                const SizedBox(height: 8.0),

                // User Name Field
                _buildTextField(
                  context: context,
                  value: locator<AuthBloc>().state.userData?.username ?? '',
                  icon: Icons.person,
                ),
                const SizedBox(height: 4.0),

                // Email Field
                _buildTextField(
                  context: context,
                  value: locator<AuthBloc>().state.userData?.email ?? '',
                  icon: Icons.email,
                ),
                const SizedBox(height: 4.0),

                // Role Field
                _buildTextField(
                  context: context,
                  value: locator<AuthBloc>().state.userData?.role ?? '',
                  icon: Icons.verified_user,
                ),
                const SizedBox(height: 4.0),

                // Tenant Field
                _buildTextField(
                  context: context,
                  value: locator<AuthBloc>().state.userData?.tenant ?? '',
                  icon: Icons.home,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
            child: InkWell(
              onTap: () => _handleTtsSettings(context),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: SvgPicture.asset(
                        ImageConstants.microphoneSvg,
                        width: 22.0,
                        height: 22.0,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        // color: ColorConstants.white500,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(width: 10.0), // Отступ
                    ),
                    TextSpan(text: 'TTS Settings'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(child: Text(locator<DeviceService>().currentBuildBanner())),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required BuildContext context, required String value, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 2.0),
          child: Row(
            children: [
              Icon(icon, color: ColorConstants.white500),
              const SizedBox(width: 12.0),
              Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyMedium)),
            ],
          ),
        ),
      ],
    );
  }
}
