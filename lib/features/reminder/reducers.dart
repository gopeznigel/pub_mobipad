import 'package:mobipad/features/reminder/actions.dart';
import 'package:redux/redux.dart';

import 'state.dart';

final Reducer<ReminderState> reminderStateReducer = combineReducers([
  TypedReducer<ReminderState, InitReminder>(_initReminderReducer),
  TypedReducer<ReminderState, ScheduleReminderSuccessful>(_scheduleRemindeSuccessfulReducer),
  TypedReducer<ReminderState, ClearReminderSucceeded>(
      _clearReminderSucceededReducer),
  TypedReducer<ReminderState, ClearReminderFailed>(_clearReminderFailedReducer),
]);

ReminderState _initReminderReducer(ReminderState state, InitReminder action) =>
    state
      ..item = action.item
      ..type = action.type
      ..remId = action.remId
      ..exception = null;

ReminderState _scheduleRemindeSuccessfulReducer(
        ReminderState state, ScheduleReminderSuccessful action) =>
    state
      ..remId = action.remId
      ..exception = null;

ReminderState _clearReminderSucceededReducer(
        ReminderState state, ClearReminderSucceeded action) =>
    state
      ..remId = null
      ..exception = null;

ReminderState _clearReminderFailedReducer(
        ReminderState state, ClearReminderFailed action) =>
    state..exception = action.exception;
