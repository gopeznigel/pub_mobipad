import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class Validator {
  static String? emailValidator(String? value) {
    if (value == null) {
      return null;
    }

    return EmailValidator.validate(value) ? null : 'Invalid email address';
  }

  static String? passwordValidator(String? value) {
    if (value == null) {
      return null;
    }

    return value.isEmpty ? 'Invalid password' : null;
  }

  static bool formValidated(GlobalKey<FormState> formKey) {
    final FormState form = formKey.currentState!;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
