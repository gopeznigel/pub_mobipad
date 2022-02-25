import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key key,
    this.leading,
    this.title,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget trailing;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: leading,
            ),
            Expanded(
              flex: 4,
              child: title,
            ),
            Expanded(
              flex: 1,
              child: trailing,
            ),
          ],
        ),
      ),
    );
  }
}
