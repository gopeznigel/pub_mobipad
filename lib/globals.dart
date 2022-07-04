import 'package:flutter/material.dart';
import 'package:mobipad/features/settings/api.dart';

import 'features/forgot_password/api.dart';
import 'features/home/api.dart';
import 'features/login/api.dart';
import 'features/note/api.dart';
import 'features/reminder/api.dart';

class Apis {
  Apis(
    this.loginApi,
    this.homeApi,
    this.noteApi,
    this.forgotPasswordApi,
    this.reminderApi,
    this.settingsApi,
  );

  final LoginApi loginApi;
  final HomeApi homeApi;
  final NoteApi noteApi;
  final ForgotPasswordApi forgotPasswordApi;
  final ReminderApi reminderApi;
  final SettingsApi settingsApi;
}

class CompositeNavigatorObserver extends NavigatorObserver {
  CompositeNavigatorObserver() : _observers = <NavigatorObserver>[];

  final List<NavigatorObserver> _observers;

  void addObserver(NavigatorObserver observer) => _observers.add(observer);

  @override
  void didPush(Route route, Route? previousRoute) {
    for (var observer in _observers) {
      observer.didPush(route, previousRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    for (var observer in _observers) {
      observer.didPop(route, previousRoute);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    for (var observer in _observers) {
      observer.didRemove(route, previousRoute);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    for (var observer in _observers) {
      observer.didReplace(oldRoute: oldRoute, newRoute: newRoute);
    }
  }
}
