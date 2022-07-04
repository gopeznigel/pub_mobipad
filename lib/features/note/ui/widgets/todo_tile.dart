import 'package:flutter/material.dart';

typedef TodoTileTap = void Function();

class TodoTile extends StatelessWidget {
  const TodoTile({
    Key? key,
    required this.leading,
    required this.title,
    required this.trailing,
    required this.onTap,
  }) : super(key: key);

  final Widget leading;
  final Widget title;
  final Widget trailing;
  final TodoTileTap onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
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
