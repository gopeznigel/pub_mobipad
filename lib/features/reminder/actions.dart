import 'package:flutter/material.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/exception/action_exception.dart';

@immutable
class SetOnRepeat {
  final bool repeat;

  const SetOnRepeat({required this.repeat});

  @override
  String toString() => 'SetOnRepeat  { repeat: $repeat }';
}

@immutable
class SetDate {
  final DateTime date;

  const SetDate({required this.date});

  @override
  String toString() => 'SetDate  { date: $date }';
}

@immutable
class SetTime {
  final TimeOfDay time;

  const SetTime({required this.time});

  @override
  String toString() => 'SetTime  { time: $time }';
}

@immutable
class SetRepeat {
  final int repeatValue;

  const SetRepeat({required this.repeatValue});

  @override
  String toString() => 'SetRepeat  { repeatValue: $repeatValue }';
}

@immutable
class AutoSelectWeekDay {
  final DateTime selectedDate;

  const AutoSelectWeekDay({required this.selectedDate});

  @override
  String toString() => 'AutoSelectWeekDay  { selectedDate: $selectedDate }';
}

@immutable
class ResetSelectedWeekDay {
  @override
  String toString() => 'ResetSelectedWeekDay';
}

@immutable
class UpdateReminderDays {
  final int dayIndex;
  final bool value;

  const UpdateReminderDays({required this.dayIndex, required this.value});

  @override
  String toString() =>
      'UpdateReminderDays  { dayIndex: $dayIndex, value: $value }';
}

@immutable
class ScheduleReminder {
  const ScheduleReminder({
    required this.note,
    required this.reminder,
  });

  final NoteDto note;
  final ReminderDto reminder;

  @override
  String toString() => 'ScheduleReminder  { note: $note, reminder: $reminder }';
}

@immutable
class ScheduleReminderSuccessful {
  @override
  String toString() => 'ScheduleReminderSuccessful ';
}

@immutable
class ScheduleReminderFailed {
  final ActionException exception;

  const ScheduleReminderFailed({required this.exception});

  @override
  String toString() => 'ScheduleReminderFailed { exception: $exception }';
}

@immutable
class RescheduleReminder {
  const RescheduleReminder({
    required this.note,
    required this.reminder,
  });

  final NoteDto note;
  final ReminderDto reminder;

  @override
  String toString() =>
      'RescheduleReminder  { note: $note, reminder: $reminder }';
}

// Clears all current states
@immutable
class ResetReminder {
  @override
  String toString() => 'ClearAllReminder';
}
