import 'package:flutter/foundation.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/home/model.dart';

@immutable
class ScheduleReminder {
  ScheduleReminder(
    this.item,
    this.days,
    this.selectedRepeat,
    this.id,
    this.type,
    this.title,
    this.body,
    this.schedule,
  ) : assert(schedule != null);

  final String id;
  final String type;
  final String title;
  final String body;
  final List<int> schedule;
  final Note item;
  final List<Map<String, dynamic>> days;
  final int selectedRepeat;

  @override
  String toString() => 'ScheduleReminder  {schedule: $schedule}';
}

@immutable
class ScheduleReminderSuccessful {
  ScheduleReminderSuccessful(this.remId) : assert(remId != null);

  final int remId;

  @override
  String toString() => 'ScheduleReminderSuccessful  {remId: $remId}';
}

@immutable
class RescheduleReminder {
  RescheduleReminder(
      this.id, this.type, this.title, this.body, this.schedule, this.remId)
      : assert(schedule != null);

  final String id;
  final String type;
  final String title;
  final String body;
  final List<int> schedule;
  final int remId;

  @override
  String toString() => 'RescheduleReminder  {schedule: $schedule}';
}

@immutable
class InitReminder {
  InitReminder(this.item, this.type, this.remId)
      : assert(item != null && type != null);

  final Note item;
  final String type;
  final int remId;

  @override
  String toString() => 'InitReminder  {item: $item, type: $type}';
}

@immutable
class NotificationClickListener {
  @override
  String toString() => 'NotificationClickListener ';
}

@immutable
class DisposeNotificationClickListener {
  @override
  String toString() => 'DisposeNotificationClickListener ';
}

@immutable
class ClearReminder {
  ClearReminder(this.remId) : assert(remId != null);

  final int remId;

  @override
  String toString() => 'ClearReminder {remId: $remId}';
}

@immutable
class ClearReminderSucceeded {
  @override
  String toString() => 'ClearReminderSucceeded';
}

@immutable
class ClearReminderFailed {
  ClearReminderFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'ClearReminderFailed {exception: $exception}';
}

@immutable
class ClearAllReminder {
  @override
  String toString() => 'ClearAllReminder';
}
