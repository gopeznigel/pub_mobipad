import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobipad/services/reminder_manager.dart';

class ReminderHelper {
  ReminderHelper(this.manager);

  final ReminderManager manager;

  Future<List<PendingNotificationRequest>> getPendingReminders() async =>
      await manager.getPendingReminderList();

  Future<int> setupReminder(String id, String type, String title,
      String message, List<int> schedules) async {
    return await manager.scheduleReminder(
        title: title,
        message: message,
        schedules: schedules,
        payload: '$type $id');
  }

  Future<void> resetupReminder(String id, String type, String title,
      String message, List<int> schedules, int remId) async {
    await manager.rescheduleReminder(
      title: title,
      message: message,
      schedules: schedules,
      payload: '$type $id',
      remId: remId,
    );
  }

  Future<void> cancelReminder(int remId) async {
    await manager.cancelReminder(remId);
  }

  Future<void> cancelAllReminder() async {
    await manager.cancelAllReminder();
  }
}
