import 'package:flutter/material.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';

typedef RepeatChange = void Function(bool);

class DayCheckBox extends StatelessWidget {
  const DayCheckBox({
    Key? key,
    required this.value,
    required this.title,
    required this.repetition,
    required this.count,
    this.onChanged,
  }) : super(key: key);

  final RepeatChange? onChanged;
  final bool value;
  final String title;
  final int repetition;
  final int count;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;

    return InkWell(
      splashColor: Colors.black12,
      borderRadius: BorderRadius.circular(50),
      onTap: onChanged == null
          ? null
          : () {
              var newValue = !value;
              if (repetition < 4 && count == 1) {
                newValue = true;
              }

              onChanged!(newValue);
            },
      child: Ink(
        height: size * 0.15,
        width: size * 0.15,
        decoration: BoxDecoration(
          border: Border.all(
              color: value ? OhNotesColor.secondary : Colors.black,
              width: 0.75),
          borderRadius: BorderRadius.circular(100),
          color: value ? OhNotesColor.secondary : Colors.transparent,
        ),
        child: Center(
          child: Text(
            title,
            style: OhNotesTextStyles.choices.copyWith(
              fontWeight: FontWeight.w600,
              color: value ? Colors.black87 : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
