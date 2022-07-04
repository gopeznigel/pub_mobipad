import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobipad/services/reminder_manager.dart';

class ReminderApi {
  ReminderApi(this.manager);

  final ReminderManager manager;

  Future<List<PendingNotificationRequest>> getPendingReminders() async =>
      await manager.getPendingReminderList();

  Future<int> setupReminder(String id, String title, String message,
      List<int> schedules, int? repeat) async {
    return await manager.scheduleReminder(
        title: title,
        message: message,
        schedules: schedules,
        payload: id,
        repeat: repeat);
  }

  Future<void> resetupReminder(String id, String title, String message,
      List<int> schedules, int remId, int? repeat) async {
    await manager.rescheduleReminder(
        title: title,
        message: message,
        schedules: schedules,
        payload: id,
        remId: remId,
        repeat: repeat);
  }

  Future<void> cancelReminder(int remId) async {
    await manager.cancelReminder(remId);
  }

  Future<void> cancelAllReminder() async {
    await manager.cancelAllReminder();
  }
}
