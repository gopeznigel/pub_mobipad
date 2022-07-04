import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobipad/constants/reminder_objects.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/state.dart';

class ReminderPageViewModel {
  final AppState _state;
  final BuildContext _context;

  ReminderPageViewModel(this._context, this._state);

  NoteDto get note => _state.noteState.note!;

  ReminderDto? get reminder => _state.reminderState.reminder;

  bool get withReminderId => reminder!.remId != null;

  bool get onRepeat => _state.reminderState.onRepeat;

  DateTime get selectedDate =>
      _state.reminderState.selectedDate ?? DateTime.now();

  int get selectedRepeat => reminder!.selectedRepeat ?? 0;

  TimeOfDay get selectedTime {
    if (reminder == null) {
      return _state.reminderState.selectedTime ?? TimeOfDay.now();
    } else {
      var date =
          DateTime.fromMillisecondsSinceEpoch(reminder!.reminderStart![0]);

      return TimeOfDay(hour: date.hour, minute: date.minute);
    }
  }

  String get repeatDescription {
    var text = ' ';
    text = repeat[selectedRepeat]['desc'];

    // Show reminder date when once is selected
    if (selectedRepeat == 0) {
      var day = DateFormat('MMM dd').format(selectedDate);
      text += ' on $day';
    }

    // if no week day is selected, repeat every selected calendar day
    if (selectedRepeat > 1) {
      if (numberOfWeekDaySelected == 0) {
        if (selectedRepeat > 3) {
          var day = DateFormat('dd').format(selectedDate);
          text += ' on day $day';
        }
      } else {
        if (selectedRepeat == 4) {
          // get week number of week day
          var weekCount = weekOfMonth;
          text = text.replaceFirst('month', '');
          text += weekCount;
        }
        // there is a selected week day
        for (var e in days) {
          if (e['value']) {
            text += ' ${e['name']},';
          }
        }

        // remove last comma
        text = text.substring(0, text.length - 1);
      }
    }

    text += ' at ${selectedTime.format(_context)}';

    return text;
  }

  int get numberOfWeekDaySelected {
    var count = 0;
    for (var e in days) {
      if (e['value']) {
        count++;
      }
    }

    return count;
  }

  String get weekOfMonth {
    String week = 'first';

    var weekCount = 0;
    var currMonth = selectedDate.month;
    var month = selectedDate.month;
    var selDate = selectedDate;

    while (currMonth == month) {
      weekCount++;
      selDate = selDate.subtract(const Duration(days: 7));
      month = selDate.month;
    }

    switch (weekCount) {
      case 1:
        week = 'first';
        break;
      case 2:
        week = 'second';
        break;
      case 3:
        week = 'third';
        break;
      case 4:
        week = 'fourth';
        break;
      case 5:
        week = 'fifth';
        break;
      default:
    }

    return week;
  }

  bool get isSelectedDateValid {
    var dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    ).millisecondsSinceEpoch;

    var now = DateTime.now();
    var today = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    ).millisecondsSinceEpoch;

    return (dateTime > today);
  }

  ActionException? get exception => _state.reminderState.exception;
}
