import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:idocit/common/models/in_app_toast_data.dart';
import 'package:idocit/common/models/service/failure.dart';
import 'package:idocit/common/usecases/core_update_in_app_toast.dart';
import 'package:idocit/common/widgets/buttons/text_button.dart';
import 'package:idocit/common/widgets/input_fields/input_validators.dart';
import 'package:idocit/common/widgets/input_fields/text_input_field.dart';
import 'package:idocit/common/widgets/texts.dart';
import 'package:idocit/common/widgets/wrappers/content_wrapper.dart';
import 'package:idocit/constants/errors.dart';
import 'package:idocit/constants/image.dart';
import 'package:idocit/constants/sizes.dart';
import 'package:idocit/constants/style.dart';
import 'package:idocit/features/authentication/domain/models/login_data.dart';
import 'package:idocit/features/authentication/domain/usecases/sign/auth_sign_in.dart';
import 'package:idocit/injection_container.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/sig-in';

  final bool isFromResetDialog;

  const LoginScreen({Key? key, this.isFromResetDialog = false}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController(text: 'kaz_audit');
  final _passwordController = TextEditingController(text: 'kaz_aud1t');

  final _userFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String? _errorUserMessage;
  String? _errorPasswordMessage;

  bool _showPasswordSuccessMessage = false;
  bool _isButtonEnabled = false;
  bool _isRequestInProgress = false;
  bool _isConfirmDialogOpened = false;

  @override
  void initState() {
    super.initState();
    _userController.addListener(_checkButtonDisability);
    _passwordController.addListener(_checkButtonDisability);

    if (widget.isFromResetDialog) {
      locator<CoreUpdateInAppToast>().call(null);
      Future.delayed(const Duration(seconds: 1)).then((_) {
        if (mounted) {
          setState(() {
            _showPasswordSuccessMessage = true;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _userController.removeListener(_checkButtonDisability);
    _passwordController.removeListener(_checkButtonDisability);
    super.dispose();
  }

  void _checkButtonDisability() {
    final isEnabled =
        _userController.value.text.isNotEmpty &&
        _passwordController.value.text.isNotEmpty &&
        UserValidator().call(_userController.value.text) == null &&
        PasswordValidator().call(_passwordController.value.text) == null;

    if (_isButtonEnabled != isEnabled) {
      setState(() {
        _isButtonEnabled = isEnabled;
      });
    }
  }

  void _clearUserErrorMessage({bool isHardClear = false}) {
    if (_errorUserMessage != null && (_userFocusNode.hasFocus || isHardClear)) {
      setState(() {
        _errorUserMessage = null;
      });
    }
  }

  void _clearPasswordErrorMessage({bool isHardClear = false}) {
    if (_errorPasswordMessage != null && (_passwordFocusNode.hasFocus || isHardClear)) {
      setState(() {
        _errorPasswordMessage = null;
      });
    }
  }

  bool _isValidUser() {
    _errorUserMessage = UserValidator().call(_userController.value.text);
    if (_errorUserMessage != null) {
      setState(() {
        _isRequestInProgress = false;
      });
      return false;
    }

    return true;
  }

  bool _isValidPassword() {
    _errorPasswordMessage = PasswordValidator().call(_passwordController.value.text);
    if (_errorPasswordMessage != null) {
      setState(() {
        _isRequestInProgress = false;
      });
      return false;
    }

    return true;
  }

  void _resetErrorMessage() {
    if (_errorUserMessage != null || _errorPasswordMessage != null) {
      setState(() {
        _errorUserMessage = null;
        _errorPasswordMessage = null;
      });
    }

    locator<CoreUpdateInAppToast>().call(null);
  }

  Future<void> _onOpenConfirmCodeDialogHandler() async {
    if (_isConfirmDialogOpened) {
      return;
    }

    setState(() {
      _isConfirmDialogOpened = true;
    });

    // await ConfirmIdentityDialog.onSendConfirmationCodeHandler(_emailController.value.text);

    // final verificationCode = await RegisterUserDataScreen.onOpenConfirmDialogHandler(
    //   _emailController.value.text,
    //   context,
    //   loginData: LoginData(email: _emailController.value.text, password: _passwordController.value.text),
    // );

    // if (verificationCode is String) {
    //   Navigator.of(context).pushNamed(RegisterPersonalDataScreen.routeName, arguments: true);
    // }

    setState(() {
      _isConfirmDialogOpened = false;
    });
  }

  Future<void> _onLogInHandler(BuildContext context) async {
    if (_isRequestInProgress) {
      return;
    }

    setState(() {
      _isRequestInProgress = true;
    });

    FocusScope.of(context).unfocus();
    _resetErrorMessage();
    if (!_isValidUser() || !_isValidPassword()) return;

    final response = await locator<AuthSignIn>().call(
      LoginData(email: _userController.value.text, password: _passwordController.value.text),
    );

    response.fold((failure) async {
      if (failure is AuthFailure && failure.type == AuthErrorType.needConfirmUser) {
        await _onOpenConfirmCodeDialogHandler();
        return;
      }

      // if (failure is AuthFailure && failure.type == AuthErrorType.needConfirmPersonalData) {
      //   Navigator.of(context).pushNamed(RegisterPersonalDataScreen.routeName, arguments: true);
      //   return;
      // }

      // if (failure is AuthFailure && failure.type == AuthErrorType.needConfirmHome) {
      //   Navigator.of(context).pushNamed(RegisterAccountTypeScreen.routeName, arguments: true);
      //   return;
      // }

      if (_showPasswordSuccessMessage) {
        setState(() {
          _showPasswordSuccessMessage = false;
        });
        await Future.delayed(StyleConstants.defaultAnimationDuration);
      }

      locator<CoreUpdateInAppToast>().call(
        InAppToastData.createFromFailure(key: const ValueKey(LoginScreen.routeName), failure: failure),
      );
    }, (result) => null);

    setState(() {
      _isRequestInProgress = false;
    });
  }

  // void _onCreateAccountHandler(BuildContext context) {
  //   Navigator.of(context).pushReplacementNamed(RegisterUserDataScreen.routeName);
  // }

  // void _onResetPasswordHandler(BuildContext context) {
  //   Navigator.of(context).pushNamed(ResetPasswordRequestLinkScreen.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentWrapper(
        child: ContentWrapper(
          padding: EdgeInsets.only(
            left: ContentWrapper.defaultPadding.left,
            right: ContentWrapper.defaultPadding.right,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  SvgPicture.asset(ImageConstants.igIdocIt, height: 112, width: 112),
                  const SizedBox(height: 12.0),
                  IdocItRichText(
                    span: TextSpan(
                      children: const [
                        TextSpan(text: 'Welcome to '),
                        TextSpan(
                          text: 'IdocIt.',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConstants.isSmallDevice() ? 24.0 : 40.0),
                  IdocItTextInputField(
                    controller: _userController,
                    focusNode: _userFocusNode,
                    hintText: 'Username',
                    errorText: _errorUserMessage,
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    onChanged: (_) {
                      _clearUserErrorMessage();
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    onFocusChange: (value) {
                      if (!value) {
                        _isValidUser();
                      }
                    },
                    onClear: () {
                      _clearUserErrorMessage(isHardClear: true);
                    },
                  ),
                  const SizedBox(height: 12.0),
                  IdocItTextInputField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    hintText: 'Password',
                    errorText: _errorPasswordMessage,
                    isProtectedField: true,
                    onChanged: (_) {
                      _clearPasswordErrorMessage();
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    onFocusChange: (value) {
                      if (!value) {
                        _isValidPassword();
                      }
                    },
                    onClear: () {
                      _clearPasswordErrorMessage(isHardClear: true);
                    },
                  ),
                  const SizedBox(height: 12.0),
                ],
              ),
              const SizedBox(height: 24.0),
              IdocItTextButton(
                contentText: 'Log In',
                callback: () => _onLogInHandler(context),
                isBlocked: !_isButtonEnabled,
                withProgress: _isRequestInProgress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
