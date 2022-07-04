import 'package:flutter/material.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/note/ui/note_page.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/utils/reminder_sched_util.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/subjects.dart';

import 'actions.dart';
import 'api.dart';

List<Middleware<AppState>> getMiddleware(
        GlobalKey<NavigatorState> navigatorKey,
        ReminderApi reminderApi,
        BehaviorSubject<String> selectNotificationSubject) =>
    [
      ApiIntegration(reminderApi).getMiddlewareBindings(),
      NotificationListener(navigatorKey, selectNotificationSubject)
          .getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this.api);

  final ReminderApi api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, ScheduleReminder>(_handleScheduleReminder),
        TypedMiddleware<AppState, RescheduleReminder>(
            _handleRescheduleReminder),
        TypedMiddleware<AppState, ClearReminder>(_handleClearReminder),
        TypedMiddleware<AppState, ClearAllReminder>(_handleClearAllReminder),
      ];

  void _handleScheduleReminder(
      Store<AppState> store, ScheduleReminder action, NextDispatcher next) {
    Future<void> _scheduleReminder(
        Store<AppState> store, ScheduleReminder action) async {
      try {
        var remId = await api.setupReminder(
          action.note.id!,
          action.note.title ?? '',
          ReminderUtil.getReminderBody(action.note),
          action.reminder.reminderStart!.asList(),
          action.reminder.selectedRepeat,
        );

        // save to firebase
        store
          ..dispatch(UpdateNoteReminder(
              reminder: (action.reminder.toBuilder()..remId = remId).build(),
              note: action.note))
          ..dispatch(ScheduleReminderSuccessful());
      } on Exception catch (exception) {
        store.dispatch(ScheduleReminderFailed(
            exception: ActionException(exception, action)));
      }
    }

    next(action);
    _scheduleReminder(store, action);
  }

  void _handleRescheduleReminder(
      Store<AppState> store, RescheduleReminder action, NextDispatcher next) {
    Future<void> _rescheduleReminder(
        Store<AppState> store, RescheduleReminder action) async {
      await api.resetupReminder(
        action.note.id!,
        action.note.title ?? '',
        ReminderUtil.getReminderBody(action.note),
        action.reminder.reminderStart!.asList(),
        action.reminder.remId!,
        action.reminder.selectedRepeat,
      );
    }

    _rescheduleReminder(store, action);
    next(action);
  }

  void _handleClearReminder(
      Store<AppState> store, ClearReminder action, NextDispatcher next) {
    Future<void> _clearReminder(
        Store<AppState> store, ClearReminder action) async {
      try {
        await api.cancelReminder(action.remId);
        store
          ..dispatch(ClearReminderSucceeded())
          ..dispatch(ClearNoteReminder(note: action.note));
      } on Exception catch (exception) {
        store.dispatch(
            ClearReminderFailed(exception: ActionException(exception, action)));
      }
    }

    _clearReminder(store, action);
    next(action);
  }

  void _handleClearAllReminder(
      Store<AppState> store, ClearAllReminder action, NextDispatcher next) {
    Future<void> _clearAllReminder(
        Store<AppState> store, ClearAllReminder action) async {
      await api.cancelAllReminder();
    }

    _clearAllReminder(store, action);
    next(action);
  }
}

class NotificationListener {
  const NotificationListener(
      this._navigatorKey, this._selectNotificationSubject);

  final BehaviorSubject<String> _selectNotificationSubject;
  final GlobalKey<NavigatorState> _navigatorKey;

  NavigatorState get _navigatorState => _navigatorKey.currentState!;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, NotificationClickListener>(
            _handleNotificationClickListener),
        TypedMiddleware<AppState, DisposeNotificationClickListener>(
            _handleDisposeNotificationClickListener),
      ];

  void _handleNotificationClickListener(Store<AppState> store,
      NotificationClickListener action, NextDispatcher next) {
    Future<void> _notificationListener(
        Store<AppState> store, NotificationClickListener action) async {
      _selectNotificationSubject.stream.listen((String payload) async {
        // find the correct note using noteId/payload
        store.dispatch(SelectANote(noteId: payload.toString()));
        // open note page
        await _navigatorState.pushNamed(NotePage.route);
      });
    }

    _notificationListener(store, action);
    next(action);
  }

  void _handleDisposeNotificationClickListener(Store<AppState> store,
      DisposeNotificationClickListener action, NextDispatcher next) {
    Future<void> _disposeNotificationListener(
        Store<AppState> store, DisposeNotificationClickListener action) async {
      await _selectNotificationSubject.close();
    }

    _disposeNotificationListener(store, action);
    next(action);
  }
}
