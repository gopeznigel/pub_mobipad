import 'package:flutter/material.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/styles/text_styles.dart';

class NotePopupMenuItem extends StatelessWidget {
  const NotePopupMenuItem({
    Key? key,
    required this.disabled,
    required this.menu,
  }) : super(key: key);

  final bool disabled;
  final NoteMenuDto menu;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          menu.icon,
          color: disabled ? Colors.grey : Colors.black87,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          menu.menu!.name,
          style: OhNotesTextStyles.notePreviewBody.copyWith(
            color: disabled ? Colors.grey : Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
