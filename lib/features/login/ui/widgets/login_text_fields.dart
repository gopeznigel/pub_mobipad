import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobipad/vars/colors.dart';

import '../../../../utils/validator.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({Key key, this.controller, this.enabled}) : super(key: key);

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: Validator.emailValidator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 40.w),
        filled: true,
        fillColor: Colors.white60,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.w)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorStyle: TextStyle(
          color: Color(0xFF8C2A2A),
          fontWeight: FontWeight.w600,
          fontSize: 35.sp,
        ),
      ),
      style: TextStyle(
        color: Colors.black,
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({Key key, this.controller, this.validator, this.enabled})
      : super(key: key);

  final TextEditingController controller;
  final Function validator;
  final bool enabled;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        /// Text form field
        TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscureText,
          validator: widget.validator ?? Validator.passwordValidator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: 40.h, bottom: 40.h, right: 135.w, left: 40.w),
            filled: true,
            fillColor: Colors.white60,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.w)),
              borderSide: BorderSide(color: Colors.grey),
            ),
            errorStyle: TextStyle(
              color: OhNotesColor.error_text,
              fontWeight: FontWeight.w600,
              fontSize: 35.sp,
            ),
          ),
          style: TextStyle(
            color: Colors.black,
          ),
        ),

        /// Eye icon
        GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(right: 30.w, top: 40.h),
            child: FaIcon(
              obscureText
                  ? FontAwesomeIcons.solidEye
                  : FontAwesomeIcons.solidEyeSlash,
              size: 55.w,
              color: Color(0xFF404040),
            ),
          ),
        ),
      ],
    );
  }
}
