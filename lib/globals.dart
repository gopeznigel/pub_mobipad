import 'package:flutter/material.dart';
import 'package:mobipad/features/reminder/helper.dart';

import 'features/forgot_password/api.dart';
import 'features/home/api.dart';
import 'features/login/api.dart';
import 'features/note/api.dart';

class Apis {
  Apis(
    this.loginApi,
    this.homeApi,
    this.noteApi,
    this.forgotPasswordApi,
    this.reminderHelper,
  );

  final LoginApi loginApi;
  final HomeApi homeApi;
  final NoteApi noteApi;
  final ForgotPasswordApi forgotPasswordApi;
  final ReminderHelper reminderHelper;
}

class CompositeNavigatorObserver extends NavigatorObserver {
  CompositeNavigatorObserver() : _observers = <NavigatorObserver>[];

  final List<NavigatorObserver> _observers;

  void addObserver(NavigatorObserver observer) => _observers.add(observer);

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    for (var observer in _observers) {
      observer.didPush(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    for (var observer in _observers) {
      observer.didPop(route, previousRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    for (var observer in _observers) {
      observer.didRemove(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic> oldRoute, Route<dynamic> newRoute}) {
    for (var observer in _observers) {
      observer.didReplace(oldRoute: oldRoute, newRoute: newRoute);
    }
  }
}
