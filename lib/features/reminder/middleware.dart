import 'package:flutter/material.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/home/model.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/ui/note_page.dart';
import 'package:mobipad/features/reminder/helper.dart';
import 'package:mobipad/features/todo/actions.dart';
import 'package:mobipad/features/todo/ui/todo_page.dart';
import 'package:redux/redux.dart';
import 'package:rxdart/subjects.dart';

import '../../state.dart';
import 'actions.dart';

List<Middleware<AppState>> getMiddleware(
        GlobalKey<NavigatorState> navigatorKey,
        ReminderHelper helper,
        BehaviorSubject<String> selectNotificationSubject) =>
    [
      ApiIntegration(helper).getMiddlewareBindings(),
      NotificationListener(navigatorKey, selectNotificationSubject)
          .getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this._helper);

  final ReminderHelper _helper;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, ScheduleReminder>(_handleScheduleReminder),
        TypedMiddleware<AppState, RescheduleReminder>(
            _handleRescheduleReminder),
        TypedMiddleware<AppState, ClearReminder>(_handleClearReminder),
        TypedMiddleware<AppState, ClearAllReminder>(_handleClearAllReminder),
      ];

  void _handleScheduleReminder(
      Store<AppState> store, ScheduleReminder action, NextDispatcher next) {
    Future<void> _scheduleReminderSucceeded(
        Store<AppState> store, ScheduleReminder action) async {
      var remId = await _helper.setupReminder(
          action.id, action.type, action.title, action.body, action.schedule);
      store.dispatch(ScheduleReminderSuccessful(remId));
      // save to database
      store.dispatch(UpdateNote(
        Note(
          id: action.item.id,
          title: action.item.title,
          todoList: action.item.todoList,
          description: action.item.description,
          dateCreated: action.item.dateCreated,
          dateModified: action.item.dateModified,
          dateDeleted: action.item.dateDeleted,
          dateArchived: action.item.dateArchived,
          pinned: action.item.pinned,
          reminder: Reminder(
            remId: remId,
            reminderStart: action.schedule,
            days: action.days,
            selectedRepeat: action.selectedRepeat,
          ),
        ),
      ));
    }

    _scheduleReminderSucceeded(store, action);
    next(action);
  }

  void _handleRescheduleReminder(
      Store<AppState> store, RescheduleReminder action, NextDispatcher next) {
    Future<void> _scheduleReminderSucceeded(
        Store<AppState> store, RescheduleReminder action) async {
      await _helper.resetupReminder(action.id, action.type, action.title,
          action.body, action.schedule, action.remId);
    }

    _scheduleReminderSucceeded(store, action);
    next(action);
  }

  void _handleClearReminder(
      Store<AppState> store, ClearReminder action, NextDispatcher next) {
    Future<void> _scheduleReminderSucceeded(
        Store<AppState> store, ClearReminder action) async {
      try {
        await _helper.cancelReminder(action.remId);
        store.dispatch(ClearReminderSucceeded());
      } on Exception catch (exception) {
        store.dispatch(ClearReminderFailed(ActionException(exception, action)));
      }
    }

    _scheduleReminderSucceeded(store, action);
    next(action);
  }

  void _handleClearAllReminder(
      Store<AppState> store, ClearAllReminder action, NextDispatcher next) {
    Future<void> _clearAllReminderSucceeded(
        Store<AppState> store, ClearAllReminder action) async {
      await _helper.cancelAllReminder();
    }

    _clearAllReminderSucceeded(store, action);
    next(action);
  }
}

class NotificationListener {
  const NotificationListener(
      this._navigatorKey, this._selectNotificationSubject);

  final BehaviorSubject<String> _selectNotificationSubject;
  final GlobalKey<NavigatorState> _navigatorKey;

  NavigatorState get _navigatorState => _navigatorKey.currentState;

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
        var split = payload.split(' ');
        if (split[0].contains('note')) {
          // find the correct note using noteId
          store.dispatch(FindNote(split[1]));
          // open it as note
          await _navigatorState.pushNamed(NotePage.route);
        } else {
          // find the correct todo using todoId
          store.dispatch(FindTodo(split[1]));
          // open it as todo
          await _navigatorState.pushNamed(TodoPage.route);
        }
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
