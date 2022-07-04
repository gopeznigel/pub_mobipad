import 'package:mobipad/features/settings/actions.dart';
import 'package:mobipad/features/settings/state.dart';
import 'package:redux/redux.dart';

final Reducer<SettingsState> settingsStateReducer = combineReducers([
  TypedReducer<SettingsState, LoadFontSize>(_loadFontSizeReducer),
  TypedReducer<SettingsState, LoadDateTimeDisplay>(_loadDateTimeDisplayReducer),
  TypedReducer<SettingsState, LoadSort>(_loadSortReducer),
]);

SettingsState _loadFontSizeReducer(SettingsState state, LoadFontSize action) =>
    state.rebuild((b) => b..selectedFontSize = action.fontSize);

SettingsState _loadDateTimeDisplayReducer(
        SettingsState state, LoadDateTimeDisplay action) =>
    state.rebuild((b) => b..selectedDateTimeDisplay = action.display);

SettingsState _loadSortReducer(SettingsState state, LoadSort action) =>
    state.rebuild((b) => b..selectedSorting = action.sort);
