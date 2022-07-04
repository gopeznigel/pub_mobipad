import 'package:mobipad/core/actions.dart';
import 'package:mobipad/features/settings/actions.dart';
import 'package:mobipad/features/settings/api.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> getMiddleware(SettingsApi settingsApi) => [
      ApiIntegration(settingsApi).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this.api);

  final SettingsApi api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, SetFontSize>(_handleSetFontSize),
        TypedMiddleware<AppState, SetDateTimeDisplay>(
            _handleSetDateTimeDisplay),
        TypedMiddleware<AppState, SetSort>(_handleSetSort),
        TypedMiddleware<AppState, GetFontSize>(_handleGetFontSize),
        TypedMiddleware<AppState, GetDateTimeDisplay>(
            _handleGetDateTimeDisplay),
        TypedMiddleware<AppState, GetSort>(_handleGetSort),
      ];

  void _handleSetFontSize(
      Store<AppState> store, SetFontSize action, NextDispatcher next) {
    Future<void> _setFontSize(Store<AppState> store, SetFontSize action) async {
      final success = await api.setFontSize(action.fontSize);

      if (success) {
        store.dispatch(LoadFontSize(action.fontSize));
      }
    }

    _setFontSize(store, action);
    next(action);
  }

  void _handleSetDateTimeDisplay(
      Store<AppState> store, SetDateTimeDisplay action, NextDispatcher next) {
    Future<void> _setDateTimeDisplay(
        Store<AppState> store, SetDateTimeDisplay action) async {
      final success = await api.setDateTimeDisplay(action.display);

      if (success) {
        store.dispatch(LoadDateTimeDisplay(action.display));
      }
    }

    _setDateTimeDisplay(store, action);
    next(action);
  }

  void _handleSetSort(
      Store<AppState> store, SetSort action, NextDispatcher next) {
    Future<void> _setSort(Store<AppState> store, SetSort action) async {
      final success = await api.setSort(action.sort);

      if (success) {
        store
          ..dispatch(LoadSort(action.sort))
          ..dispatch(GetSortedNotes(sort: action.sort));
      }
    }

    _setSort(store, action);
    next(action);
  }

  void _handleGetFontSize(
      Store<AppState> store, GetFontSize action, NextDispatcher next) {
    Future<void> _getFontSize(Store<AppState> store, GetFontSize action) async {
      final value = await api.getFontSize();

      if (value != null) {
        store.dispatch(LoadFontSize(value));
      }
    }

    _getFontSize(store, action);
    next(action);
  }

  void _handleGetDateTimeDisplay(
      Store<AppState> store, GetDateTimeDisplay action, NextDispatcher next) {
    Future<void> _getDateTimeDisplay(
        Store<AppState> store, GetDateTimeDisplay action) async {
      final value = await api.getDateTimeDisplay();

      if (value != null) {
        store.dispatch(LoadDateTimeDisplay(value));
      }
    }

    _getDateTimeDisplay(store, action);
    next(action);
  }

  void _handleGetSort(
      Store<AppState> store, GetSort action, NextDispatcher next) {
    Future<void> _getSort(Store<AppState> store, GetSort action) async {
      final value = await api.getSort();

      if (value != null) {
        store.dispatch(LoadSort(value));
      }
    }

    _getSort(store, action);
    next(action);
  }
}
