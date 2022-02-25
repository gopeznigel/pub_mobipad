import 'package:redux/redux.dart';

import '../../exception/action_exception.dart';
import '../../state.dart';
import 'actions.dart';
import 'api.dart';

List<Middleware<AppState>> getMiddleware(NoteApi noteApi) => [
      ApiIntegration(noteApi).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this._api);

  final NoteApi _api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, SaveNote>(_handleSaveNote),
        TypedMiddleware<AppState, UpdateNote>(_handleUpdateNote),
        TypedMiddleware<AppState, DeleteNote>(_handleDeleteNote),
        TypedMiddleware<AppState, FindNote>(_handleFindNote),
        TypedMiddleware<AppState, MoveToTrash>(_handleMoveToTrash),
        TypedMiddleware<AppState, MoveToArchive>(_handleMoveToArchive),
        TypedMiddleware<AppState, Restore>(_handleRestore),
        TypedMiddleware<AppState, Unarchive>(_handleUnarchive),
      ];

  void _handleFindNote(
      Store<AppState> store, FindNote action, NextDispatcher next) {
    Future<void> _findNote(Store<AppState> store, FindNote action) async {
      try {
        var note = await _api.getNoteById(action.noteId);
        store.dispatch(FindNoteSucceeded(note));
      } on Exception catch (exception) {
        store.dispatch(FindNoteFailed(ActionException(exception, action)));
      }
    }

    _findNote(store, action);
    next(action);
  }

  void _handleSaveNote(
      Store<AppState> store, SaveNote action, NextDispatcher next) {
    Future<void> _saveNote(Store<AppState> store, SaveNote action) async {
      try {
        var note = await _api.addNote(action.note, store.state.homeState.noteList);
        store.dispatch(SaveNoteSucceeded(note));
      } on Exception catch (exception) {
        store.dispatch(SaveNoteFailed(ActionException(exception, action)));
      }
    }

    _saveNote(store, action);
    next(action);
  }

  void _handleUpdateNote(
      Store<AppState> store, UpdateNote action, NextDispatcher next) {
    Future<void> _updateNote(Store<AppState> store, UpdateNote action) async {
      try {
        await _api.updateNote(action.note);
        store.dispatch(UpdateNoteSucceeded());
      } on Exception catch (exception) {
        store.dispatch(UpdateNoteFailed(ActionException(exception, action)));
      }
    }

    _updateNote(store, action);
    next(action);
  }

  void _handleDeleteNote(
      Store<AppState> store, DeleteNote action, NextDispatcher next) {
    Future<void> _deleteNote(Store<AppState> store, DeleteNote action) async {
      try {
        await _api.removeNote(action.noteId);
        store.dispatch(DeleteNoteSucceeded());
      } on Exception catch (exception) {
        store.dispatch(DeleteNoteFailed(ActionException(exception, action)));
      }
    }

    _deleteNote(store, action);
    next(action);
  }

  void _handleMoveToTrash(
      Store<AppState> store, MoveToTrash action, NextDispatcher next) {
    Future<void> _moveToTrash(Store<AppState> store, MoveToTrash action) async {
      try {
        await _api.moveToTrash(action.note);
        store.dispatch(MoveToTrashSucceeded());
      } on Exception catch (exception) {
        store.dispatch(MoveToTrashFailed(ActionException(exception, action)));
      }
    }

    _moveToTrash(store, action);
    next(action);
  }

  void _handleMoveToArchive(
      Store<AppState> store, MoveToArchive action, NextDispatcher next) {
    Future<void> _moveToArchive(Store<AppState> store, MoveToArchive action) async {
      try {
        await _api.moveToArchive(action.note);
        store.dispatch(MoveToArchiveSucceeded());
      } on Exception catch (exception) {
        store.dispatch(MoveToArchiveFailed(ActionException(exception, action)));
      }
    }
    
    _moveToArchive(store, action);
    next(action);
  }

  void _handleUnarchive(
      Store<AppState> store, Unarchive action, NextDispatcher next) {
    Future<void> _unarchive(Store<AppState> store, Unarchive action) async {
      try {
        await _api.unarchive(action.note);
        store.dispatch(UnarchiveSucceeded());
      } on Exception catch (exception) {
        store.dispatch(UnarchiveFailed(ActionException(exception, action)));
      }
    }

    _unarchive(store, action);
    next(action);
  }

  void _handleRestore(
      Store<AppState> store, Restore action, NextDispatcher next) {
    Future<void> _restore(Store<AppState> store, Restore action) async {
      try {
        await _api.restore(action.note);
        store.dispatch(RestoreSucceeded());
      } on Exception catch (exception) {
        store.dispatch(RestoreFailed(ActionException(exception, action)));
      }
    }

    _restore(store, action);
    next(action);
  }
}
