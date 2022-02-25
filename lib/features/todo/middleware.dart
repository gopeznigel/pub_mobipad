import 'package:mobipad/features/note/api.dart';
import 'package:redux/redux.dart';

import '../../exception/action_exception.dart';
import '../../state.dart';
import 'actions.dart';

List<Middleware<AppState>> getMiddleware(NoteApi noteApi) => [
      ApiIntegration(noteApi).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this._api);

  final NoteApi _api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, SaveTodo>(_handleSaveTodo),
        TypedMiddleware<AppState, UpdateTodo>(_handleUpdateTodo),
        TypedMiddleware<AppState, DeleteTodo>(_handleDeleteTodo),
        TypedMiddleware<AppState, FindTodo>(_handleFindTodo),
      ];

  void _handleFindTodo(
      Store<AppState> store, FindTodo action, NextDispatcher next) {
    Future<void> _findTodo(Store<AppState> store, FindTodo action) async {
      try {
        var note = await _api.getNoteById(action.todoId);
        store.dispatch(FindTodoSucceeded(note));
      } on Exception catch (exception) {
        store.dispatch(FindTodoFailed(ActionException(exception, action)));
      }
    }

    _findTodo(store, action);
    next(action);
  }

  void _handleSaveTodo(
      Store<AppState> store, SaveTodo action, NextDispatcher next) {
    Future<void> _saveTodo(Store<AppState> store, SaveTodo action) async {
      try {
        var docId = await _api.addNote(action.todo, store.state.homeState.noteList);
        store.dispatch(SaveTodoSucceeded(docId));
      } on Exception catch (exception) {
        store.dispatch(SaveTodoFailed(ActionException(exception, action)));
      }
    }

    _saveTodo(store, action);
    next(action);
  }

  void _handleUpdateTodo(
      Store<AppState> store, UpdateTodo action, NextDispatcher next) {
    Future<void> _updateTodo(Store<AppState> store, UpdateTodo action) async {
      try {
        await _api.updateNote(action.todo);
        store.dispatch(UpdateTodoSucceeded());
      } on Exception catch (exception) {
        store.dispatch(UpdateTodoFailed(ActionException(exception, action)));
      }
    }

    _updateTodo(store, action);
    next(action);
  }

  void _handleDeleteTodo(
      Store<AppState> store, DeleteTodo action, NextDispatcher next) {
    Future<void> _deleteTodo(Store<AppState> store, DeleteTodo action) async {
      try {
        await _api.removeNote(action.todoId);
        store.dispatch(DeleteTodoSucceeded());
      } on Exception catch (exception) {
        store.dispatch(DeleteTodoFailed(ActionException(exception, action)));
      }
    }

    _deleteTodo(store, action);
    next(action);
  }
}
