import 'package:flutter/material.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';

import '../../../../utils/validator.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.controller,
    this.enabled = true,
  }) : super(key: key);

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
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
      ),
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
