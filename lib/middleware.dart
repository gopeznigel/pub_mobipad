import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:rxdart/subjects.dart';

import 'env.dart';
import 'features/forgot_password/middleware.dart' as forgot_password;
import 'features/home/middleware.dart' as home;
import 'features/login/middleware.dart' as login;
import 'features/note/middleware.dart' as note;
import 'features/reminder/middleware.dart' as reminder;
import 'features/settings/middleware.dart' as settings;
import 'features/todo/middleware.dart' as todo;
import 'globals.dart';
import 'state.dart';

typedef GetStore = Store<AppState> Function();

List<Middleware<AppState>> getMiddleware(
        Apis apis,
        GetStore getStore,
        GlobalKey<NavigatorState> navigatorKey,
        CompositeNavigatorObserver compositeNavigatorObserver,
        BehaviorSubject<String> selectNotificationSubject) =>
    [
      login.getMiddleware(navigatorKey, apis.loginApi),
      home.getMiddleware(apis.homeApi),
      home.getEpicMiddleware(apis.homeApi),
      note.getMiddleware(apis.noteApi),
      todo.getMiddleware(apis.noteApi),
      forgot_password.getMiddleware(apis.forgotPasswordApi),
      reminder.getMiddleware(navigatorKey, apis.reminderHelper, selectNotificationSubject),
      settings.getMiddleware(),
      loggingMiddleware
          ? <Middleware<AppState>>[LoggingMiddleware<dynamic>.printer()]
          : <Middleware<AppState>>[],
    ].expand((x) => x).toList();
