import 'package:flutter/material.dart';
import 'package:mobipad/vars/colors.dart';

class DayCheckBox extends StatelessWidget {
  const DayCheckBox(
      {Key key,
      this.onChanged,
      this.value,
      this.title,
      this.repetition,
      this.count})
      : super(key: key);

  final Function onChanged;
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
      onTap: () {
        var newValue = !value;
        if (repetition < 4 && count == 1) {
          newValue = true;
        }

        onChanged(newValue);
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
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: value ? Colors.black87 : Colors.black54),
          ),
        ),
      ),
    );
  }
}
