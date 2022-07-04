import 'package:mobipad/features/login/actions.dart';
import 'package:redux/redux.dart';

import 'features/home/reducers.dart';
import 'features/login/reducers.dart';
import 'features/note/reducers.dart';
import 'features/reminder/reducers.dart';
import 'features/settings/reducers.dart';
import 'state.dart';

final Reducer<AppState> appStateReducer = combineReducers([
  TypedReducer<AppState, dynamic>(_loginStateReducer),
  TypedReducer<AppState, dynamic>(_homeStateReducer),
  TypedReducer<AppState, dynamic>(_noteStateReducer),
  TypedReducer<AppState, dynamic>(_reminderStateReducer),
  TypedReducer<AppState, dynamic>(_settingsStateReducer),
  TypedReducer<AppState, LogoutSucceeded>(_logoutSucceededReducer),
]);

AppState _loginStateReducer(AppState state, dynamic action) => state.rebuild(
    (b) => b..loginState.replace(loginStateReducer(state.loginState, action)));

AppState _homeStateReducer(AppState state, dynamic action) => state.rebuild(
    (b) => b..homeState.replace(homeStateReducer(state.homeState, action)));

AppState _noteStateReducer(AppState state, dynamic action) => state.rebuild(
    (b) => b..noteState.replace(noteStateReducer(state.noteState, action)));

AppState _reminderStateReducer(AppState state, dynamic action) =>
    state.rebuild((b) => b
      ..reminderState
          .replace(reminderStateReducer(state.reminderState, action)));

AppState _settingsStateReducer(AppState state, dynamic action) =>
    state.rebuild((b) => b
      ..settingsState
          .replace(settingsStateReducer(state.settingsState, action)));

AppState _logoutSucceededReducer(AppState state, LogoutSucceeded action) =>
    state = AppState.initial();
