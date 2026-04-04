import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:idocit/common/services/device.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/injection_container.dart';

// ignore: must_be_immutable
class UserProfile extends StatelessWidget {
  Function()? onTap;
  UserProfile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and logout button
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
            const SizedBox(height: 20.0),

            Center(child: Text(locator<DeviceService>().currentBuildBanner())),
          ],
        ),
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
