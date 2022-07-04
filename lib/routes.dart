import 'package:flutter/material.dart';

import 'features/app.dart';
import 'features/forgot_password/ui/forgot_password_page.dart';
import 'features/home/ui/home_page.dart';
import 'features/login/ui/login_page.dart';
import 'features/login/ui/signup_page.dart';
import 'features/note/ui/note_page.dart';
import 'features/reminder/ui/reminder_page.dart';
import 'features/settings/ui/privacy_page.dart';
import 'features/settings/ui/settings_page.dart';

final routes = <String, Widget Function(BuildContext)>{
  App.route: (_) => const App(),
  LoginPage.route: (_) => const LoginPage(),
  SignupPage.route: (_) => const SignupPage(),
  HomePage.route: (_) => const HomePage(),
  NotePage.route: (_) => const NotePage(),
  ReminderPage.route: (_) => const ReminderPage(),
  SettingsPage.route: (_) => const SettingsPage(),
  ForgotPasswordPage.route: (_) => const ForgotPasswordPage(),
  PrivacyPage.route: (_) => const PrivacyPage(),
};
