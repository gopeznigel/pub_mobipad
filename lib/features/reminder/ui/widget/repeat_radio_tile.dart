import 'package:flutter/material.dart';
import 'package:mobipad/vars/colors.dart';

class RepeatRadioTile extends StatelessWidget {
  const RepeatRadioTile(
      {Key key, this.onChanged, this.value, this.title, this.groupValue})
      : super(key: key);

  final Function onChanged;
  final dynamic value;
  final String title;
  final dynamic groupValue;

  @override
  Widget build(BuildContext context) {
    var selected = groupValue == value;

    return InkWell(
      splashColor: Colors.black12,
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        onChanged(value);
      },
      child: Ink(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
              color: selected ? OhNotesColor.secondary : Colors.black,
              width: 0.75),
          borderRadius: BorderRadius.circular(50),
          color: selected ? OhNotesColor.secondary : Colors.transparent,
        ),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.black87 : Colors.black54),
        ),
      ),
    );
  }
}
