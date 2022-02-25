import 'package:mobipad/features/home/model.dart';

String todoListToString(List<ToDoItem> todoList) {
  var message = '';

  for (var todo in todoList) {
    message += '• ${todo.todo} ';
  }

  message = message.trim();

  return message;
}

int getNextReminderSchedule(int reminderStart, int selectedRepeat) {
  var now = DateTime.now().millisecondsSinceEpoch;
  int newReminder;

  switch (selectedRepeat) {
    case 0: // once
      if (now > reminderStart) {
        return 0;
      } else {
        return reminderStart;
      }
      break;
    case 1: // daily
      newReminder = DateTime.fromMillisecondsSinceEpoch(reminderStart)
          .add(Duration(days: 1))
          .millisecondsSinceEpoch;
      break;
    case 2: // weekly
      newReminder = DateTime.fromMillisecondsSinceEpoch(reminderStart)
          .add(Duration(days: 7))
          .millisecondsSinceEpoch;
      break;
    case 3: // bi-weekly
      newReminder = DateTime.fromMillisecondsSinceEpoch(reminderStart)
          .add(Duration(days: 14))
          .millisecondsSinceEpoch;
      break;
    case 4: // monthly
      var oldRem = DateTime.fromMillisecondsSinceEpoch(reminderStart);
      var newRem = DateTime(oldRem.year, oldRem.month + 1, oldRem.day,
          oldRem.hour, oldRem.minute);
      newReminder = newRem.millisecondsSinceEpoch;
      break;
    case 5: // year
      var oldRem = DateTime.fromMillisecondsSinceEpoch(reminderStart);
      var newRem = DateTime(oldRem.year + 1, oldRem.month, oldRem.day,
          oldRem.hour, oldRem.minute);
      newReminder = newRem.millisecondsSinceEpoch;
      break;
    default:
      return 0;
  }

  if (now > reminderStart) {
    // means that the first reminder was done
    return newReminder;
  } else {
    return reminderStart;
  }
}
