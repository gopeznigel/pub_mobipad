import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class Validator {
  static String emailValidator(String value) =>
      EmailValidator.validate(value) ? null : 'Invalid email address';

  static String passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Invalid password';
    }
    return null;
  }

  static bool formValidated(GlobalKey formKey) {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
