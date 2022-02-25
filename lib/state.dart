import 'package:mobipad/features/reminder/state.dart';
import 'package:mobipad/features/settings/state.dart';

import 'features/forgot_password/state.dart';
import 'features/home/state.dart';
import 'features/login/state.dart';
import 'features/note/state.dart';
import 'features/todo/state.dart';

class AppState {
  LoginState loginState;
  HomeState homeState;
  NoteState noteState;
  TodoState todoState;
  SettingsState settingsState;
  ForgotPasswordState forgotPasswordState;
  ReminderState reminderState;

  AppState({
    this.loginState,
    this.homeState,
    this.noteState,
    this.todoState,
    this.settingsState,
    this.forgotPasswordState,
    this.reminderState,
  });

  AppState.initial()
      : loginState = LoginState.initial(),
        homeState = HomeState.initial(),
        noteState = NoteState.initial(),
        todoState = TodoState.initial(),
        settingsState = SettingsState.initial(),
        forgotPasswordState = ForgotPasswordState.initial(),
        reminderState = ReminderState.initial();
}
