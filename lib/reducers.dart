import 'package:redux/redux.dart';

import 'features/forgot_password/reducers.dart';
import 'features/home/reducers.dart';
import 'features/login/reducers.dart';
import 'features/note/reducers.dart';
import 'features/reminder/reducers.dart';
import 'features/settings/reducers.dart';
import 'features/todo/reducers.dart';
import 'state.dart';

final Reducer<AppState> appStateReducer = combineReducers([
  TypedReducer<AppState, dynamic>(_loginStateReducer),
  TypedReducer<AppState, dynamic>(_homeStateReducer),
  TypedReducer<AppState, dynamic>(_noteStateReducer),
  TypedReducer<AppState, dynamic>(_todoStateReducer),
  TypedReducer<AppState, dynamic>(_settingsStateReducer),
  TypedReducer<AppState, dynamic>(_forgotPasswordStateReducer),
  TypedReducer<AppState, dynamic>(_reminderStateReducer),
]);

AppState _loginStateReducer(AppState state, dynamic action) {
  return state..loginState = loginStateReducer(state.loginState, action);
}

AppState _noteStateReducer(AppState state, dynamic action) {
  return state..noteState = noteStateReducer(state.noteState, action);
}

AppState _homeStateReducer(AppState state, dynamic action) {
  return state..homeState = homeStateReducer(state.homeState, action);
}

AppState _todoStateReducer(AppState state, dynamic action) {
  return state..todoState = todoStateReducer(state.todoState, action);
}

AppState _settingsStateReducer(AppState state, dynamic action) {
  return state
    ..settingsState = settingsStateReducer(state.settingsState, action);
}

AppState _forgotPasswordStateReducer(AppState state, dynamic action) {
  return state
    ..forgotPasswordState =
        forgotPasswordStateReducer(state.forgotPasswordState, action);
}

AppState _reminderStateReducer(AppState state, dynamic action) {
  return state
    ..reminderState = reminderStateReducer(state.reminderState, action);
}
