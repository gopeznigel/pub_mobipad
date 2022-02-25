import '../../../exception/action_exception.dart';
import '../../../state.dart';

class SettingsPageViewModel {
  final AppState _state;

  SettingsPageViewModel(this._state);

  String get userId => _state.loginState.user.userId;
  String get email => _state.loginState.user.email;
  String get sorting => _state.settingsState.sorting;
  String get dateTimeDisplay => _state.settingsState.dateTimeDisplay;
  int get fontSize => _state.settingsState.fontSize;
  ActionException get exception => _state.settingsState.exception;
}
