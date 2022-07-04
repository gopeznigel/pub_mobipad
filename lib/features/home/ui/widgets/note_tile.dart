import 'package:flutter/material.dart';
import 'package:mobipad/constants/oh_notes_icons.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/utils/date_time_util.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/utils/todo_util.dart';

typedef TileTap = void Function();

class NoteTile extends StatelessWidget {
  final NoteDto note;
  final TileTap onTap;
  final TileTap onLongPress;
  final bool isSelected;
  final String dateTimeDisplay;

  const NoteTile({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onLongPress,
    required this.dateTimeDisplay,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const containerHeight = 120.0;

    final title = note.title ?? '';
    final description = note.description ?? '';
    final todoList = note.todoList?.toList() ?? [];
    final dateModified = note.dateModified ?? 0;
    final dateCreated = note.dateCreated ?? 0;
    final dateArchived = note.dateArchived ?? 0;
    final dateDeleted = note.dateDeleted ?? 0;
    final pinned = note.pinned;
    final toRemind = note.reminder?.reminderStart?.isNotEmpty ?? false;
    final allTodoDone = TodoUtil.checkProgress(todoList);
    final archiveMode = dateArchived > 0;
    final trashMode = dateDeleted > 0;

    final noteLabel = Text(
      description.isEmpty ? 'Todo' : 'Note',
      style: OhNotesTextStyles.notePreviewLabel,
    );

    final noteContent = description.isNotEmpty
        ? Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: OhNotesTextStyles.notePreviewBody,
          )
        : RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              style: OhNotesTextStyles.notePreviewBody,
              children: List.generate(
                todoList.length,
                (index) {
                  return TextSpan(
                    style: TextStyle(
                      color: todoList[index].done ?? false
                          ? Colors.black54
                          : Colors.black,
                    ),
                    children: [
                      const TextSpan(text: '• '),
                      TextSpan(
                        text: todoList[index].todo,
                        style: TextStyle(
                          decoration: todoList[index].done ?? false
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const TextSpan(text: '  '),
                    ],
                  );
                },
              ),
            ),
          );

    final pinnedIconContainer = Positioned(
      top: -1,
      right: -1,
      child: SizedBox(
        width: 15,
        height: 15,
        child: pinned
            ? Icon(
                OhNotes.pin,
                color: Theme.of(context).colorScheme.secondary,
                size: 15,
              )
            : const Icon(null),
      ),
    );

    final notePreview = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /// Title and label
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                title.isEmpty
                    ? description.isEmpty
                        ? DateTimeUtil.toReadableDateTime(dateCreated)
                        : description.substring(
                            0,
                            description.contains('\n')
                                ? description.indexOf('\n')
                                : description.length,
                          )
                    : title,
                overflow: TextOverflow.ellipsis,
                style: OhNotesTextStyles.notePreviewTitle.copyWith(
                  decoration: allTodoDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: allTodoDone ? Colors.black54 : Colors.black,
                ),
              ),
            ),
            Row(
              children: [
                if (toRemind)
                  const Icon(
                    Icons.notifications,
                    size: 15,
                    color: Colors.grey,
                  ),
                noteLabel,
              ],
            ),
          ],
        ),

        /// Description or content of note
        Flexible(child: noteContent),

        /// Dates
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              archiveMode
                  ? 'Date Archived : ${DateTimeUtil.readTimestamp(dateArchived, dateTimeDisplay)}'
                  : trashMode
                      ? 'Date Deleted : ${DateTimeUtil.readTimestamp(dateDeleted, dateTimeDisplay)}'
                      : 'Date Created : ${DateTimeUtil.readTimestamp(dateCreated, dateTimeDisplay)}',
              style: OhNotesTextStyles.notePreviewDates,
            ),
            Visibility(
              visible: !archiveMode && !trashMode,
              child: Text(
                'Date Modified : ${DateTimeUtil.readTimestamp(dateModified, dateTimeDisplay)}',
                style: OhNotesTextStyles.notePreviewDates,
              ),
            ),
          ],
        ),
      ],
    );

    final noteCard = Ink(
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.black26,
              border: Border.all(
                color: Colors.orange.shade100,
                width: 1,
              ),
            )
          : const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 0.5,
                  offset: Offset(1, 1),
                  spreadRadius: 0.5,
                ),
              ],
            ),
      height: containerHeight,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: notePreview,
          ),

          /// pinned icon
          pinnedIconContainer,
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        splashColor: const Color(0x5F018574),
        onTap: () {
          onTap();
        },
        onLongPress: onLongPress,
        child: noteCard,
      ),
    );
  }
}
