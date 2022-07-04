import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class ReminderManager {
  ReminderManager(this._flutterLocalNotificationsPlugin);

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationDetails _getplatformChannelSpecifics(int id) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '$id', 'Reminder',
        channelDescription: 'Notification option for reminder',
        priority: Priority.high,
        icon: 'secondary_icon',
        importance: Importance.max,
        styleInformation: const DefaultStyleInformation(true, true),
        enableLights: true,
        color: const Color.fromARGB(255, 220, 220, 220),
        ledColor: const Color.fromARGB(255, 0, 255, 0),
        ledOnMs: 1000,
        ledOffMs: 500);

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  Future<int> scheduleReminder({
    String? title,
    String? message,
    List<int>? schedules,
    String? payload,
    int? repeat,
  }) async {
    var index = 1;
    var id = await getNextUsedId();

    void schedIter(schedule) async {
      debugPrint(
          'Schedule : ${DateFormat('MM/dd/yyyy hh:mm').format(DateTime.fromMillisecondsSinceEpoch(schedule))}');
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse('${index++}$id'),
        title,
        message,
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, schedule),
        _getplatformChannelSpecifics(id),
        androidAllowWhileIdle: true,
        payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: getDateTimeComponent(repeat ?? 0),
      );
    }

    schedules?.forEach(schedIter);

    return id;
  }

  Future<void> rescheduleReminder({
    required int remId,
    String? title,
    String? message,
    List<int>? schedules,
    String? payload,
    int? repeat,
  }) async {
    var index = 1;

    void schedIter(schedule) async {
      debugPrint(
          'Reschedule : ${DateFormat('MM/dd/yyyy hh:mm').format(DateTime.fromMillisecondsSinceEpoch(schedule))}');
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        int.parse('${index++}$remId'),
        title,
        message,
        tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, schedule),
        _getplatformChannelSpecifics(remId),
        androidAllowWhileIdle: true,
        payload: payload,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: getDateTimeComponent(repeat ?? 0),
      );
    }

    schedules?.forEach(schedIter);
  }

  Future<void> cancelReminder(int id) async {
    for (var i = 0; i < 7; i++) {
      debugPrint('cleared ${i + 1}$id');
      await _flutterLocalNotificationsPlugin.cancel(int.parse('${i + 1}$id'));
    }
  }

  Future<void> cancelAllReminder() async {
    await _flutterLocalNotificationsPlugin.cancelAll();

    var pendings =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    if (pendings.isEmpty) {
      debugPrint('no schedule');
    }
  }

  Future<List<PendingNotificationRequest>> getPendingReminderList() async {
    return await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  Future<int> getNextUsedId() async {
    var pendings =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    if (pendings.isEmpty) {
      return 0;
    }

    var lastIdIntegerWithIndex = pendings.last.id;
    var lastIdStringWithoutIndex =
        lastIdIntegerWithIndex.toString().substring(1);
    return int.parse(lastIdStringWithoutIndex) + 1;
  }

  DateTimeComponents? getDateTimeComponent(int repeat) {
    switch (repeat) {
      case 1: // Daily
        return DateTimeComponents.time;
      case 2: // Weekly
        return DateTimeComponents.dayOfWeekAndTime;
      case 3: // Monthly
        return DateTimeComponents.dayOfMonthAndTime;
      case 4: // Yearly
        return DateTimeComponents.dateAndTime;
      case 0: // Once
      default:
        return null;
    }
  }
}
