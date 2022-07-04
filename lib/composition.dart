import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/forgot_password/api.dart';
import 'package:mobipad/features/home/api.dart';
import 'package:mobipad/features/login/api.dart';
import 'package:mobipad/features/note/api.dart';
import 'package:mobipad/features/reminder/api.dart';
import 'package:mobipad/features/settings/api.dart';
import 'package:mobipad/reducers.dart';
import 'package:mobipad/routes.dart';
import 'package:mobipad/services/local_notification_service.dart';
import 'package:mobipad/services/note_service.dart';
import 'package:mobipad/services/reminder_manager.dart';
import 'package:mobipad/services/settings_repository.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'styles/colors.dart';
import 'features/app.dart';
import 'globals.dart' as globals;
import 'middleware.dart';
import 'services/auth_service.dart';

Future<Widget> get appWidget async {
  // Initialize Firebase before anything else
  await Firebase.initializeApp();

  // Initialize time zone database
  tzl.initializeTimeZones();

  // Initialize apis, helpers classes here to make sure they are
  // created only once.
  final selectNotificationSubject = BehaviorSubject<String>();
  final localNotificationService =
      LocalNotificationService(selectNotificationSubject);
  final reminderManager =
      ReminderManager(await localNotificationService.notificationsPlugin);
  final authApi = AuthService();
  final noteService = NoteService();
  final settingsRepository = SettingsRepository();

  final apis = globals.Apis(
    LoginApi(authApi),
    HomeApi(noteService),
    NoteApi(noteService),
    ForgotPasswordApi(authApi),
    ReminderApi(reminderManager),
    SettingsApi(settingsRepository),
  );

  final appKey = GlobalKey(debugLabel: 'app');
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'navigator');
  final compositeNavigatorObserver = globals.CompositeNavigatorObserver();
  late Store<AppState> store;

  // Create middleware
  final middleware = getMiddleware(
    apis,
    () => store,
    navigatorKey,
    compositeNavigatorObserver,
    selectNotificationSubject,
  );

  // Create store
  store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
    middleware: middleware,
  );

  // Create theme with font [OpenSans]
  final ThemeData theme = ThemeData(fontFamily: 'OpenSans');

  final materialApp = MaterialApp(
    key: appKey,
    navigatorObservers: [compositeNavigatorObserver],
    navigatorKey: navigatorKey,
    initialRoute: App.route,
    routes: routes,
    title: 'Oh Notes!',
    theme: theme.copyWith(
      primaryColor: OhNotesColor.primary,
      colorScheme: theme.colorScheme.copyWith(secondary: OhNotesColor.accent),
      scaffoldBackgroundColor: OhNotesColor.scaffold,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    debugShowCheckedModeBanner: false,
  );

  final storeProvider = StoreProvider<AppState>(
    store: store,
    child: materialApp,
  );

  return storeProvider;
}
