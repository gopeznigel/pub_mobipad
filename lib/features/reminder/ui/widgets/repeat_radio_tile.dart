import 'package:flutter/material.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';

typedef RepeatSelect = void Function(int);

class RepeatRadioTile extends StatelessWidget {
  const RepeatRadioTile({
    Key? key,
    required this.value,
    required this.title,
    required this.groupValue,
    this.onChanged,
  }) : super(key: key);

  final RepeatSelect? onChanged;
  final dynamic value;
  final String title;
  final dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    var selected = groupValue == value;

    return InkWell(
      splashColor: Colors.black12,
      borderRadius: BorderRadius.circular(50),
      onTap: onChanged == null
          ? null
          : () {
              onChanged!(value);
            },
      child: Ink(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
              color: selected ? OhNotesColor.secondary : Colors.black,
              width: 0.75),
          borderRadius: BorderRadius.circular(50),
          color: selected ? OhNotesColor.secondary : Colors.transparent,
        ),
        child: Text(
          title,
          style: OhNotesTextStyles.choices.copyWith(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.black87 : Colors.black54),
        ),
      ),
    );
  }
}
