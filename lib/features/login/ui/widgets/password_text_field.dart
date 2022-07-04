import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';

import '../../../../utils/validator.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
    this.enabled = true,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      validator: widget.validator ?? Validator.passwordValidator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        filled: true,
        fillColor: Colors.white60,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        errorStyle: OhNotesTextStyles.notePreviewBody.copyWith(
          color: OhNotesColor.errorText,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: FaIcon(
            obscureText
                ? FontAwesomeIcons.solidEye
                : FontAwesomeIcons.solidEyeSlash,
            size: 18,
            color: const Color(0xFF404040),
          ),
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
