import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/validator.dart';
import 'widgets/login_text_fields.dart';

class SignupFormView extends StatelessWidget {
  const SignupFormView(
      {this.formKey,
      this.emailTextContoller,
      this.passwordTextContoller,
      this.confirmPasswordTextContoller});

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
          controller: passwordTextContoller,
        ),
      ],
    );

    final confirmPasswordTextField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'Confirm Password',
            style: TextStyle(
                color: Colors.white,
                fontSize: 45.sp,
                fontWeight: FontWeight.w600),
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
          SizedBox(height: 20.h),
          passwordTextField,
          SizedBox(height: 20.h),
          confirmPasswordTextField,
        ],
      ),
    );
  }
}
