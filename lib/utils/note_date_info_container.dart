import 'package:flutter/material.dart';
import 'package:mobipad/features/home/model.dart';

import 'date_time_util.dart';

class NoteDateInfoContainer extends StatelessWidget {
  final Note note;
  final bool isEditing;
  final String display;

  const NoteDateInfoContainer(
      {Key key, this.note, this.isEditing, this.display})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: isEditing
          ? SizedBox()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // creation and edited date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          DateTimeUtil.readTimestamp(
                              note?.dateCreated ??
                                  DateTime.now().millisecondsSinceEpoch,
                              display),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.slow_motion_video,
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          DateTimeUtil.readTimestamp(
                              note?.dateModified ??
                                  DateTime.now().millisecondsSinceEpoch,
                              display),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                // reminder, next reminder on; if any
                note?.reminder?.reminderStart?.isNotEmpty ?? false
                    ? Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.grey,
                            size: 15,
                          ),
                          Text(
                            getNextAlarm(note.reminder),
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      )
                    : SizedBox(),
                Divider(
                  color: Colors.grey,
                  height: 1,
                  thickness: 0.5,
                ),
              ],
            ),
    );
  }

  String getNextAlarm(Reminder reminder) {
    var reminders = reminder.reminderStart;
    var next = reminders[0];
    for (var rem in reminders) {
      if (next > rem) {
        next = rem;
      }
    }

    return DateTimeUtil.dateAndTime(next);
  }
}
