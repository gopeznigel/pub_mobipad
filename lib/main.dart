import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/reminder/ui/reminder_page.dart';
import 'package:mobipad/features/settings/ui/privacy_page.dart';
import 'package:mobipad/services/reminder_manager.dart';
import 'package:mobipad/vars/colors.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tzl;

import 'features/app.dart';
import 'features/forgot_password/api.dart';
import 'features/forgot_password/ui/forgot_password_page.dart';
import 'features/home/api.dart';
import 'features/home/ui/home_page.dart';
import 'features/login/api.dart';
import 'features/login/ui/login_page.dart';
import 'features/login/ui/signup_page.dart';
import 'features/note/api.dart';
import 'features/note/ui/note_page.dart';
import 'features/reminder/helper.dart';
import 'features/settings/ui/settings_page.dart';
import 'features/todo/ui/todo_page.dart';
import 'globals.dart' as globals;
import 'middleware.dart';
import 'reducers.dart';
import 'services/auth_api.dart';
import 'services/note_api.dart';
import 'services/user_repository.dart';
import 'state.dart';

Future<void> main() async {
  // Lock to portrait orientation.
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp();

  tzl.initializeTimeZones();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final selectNotificationSubject = BehaviorSubject<String>();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: null,
    macOS: null,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('payload: $payload');
      selectNotificationSubject.add(payload);
    }
  });

  final alarmManager = ReminderManager(flutterLocalNotificationsPlugin);
  final userRepository = UserRepository();
  final api = Api();
  final authApi = Auth();

  final apis = globals.Apis(
    getLoginApi(userRepository, authApi),
    getHomeApi(api),
    getNoteApi(api),
    getForgotPasswordApi(authApi),
    getReminderHelper(alarmManager),
  );

  final appKey = GlobalKey(debugLabel: 'app');
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'navigator');
  final compositeNavigatorObserver = globals.CompositeNavigatorObserver();
  Store<AppState> store;

  final routes = <String, Widget Function(BuildContext)>{
    App.route: (_) => App(),
    LoginPage.route: (_) => LoginPage(),
    SignUpPage.route: (_) => SignUpPage(),
    HomePage.route: (_) => HomePage(),
    NotePage.route: (_) => NotePage(),
    TodoPage.route: (_) => TodoPage(),
    SettingsPage.route: (_) => SettingsPage(),
    ForgotPasswordPage.route: (_) => ForgotPasswordPage(),
    ReminderPage.route: (_) => ReminderPage(),
    PrivacyPage.route: (_) => PrivacyPage(),
  };

  final middleware = getMiddleware(apis, () => store, navigatorKey,
      compositeNavigatorObserver, selectNotificationSubject);

  store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initial(),
    middleware: middleware,
  );

  final ThemeData theme = ThemeData(fontFamily: 'OpenSans');

  final materialApp = ScreenUtilInit(
    designSize: Size(1080, 1920),
    builder: () => MaterialApp(
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
    ),
  );

  final storeProvider = StoreProvider<AppState>(
    store: store,
    child: materialApp,
  );

  runApp(storeProvider);
}

LoginApi getLoginApi(UserRepository userRepository, Auth authApi) =>
    LoginApi(userRepository, authApi);
HomeApi getHomeApi(Api api) => HomeApi(api);
NoteApi getNoteApi(Api api) => NoteApi(api);
ForgotPasswordApi getForgotPasswordApi(Auth authApi) =>
    ForgotPasswordApi(authApi);
ReminderHelper getReminderHelper(ReminderManager manager) =>
    ReminderHelper(manager);
