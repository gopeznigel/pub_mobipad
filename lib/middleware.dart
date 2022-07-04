import 'package:flutter/material.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:rxdart/rxdart.dart';
import 'features/login/middleware.dart' as login;
import 'features/home/middleware.dart' as home;
import 'features/note/middleware.dart' as note;
import 'features/reminder/middleware.dart' as reminder;
import 'features/settings/middleware.dart' as settings;

import 'env.dart';
import 'globals.dart';

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
      note.getMiddleware(navigatorKey, apis.noteApi),
      reminder.getMiddleware(
          navigatorKey, apis.reminderApi, selectNotificationSubject),
      settings.getMiddleware(apis.settingsApi),
      loggingMiddleware
          ? <Middleware<AppState>>[
              LoggingMiddleware<dynamic>.printer(
                  formatter: (state, action, timestamp) => '{Action: $action}')
            ]
          : <Middleware<AppState>>[],
    ].expand((x) => x).toList();
