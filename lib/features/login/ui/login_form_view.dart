import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/login_text_fields.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView(
      {this.formKey,
      this.emailTextContoller,
      this.passwordTextContoller,
      this.loading});

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
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'Email',
            style: TextStyle(
                color: Colors.white,
                fontSize: 45.sp,
                fontWeight: FontWeight.w600),
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
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'Password',
            style: TextStyle(
                color: Colors.white,
                fontSize: 45.sp,
                fontWeight: FontWeight.w600),
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
          SizedBox(height: 20.h),
          passwordTextField,
        ],
      ),
    );
  }
}
