import 'package:flutter/services.dart';

abstract class Validator<Params> {
  String? call(Params inputValue);
}

abstract class AsyncValidator<Params> {
  Future<String?> call(Params inputValue);
}

class EmailValidator extends Validator<String> {
  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (inputValue.length < 4) {
      return 'Invalid username';
    }

    return null;
  }
}

class PasswordValidator extends Validator<String> {
  final int minSymbols;
  final int maxSymbols;

  PasswordValidator({this.minSymbols = 6, this.maxSymbols = 30});

  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (inputValue.length < minSymbols) {
      return 'Password should have at least $minSymbols chars';
    }

    if (inputValue.length > maxSymbols) {
      return 'Password should have no more than $maxSymbols chars';
    }

    return null;
  }
}

class PasswordConfirmValidator extends Validator<String> {
  final String compareWith;

  PasswordConfirmValidator(this.compareWith);

  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (compareWith.isEmpty) {
      return null;
    }

    if (compareWith.trim() != inputValue.trim()) {
      return 'Passwords are not equal';
    }

    return null;
  }
}

class NameValidator extends Validator<String> {
  final uniqueNameFormat = RegExp(r'[a-zA-Z]');

  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (!uniqueNameFormat.hasMatch(inputValue)) {
      return 'Name should have only letters';
    }

    return null;
  }
}

class VerificationCodeValidator extends Validator<String> {
  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (inputValue.length != 6) {
      return 'Verification code is not valid';
    }

    return null;
  }
}

class JoulesAmmountValidator extends Validator<String> {
  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }
    final joules = int.tryParse(inputValue);
    if (joules == null || joules <= 0) {
      return 'Ammount of joules is not valid';
    }
    return null;
  }
}

class ReferralCodeValidator extends Validator<String> {
  final int maxSymbols;
  static const numberOfSymbols = 6;

  ReferralCodeValidator({this.maxSymbols = numberOfSymbols});

  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (inputValue.length != maxSymbols) {
      return 'Referral code is not valid';
    }

    return null;
  }
}

class ProviderNameValidator extends Validator<String> {
  final uniqueProviderFormat = RegExp(r'[a-zA-Z]');

  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (!uniqueProviderFormat.hasMatch(inputValue)) {
      return 'Provider should have only letters';
    }

    return null;
  }
}

class WebsiteValidator extends Validator<String> {
  final uniqueProviderFormat = RegExp(r'[a-zA-Z]');

  @override
  String? call(String? inputValue) {
    if (inputValue == null || inputValue.isEmpty) {
      return null;
    }

    if (!uniqueProviderFormat.hasMatch(inputValue)) {
      return 'Link should have only letters';
    }

    return null;
  }
}

class ReplaceCommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.replaceAll(',', '.'), selection: newValue.selection);
  }
}
