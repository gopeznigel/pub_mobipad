import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

class LocalNotificationService {
  LocalNotificationService(this._selectNotificationSubject);

  late final BehaviorSubject<String> _selectNotificationSubject;

  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final _initializationSettings = const InitializationSettings(
    android: AndroidInitializationSettings('app_icon'),
    iOS: null,
    macOS: null,
  );

  Future<FlutterLocalNotificationsPlugin> get notificationsPlugin async {
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('payload: $payload');
        _selectNotificationSubject.add(payload);
      }
    });

    return _flutterLocalNotificationsPlugin;
  }
}
