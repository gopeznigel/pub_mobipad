import 'package:mobipad/features/settings/actions.dart';
import 'package:mobipad/features/todo/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../exception/action_exception.dart';
import '../../state.dart';
import '../note/actions.dart';
import 'actions.dart';
import 'api.dart';

List<Middleware<AppState>> getMiddleware(HomeApi homeApi) => [
      ApiIntegration(homeApi).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this._api);

  final HomeApi _api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, FetchNotesSucceeded>(
            _handleFetchNotesSucceeded),
        TypedMiddleware<AppState, GetNoteList>(_handleGetNoteList),
        TypedMiddleware<AppState, InitCollection>(_handleInitCollection),
        TypedMiddleware<AppState, OpenExistingNote>(_handleOpenExistingNote),
        TypedMiddleware<AppState, OpenExistingTodo>(_handleOpenExistingTodo),
        TypedMiddleware<AppState, SortNotes>(_handleSortNotes),
        TypedMiddleware<AppState, DeleteMultiple>(_handleDeleteMultiple),
        TypedMiddleware<AppState, MoveToTrashMultiple>(
            _handleMoveToTrashMultiple),
        TypedMiddleware<AppState, RestoreMultiple>(_handleRestoreMultiple),
        TypedMiddleware<AppState, MoveToArchiveMultiple>(
            _handleMoveToArchiveMultiple),
        TypedMiddleware<AppState, UnarchiveMultiple>(_handleUnarchiveMultiple),
        TypedMiddleware<AppState, UpdatePinnedStatusMultiple>(
            _handleUpdatePinnedStatusMultiple),
      ];

  void _handleFetchNotesSucceeded(
      Store<AppState> store, FetchNotesSucceeded action, NextDispatcher next) {
    Future<void> _fetchNotesSucceeded(
        Store<AppState> store, FetchNotesSucceeded action) async {
      try {
        var prefs = await SharedPreferences.getInstance();
        var sort = prefs.getString('sort') ?? 'modified';
        store.dispatch(GetNoteList(sort));
      } on Exception catch (exception) {
        store.dispatch(FetchNotesFailed(ActionException(exception, action)));
      }
    }

    _fetchNotesSucceeded(store, action);
    next(action);
  }

  void _handleOpenExistingNote(
      Store<AppState> store, OpenExistingNote action, NextDispatcher next) {
    Future<void> _openExistingNote(
        Store<AppState> store, OpenExistingNote action) async {
      store.dispatch(OpenNotePage());
    }

    _openExistingNote(store, action);
    next(action);
  }

  void _handleOpenExistingTodo(
      Store<AppState> store, OpenExistingTodo action, NextDispatcher next) {
    Future<void> _openExistingTodo(
        Store<AppState> store, OpenExistingTodo action) async {
      store.dispatch(OpenTodoPage());
    }

    _openExistingTodo(store, action);
    next(action);
  }

  void _handleGetNoteList(
      Store<AppState> store, GetNoteList action, NextDispatcher next) {
    Future<void> _getNoteList(Store<AppState> store, GetNoteList action) async {
      try {
        store.dispatch(UpdateSorting(action.sort));
        final data = await _api.fetchNotes(action.sort);
        store.dispatch(GetNoteListSucceeded(data));
      } on Exception catch (exception) {
        store.dispatch(FetchNotesFailed(ActionException(exception, action)));
      }
    }

    _getNoteList(store, action);
    next(action);
  }

  void _handleInitCollection(
      Store<AppState> store, InitCollection action, NextDispatcher next) {
    Future<void> _initCollection(
        Store<AppState> store, InitCollection action) async {
      _api.initCollection(action.userId);
    }

    _initCollection(store, action);
    next(action);
  }

  void _handleSortNotes(
      Store<AppState> store, SortNotes action, NextDispatcher next) {
    Future<void> _sortNotes(Store<AppState> store, SortNotes action) async {
      try {
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString('sort', action.sortBy);
        store.dispatch(GetNoteList(action.sortBy));
      } on Exception catch (exception) {
        store.dispatch(FetchNotesFailed(ActionException(exception, action)));
      }
    }

    _sortNotes(store, action);
    next(action);
  }

  void _handleDeleteMultiple(
      Store<AppState> store, DeleteMultiple action, NextDispatcher next) {
    Future<void> _deleteMultiple(
        Store<AppState> store, DeleteMultiple action) async {
      await _api.deleteMultiple(action.notes, action.selectedIndex);
    }

    _deleteMultiple(store, action);
    next(action);
  }

  void _handleMoveToTrashMultiple(
      Store<AppState> store, MoveToTrashMultiple action, NextDispatcher next) {
    Future<void> _moveToTrashMultiple(
        Store<AppState> store, MoveToTrashMultiple action) async {
      await _api.moveToTrashMultiple(action.notes, action.selectedIndex);
    }

    _moveToTrashMultiple(store, action);
    next(action);
  }

  void _handleRestoreMultiple(
      Store<AppState> store, RestoreMultiple action, NextDispatcher next) {
    Future<void> _restoreMultiple(
        Store<AppState> store, RestoreMultiple action) async {
      await _api.restoreMultiple(action.notes, action.selectedIndex);
    }

    _restoreMultiple(store, action);
    next(action);
  }

  void _handleUnarchiveMultiple(
      Store<AppState> store, UnarchiveMultiple action, NextDispatcher next) {
    Future<void> _unarchiveMultiple(
        Store<AppState> store, UnarchiveMultiple action) async {
      await _api.unarchiveMultiple(action.notes, action.selectedIndex);
    }

    _unarchiveMultiple(store, action);
    next(action);
  }

  void _handleMoveToArchiveMultiple(Store<AppState> store,
      MoveToArchiveMultiple action, NextDispatcher next) {
    Future<void> _moveToArchiveMultiple(
        Store<AppState> store, MoveToArchiveMultiple action) async {
      await _api.moveToArchiveMultiple(action.notes, action.selectedIndex);
    }

    _moveToArchiveMultiple(store, action);
    next(action);
  }

  void _handleUpdatePinnedStatusMultiple(Store<AppState> store,
      UpdatePinnedStatusMultiple action, NextDispatcher next) {
    Future<void> _updatePinnedStatusMultiple(
        Store<AppState> store, UpdatePinnedStatusMultiple action) async {
      await _api.updatePinnedStatusMultiple(
          action.notes, action.selectedIndex, action.pinned);
    }

    _updatePinnedStatusMultiple(store, action);
    next(action);
  }
}

List<Middleware<AppState>> getEpicMiddleware(HomeApi homeApi) => [
      EpicApiIntegration(homeApi).getEpicMiddlewareBindings(),
    ].expand((x) => x).toList();

class EpicApiIntegration {
  EpicApiIntegration(this._api);

  final HomeApi _api;

  List<Middleware<AppState>> getEpicMiddlewareBindings() => [
        EpicMiddleware<AppState>(_handleGetNoteStream),
      ];

  Stream<dynamic> _handleGetNoteStream(
      Stream<dynamic> actions, EpicStore<AppState> store) {
        
    return actions.whereType<FetchNotes>().flatMap((action) {
      return _api
          .fetchNotesAsStream()
          .map((notes) => FetchNotesSucceeded())
          .takeUntil(actions.whereType<FetchNotesFailed>());
    });
  }
}
