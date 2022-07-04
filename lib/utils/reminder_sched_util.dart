import 'package:flutter/material.dart';
import 'package:mobipad/core/dtos.dart';

class ReminderUtil {
  static List<int> generateSchedules({
    required int repeat,
    required DateTime date,
    required TimeOfDay time,
    required List<Map<String, dynamic>> days,
  }) {
    List<int> schedules = <int>[];

    var initialSched = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    switch (repeat) {
      case 0: // Once
      case 1: // Daily
      case 3: // Monthly
      case 4: // Yearly
        schedules.add(initialSched.millisecondsSinceEpoch);
        break;
      case 2: // Weekly
        // Get selected weekdays
        List<int> activeWeekdays = _getActiveWeekdays(days, initialSched);
        var copyOfInitialSched = initialSched;

        // Get schedule that is same with the weekday
        // Add a day until weekday matches
        for (var activeWeekday in activeWeekdays) {
          while (activeWeekday != copyOfInitialSched.weekday) {
            copyOfInitialSched =
                copyOfInitialSched.add(const Duration(days: 1));
          }

          schedules.add(copyOfInitialSched.millisecondsSinceEpoch);
          copyOfInitialSched = initialSched;
        }

        break;
      default:
    }

    for (var sched in schedules) {
      debugPrint(DateTime.fromMillisecondsSinceEpoch(sched).toString());
    }

    return schedules;
  }

  static String getReminderBody(NoteDto note) {
    String desc = note.description ?? '';
    List<TodoDto> todos = note.todoList?.asList() ?? [];

    if (desc.isNotEmpty) {
      return desc;
    } else {
      var todoString = '';
      for (var todo in todos) {
        todoString += '•';
        todoString += todo.todo!;
        todoString += ' ';
      }

      return todoString;
    }
  }

  static List<int> _getActiveWeekdays(
      List<Map<String, dynamic>> days, DateTime schedDate) {
    List<int> weekdays = <int>[];

    for (var i = 0; i < days.length; i++) {
      if (days[i]['value'] == true) {
        weekdays.add(i == 0 ? 7 : i);
      }
    }

    if (weekdays.isNotEmpty) {
      return weekdays;
    } else {
      return [schedDate.weekday];
    }
  }
}
