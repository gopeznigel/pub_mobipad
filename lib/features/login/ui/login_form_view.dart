import 'package:flutter/material.dart';
import 'package:mobipad/styles/text_styles.dart';

import 'widgets/email_text_field.dart';
import 'widgets/password_text_field.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView({
    Key? key,
    required this.formKey,
    required this.emailTextContoller,
    required this.passwordTextContoller,
    required this.loading,
  }) : super(key: key);

  final TextEditingController emailTextContoller;
  final TextEditingController passwordTextContoller;
  final Key formKey;
  final bool loading;

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
          enabled: !loading,
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
          enabled: !loading,
          controller: passwordTextContoller,
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
        ],
      ),
    );
  }
}
