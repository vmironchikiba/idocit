import 'package:flutter/material.dart';
import 'package:idocit/common/models/service/usecase.dart';
import 'package:idocit/common/widgets/buttons/icon_button.dart';
import 'package:idocit/constants/colors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/features/authentication/domain/bloc/auth_bloc.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_out.dart';
import 'package:idocit/injection_container.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  _handleLogOut() {
    locator<AuthSignOut>().call(NoParams());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
          child: Row(
            children: [
              Icon(icon, color: ColorConstants.white500),
              const SizedBox(width: 4.0),
              Expanded(child: Text(value, style: Theme.of(context).textTheme.bodyLarge)),
            ],
          ),
        ),
      ],
    );
  }
}
