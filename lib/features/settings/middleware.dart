import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/settings/actions.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../state.dart';

List<Middleware<AppState>> getMiddleware() => [
      ApiIntegration().getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration();

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, SetFontSize>(_handleSetFontSize),
        TypedMiddleware<AppState, GetFontSize>(_handleGetFontSize),
        TypedMiddleware<AppState, SetDateTimeDisplay>(
            _handleSetDateTimeDisplay),
        TypedMiddleware<AppState, GetDateTimeDisplay>(
            _handleGetDateTimeDisplay),
      ];

  void _handleSetFontSize(
      Store<AppState> store, SetFontSize action, NextDispatcher next) {
    Future<void> _setFontSize(Store<AppState> store, SetFontSize action) async {
      try {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setInt('fontSize', action.fontSize);
        store.dispatch(SetFontSizeSucceeded());
      } on Exception catch (exception) {
        store.dispatch(SetFontSizeFailed(ActionException(exception, action)));
      }
    }

    _setFontSize(store, action);
    next(action);
  }

  void _handleGetFontSize(
      Store<AppState> store, GetFontSize action, NextDispatcher next) {
    Future<void> _getFontSize(Store<AppState> store, GetFontSize action) async {
      try {
        var prefs = await SharedPreferences.getInstance();
        var fontSize = prefs.getInt('fontSize') ?? 50;
        store.dispatch(GetFontSizeSucceeded(fontSize));
      } on Exception catch (exception) {
        store.dispatch(GetFontSizeFailed(ActionException(exception, action)));
      }
    }

    _getFontSize(store, action);
    next(action);
  }

  void _handleSetDateTimeDisplay(
      Store<AppState> store, SetDateTimeDisplay action, NextDispatcher next) {
    Future<void> _setDateTimeDisplay(
        Store<AppState> store, SetDateTimeDisplay action) async {
      try {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('dateTimeDisplay', action.display);
        store.dispatch(SetDateTimeDisplaySucceeded());
      } on Exception catch (exception) {
        store.dispatch(
            SetDateTimeDisplayFailed(ActionException(exception, action)));
      }
    }

    _setDateTimeDisplay(store, action);
    next(action);
  }

  void _handleGetDateTimeDisplay(
      Store<AppState> store, GetDateTimeDisplay action, NextDispatcher next) {
    Future<void> _getDateTimeDisplay(
        Store<AppState> store, GetDateTimeDisplay action) async {
      try {
        var prefs = await SharedPreferences.getInstance();
        var dateTimeDisplay = prefs.getString('dateTimeDisplay') ?? 'Simple';
        store.dispatch(GetDateTimeDisplaySucceeded(dateTimeDisplay));
      } on Exception catch (exception) {
        store.dispatch(
            GetDateTimeDisplayFailed(ActionException(exception, action)));
      }
    }

    _getDateTimeDisplay(store, action);
    next(action);
  }
}
