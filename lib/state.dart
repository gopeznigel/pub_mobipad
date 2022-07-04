/// Run the command below to generate g.dart files
/// '''flutter pub run build_runner watch'''

import 'package:built_value/built_value.dart';
import 'package:mobipad/features/forgot_password/state.dart';
import 'package:mobipad/features/home/state.dart';
import 'package:mobipad/features/login/state.dart';
import 'package:mobipad/features/note/state.dart';
import 'package:mobipad/features/reminder/state.dart';
import 'package:mobipad/features/settings/state.dart';

part 'state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState([void Function(AppStateBuilder b) updates]) = _$AppState;

  factory AppState.initial() => _$AppState._(
        loginState: LoginState.initial(),
        homeState: HomeState.initial(),
        noteState: NoteState.initial(),
        reminderState: ReminderState.initial(),
        settingsState: SettingsState.initial(),
        forgotPasswordState: ForgotPasswordState.initial(),
      );

  AppState._();

  LoginState get loginState;
  HomeState get homeState;
  NoteState get noteState;
  ReminderState get reminderState;
  SettingsState get settingsState;
  ForgotPasswordState get forgotPasswordState;
}
