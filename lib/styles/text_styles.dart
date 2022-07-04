import 'package:flutter/material.dart';

class OhNotesTextStyles {
  static const _fontFamily = 'OpenSans';

  static TextStyle get appBarTitle => const TextStyle(
        fontSize: 20,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        color: Color(0xFF000000),
      );

  static TextStyle get notePreviewTitle => const TextStyle(
        fontSize: 21,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        color: Color(0xFF000000),
      );

  static TextStyle get notePreviewBody => const TextStyle(
        fontSize: 15,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w300,
        color: Color(0xFF000000),
      );

  static TextStyle get notePreviewLabel => const TextStyle(
        fontSize: 14,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 158, 158, 158),
      );

  static TextStyle get notePreviewDates => const TextStyle(
        fontSize: 12,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(138, 0, 0, 0),
      );

  static TextStyle get drawerOptions => const TextStyle(
        fontSize: 18,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w300,
        color: Color(0xFF000000),
      );

  static TextStyle get button => const TextStyle(
        fontSize: 20,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        color: Color(0xFF000000),
      );

  static TextStyle get reminderTitle => const TextStyle(
        fontSize: 17,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        color: Color(0xFF000000),
      );

  static TextStyle get choices => const TextStyle(
        fontSize: 14,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        color: Color(0xFF000000),
      );

  static TextStyle get splash => const TextStyle(
        fontSize: 30,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        color: Color(0xFF000000),
      );

  static TextStyle get dialogLabel => const TextStyle(
        fontSize: 18,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
        color: Color(0xFF000000),
      );
}
