import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/utils/oh_notes_icons.dart';

import '../../../../utils/date_time_util.dart';
import '../../model.dart';

class NoteListTile extends StatelessWidget {
  final Note note;
  final Function onTap;
  final Function onLongPress;
  final bool isSelected;
  final String dateTimeDisplay;

  const NoteListTile({
    @required this.note,
    @required this.onTap,
    @required this.dateTimeDisplay,
    @required this.onLongPress,
    this.isSelected = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = note.title;
    final description = note.description;
    final todoList = note.todoList;
    final dateModified = note.dateModified;
    final dateCreated = note.dateCreated;
    final dateArchived = note.dateArchived ?? 0;
    final dateDeleted = note.dateDeleted ?? 0;
    final pinned = note.pinned;
    final padding = 10.h;
    final containerHeight = 265.h;
    final toRemind = note.reminder?.reminderStart?.isNotEmpty ?? false;
    final allTodoDone = checkTodoProgress(todoList);
    final archiveMode = dateArchived > 0;
    final trashMode = dateDeleted > 0;

    final noteLabel = Text(
      description == null ? 'Todo' : 'Note',
      style: TextStyle(
        fontStyle: FontStyle.italic,
        color: Colors.grey,
        fontSize: 36.sp,
      ),
    );

    final noteContent = description != null
        ? Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              fontSize: 38.sp,
              fontWeight: FontWeight.w300,
            ),
          )
        : RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              style: TextStyle(
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w300,
                  color: Colors.black),
              children: List.generate(todoList.length, (index) {
                return TextSpan(
                    style: TextStyle(
                        color: todoList[index].done
                            ? Colors.black54
                            : Colors.black),
                    children: [
                      TextSpan(text: '• '),
                      TextSpan(
                          text: todoList[index].todo,
                          style: TextStyle(
                              decoration: todoList[index].done
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none)),
                      TextSpan(text: '  '),
                    ]);
              }),
            ),
          );

    final pinnedIconContainer = Positioned(
      top: -1,
      right: -1,
      child: Container(
        width: 50.w,
        height: 50.w,
        child: pinned ?? false
            ? Icon(
                OhNotes.pin,
                color: Theme.of(context).colorScheme.secondary,
                size: 50.w,
              )
            : Icon(null),
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
            Container(
              width: 600.w,
              child: Text(
                title.isEmpty
                    ? description?.isEmpty ?? true
                        ? DateTimeUtil.toReadableDateTime(dateCreated)
                        : description.substring(
                            0,
                            description.contains('\n')
                                ? description.indexOf('\n')
                                : description.length)
                    : title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 45.h,
                    decoration: allTodoDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: allTodoDone ? Colors.black54 : Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0.w),
              child: Row(
                children: [
                  toRemind
                      ? Icon(
                          Icons.notifications,
                          size: 35.w,
                          color: Colors.grey,
                        )
                      : SizedBox(),
                  noteLabel,
                ],
              ),
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
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
                fontSize: 25.sp,
              ),
            ),
            Visibility(
              visible: !archiveMode && !trashMode,
              child: Text(
                'Date Modified : ${DateTimeUtil.readTimestamp(dateModified, dateTimeDisplay)}',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                  color: Colors.black54,
                  fontSize: 25.sp,
                ),
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
              border: Border.all(color: Colors.orange[100], width: 1))
          : BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.5,
                    offset: Offset(1, 1),
                    spreadRadius: 0.5),
              ],
            ),
      height: containerHeight,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(padding * 2),
            child: notePreview,
          ),

          /// pinned icon
          pinnedIconContainer,
        ],
      ),
    );

    return Padding(
      padding: EdgeInsets.all(padding),
      child: InkWell(
        splashColor: Color(0x5F018574),
        onTap: () {
          onTap();
        },
        onLongPress: () {
          onLongPress();
        },
        child: noteCard,
      ),
    );
  }

  String listToString(List list) {
    if (list == null) return null;
    var todos = '';

    for (var element in list) {
      todos += '• ' + element.todo + ' ';
    }

    return todos;
  }

  bool checkTodoProgress(List list) {
    if (list == null) return false;
    var prog = true;

    for (var element in list) {
      prog = prog && element.done;
    }

    return prog;
  }
}
