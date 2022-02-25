import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

final Reducer<SettingsState> settingsStateReducer = combineReducers([
  TypedReducer<SettingsState, UpdateSorting>(_updateSortingReducer),
  TypedReducer<SettingsState, SetFontSize>(_setFontSizeReducer),
  TypedReducer<SettingsState, SetFontSizeFailed>(_setFontSizeReducerFailed),
  TypedReducer<SettingsState, GetFontSizeSucceeded>(
      _getFontSizeReducerSucceeded),
  TypedReducer<SettingsState, GetFontSizeFailed>(_getFontSizeReducerFailed),
  TypedReducer<SettingsState, SetDateTimeDisplay>(_setDateTimeDisplayReducer),
  TypedReducer<SettingsState, SetDateTimeDisplayFailed>(
      _setDateTimeDisplayReducerFailed),
  TypedReducer<SettingsState, GetDateTimeDisplaySucceeded>(
      _getDateTimeDisplayReducerSucceeded),
  TypedReducer<SettingsState, GetDateTimeDisplayFailed>(
      _getDateTimeDisplayReducerFailed),
]);

SettingsState _updateSortingReducer(
        SettingsState state, UpdateSorting action) =>
    state..sorting = action.sortBy;

SettingsState _setFontSizeReducer(SettingsState state, SetFontSize action) =>
    state
      ..fontSize = action.fontSize
      ..exception = null;

SettingsState _setFontSizeReducerFailed(
        SettingsState state, SetFontSizeFailed action) =>
    state..exception = action.exception;

SettingsState _getFontSizeReducerSucceeded(
        SettingsState state, GetFontSizeSucceeded action) =>
    state
      ..fontSize = action.fontSize
      ..exception = null;

SettingsState _getFontSizeReducerFailed(
        SettingsState state, GetFontSizeFailed action) =>
    state..exception = action.exception;

SettingsState _setDateTimeDisplayReducer(
        SettingsState state, SetDateTimeDisplay action) =>
    state
      ..dateTimeDisplay = action.display
      ..exception = null;

SettingsState _setDateTimeDisplayReducerFailed(
        SettingsState state, SetDateTimeDisplayFailed action) =>
    state..exception = action.exception;

SettingsState _getDateTimeDisplayReducerSucceeded(
        SettingsState state, GetDateTimeDisplaySucceeded action) =>
    state
      ..dateTimeDisplay = action.display
      ..exception = null;

SettingsState _getDateTimeDisplayReducerFailed(
        SettingsState state, GetDateTimeDisplayFailed action) =>
    state..exception = action.exception;
