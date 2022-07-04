import 'package:flutter/material.dart';
import 'package:mobipad/utils/validator.dart';
import 'package:mobipad/styles/text_styles.dart';

import 'widgets/email_text_field.dart';
import 'widgets/password_text_field.dart';

class SignupFormView extends StatelessWidget {
  const SignupFormView({
    Key? key,
    required this.formKey,
    required this.emailTextContoller,
    required this.passwordTextContoller,
    required this.confirmPasswordTextContoller,
  }) : super(key: key);

  final TextEditingController emailTextContoller;
  final TextEditingController passwordTextContoller;
  final TextEditingController confirmPasswordTextContoller;
  final Key formKey;

  @override
  Widget build(BuildContext context) {
    final emailTextField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Email',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        EmailTextField(
          controller: emailTextContoller,
        ),
      ],
    );

    final passwordTextField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Password',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        PasswordTextField(
          controller: passwordTextContoller,
        ),
      ],
    );

    final confirmPasswordTextField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Confirm Password',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        PasswordTextField(
          controller: confirmPasswordTextContoller,
          validator: (value) {
            if (passwordTextContoller.text != value) {
              return 'Password does not match!';
            }

            return Validator.passwordValidator(value);
          },
        ),
      ],
    );

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          emailTextField,
          const SizedBox(height: 10),
          passwordTextField,
          const SizedBox(height: 10),
          confirmPasswordTextField,
        ],
      ),
    );
  }
}
