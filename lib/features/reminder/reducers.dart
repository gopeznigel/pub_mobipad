import 'package:flutter/material.dart';
import 'package:mobipad/constants/reminder_objects.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/core/serializers.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/features/reminder/state.dart';
import 'package:mobipad/utils/reminder_sched_util.dart';
import 'package:redux/redux.dart';

final Reducer<ReminderState> reminderStateReducer = combineReducers([
  TypedReducer<ReminderState, InitReminderSettings>(
      _handleInitReminderSettings),
  TypedReducer<ReminderState, SetOnRepeat>(_handleSetOnRepeat),
  TypedReducer<ReminderState, SetDate>(_handleSetDate),
  TypedReducer<ReminderState, SetTime>(_handleSetTime),
  TypedReducer<ReminderState, AutoSelectWeekDay>(_handleAutoSelectWeekDay),
  TypedReducer<ReminderState, ResetSelectedWeekDay>(
      _handleResetSelectedWeekDay),
  TypedReducer<ReminderState, SetRepeat>(_handleSetRepeat),
  TypedReducer<ReminderState, UpdateReminderDays>(_handleUpdateReminderDays),
  TypedReducer<ReminderState, ResetReminder>(_handleResetReminder),
  TypedReducer<ReminderState, ScheduleReminder>(_handleScheduleReminder),
  TypedReducer<ReminderState, ScheduleReminderSuccessful>(
      _handleScheduleReminderSuccessful),
  TypedReducer<ReminderState, ScheduleReminderFailed>(
      _handleScheduleReminderFailed),
]);

ReminderState _handleInitReminderSettings(
        ReminderState state, InitReminderSettings action) =>
    state.rebuild((b) {
      final date = DateTime.now();
      final time = TimeOfDay.now();

      final initReminder = ReminderDto((b) => b
        ..days.replace(days
            .map((day) =>
                serializers.deserializeWith(ReminderDayDto.serializer, day))
            .toList())
        ..selectedRepeat = 0
        ..reminderStart.replace(_getReminderStart(0, date, time, days)));

      return b
        ..reminder.replace(action.reminder ?? initReminder)
        ..selectedDate = date
        ..selectedTime = time;
    });

ReminderState _handleSetOnRepeat(ReminderState state, SetOnRepeat action) =>
    state.rebuild((b) {
      return b
        ..onRepeat = action.repeat
        ..reminder.reminderStart.replace(_getReminderStart(
            action.repeat ? (b.reminder.selectedRepeat ?? 0) : 0,
            b.selectedDate!,
            b.selectedTime!,
            days));
    });

ReminderState _handleSetDate(ReminderState state, SetDate action) =>
    state.rebuild((b) => b
      ..selectedDate = action.date
      ..reminder.reminderStart.replace(_getReminderStart(
          b.reminder.selectedRepeat ?? 0, action.date, b.selectedTime!, days)));

ReminderState _handleSetTime(ReminderState state, SetTime action) =>
    state.rebuild((b) => b
      ..selectedTime = action.time
      ..reminder.reminderStart.replace(_getReminderStart(
          b.reminder.selectedRepeat ?? 0, b.selectedDate!, action.time, days)));

ReminderState _handleAutoSelectWeekDay(
        ReminderState state, AutoSelectWeekDay action) =>
    state.rebuild((b) {
      var weekday =
          action.selectedDate.weekday == 7 ? 0 : action.selectedDate.weekday;

      var days = b.reminder.days.build().map((day) {
        if (b.reminder.days.build().indexOf(day) == weekday) {
          return ReminderDayDto((b) => b
            ..name = day.name
            ..value = true);
        }

        return day;
      }).toList();

      // days![weekday]['value'] = true;

      return b
        ..reminder.days.replace(days)
        ..reminder.reminderStart.replace(_getReminderStart(
            b.reminder.selectedRepeat!,
            b.selectedDate!,
            b.selectedTime!,
            days
                .map((day) => serializers.serializeWith(
                    ReminderDayDto.serializer, day) as Map<String, dynamic>)
                .toList()));
    });

ReminderState _handleResetSelectedWeekDay(
        ReminderState state, ResetSelectedWeekDay action) =>
    state.rebuild((b) {
      var days = b.reminder.days.build().map((day) {
        return ReminderDayDto((b) => b
          ..name = day.name
          ..value = false);
      }).toList();

      return b
        ..reminder.days.replace(days)
        ..reminder.reminderStart.replace(_getReminderStart(
            b.reminder.selectedRepeat!,
            b.selectedDate!,
            b.selectedTime!,
            days
                .map((day) => serializers.serializeWith(
                    ReminderDayDto.serializer, day) as Map<String, dynamic>)
                .toList()));
    });

ReminderState _handleSetRepeat(ReminderState state, SetRepeat action) =>
    state.rebuild((b) {
      var selectedRepeat = action.repeatValue;

      return b
        ..reminder.selectedRepeat = selectedRepeat
        ..reminder.reminderStart.replace(_getReminderStart(
            selectedRepeat,
            b.selectedDate!,
            b.selectedTime!,
            b.reminder.days
                .build()
                .toList()
                .map((day) => serializers.serializeWith(
                    ReminderDayDto.serializer, day) as Map<String, dynamic>)
                .toList()));
    });

ReminderState _handleUpdateReminderDays(
        ReminderState state, UpdateReminderDays action) =>
    state.rebuild((b) {
      var days = b.reminder.days.build().map((day) {
        if (b.reminder.days.build().indexOf(day) == action.dayIndex) {
          return ReminderDayDto((b) => b
            ..name = day.name
            ..value = action.value);
        }

        return day;
      }).toList();

      return b
        ..reminder.days.replace(days)
        ..reminder.reminderStart.replace(_getReminderStart(
            b.reminder.selectedRepeat!,
            b.selectedDate!,
            b.selectedTime!,
            days
                .map((day) => serializers.serializeWith(
                    ReminderDayDto.serializer, day) as Map<String, dynamic>)
                .toList()));
    });

ReminderState _handleScheduleReminder(
        ReminderState state, ScheduleReminder action) =>
    state.rebuild((b) => b
      ..exception = null
      ..isBusy = true);

ReminderState _handleScheduleReminderSuccessful(
        ReminderState state, ScheduleReminderSuccessful action) =>
    state.rebuild((b) => b..isBusy = false);

ReminderState _handleScheduleReminderFailed(
        ReminderState state, ScheduleReminderFailed action) =>
    state.rebuild((b) => b
      ..isBusy = false
      ..exception = action.exception);

ReminderState _handleResetReminder(ReminderState state, ResetReminder action) =>
    state = ReminderState.initial();

List<int> _getReminderStart(int repeat, DateTime date, TimeOfDay time,
        List<Map<String, dynamic>> days) =>
    ReminderUtil.generateSchedules(
      repeat: repeat,
      date: date,
      time: time,
      days: days,
    );
