import 'package:mobipad/features/note/actions.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

final Reducer<TodoState> todoStateReducer = combineReducers([
  TypedReducer<TodoState, OpenNewTodo>(_openNewTodoReducer),
  TypedReducer<TodoState, OpenExistingTodo>(_openExistingTodoReducer),
  TypedReducer<TodoState, SaveTodo>(_saveTodoReducer),
  TypedReducer<TodoState, SaveTodoSucceeded>(_saveTodoReducerSucceeded),
  TypedReducer<TodoState, SaveTodoFailed>(_saveTodoReducerFailed),
  TypedReducer<TodoState, EditTodo>(_editTodoReducer),
  TypedReducer<TodoState, CancelEditTodo>(_cancelEditTodoReducer),
  TypedReducer<TodoState, UpdateTodo>(_updateTodoReducer),
  TypedReducer<TodoState, UpdateTodoSucceeded>(_updateTodoReducerSucceeded),
  TypedReducer<TodoState, UpdateTodoFailed>(_updateTodoReducerFailed),
  TypedReducer<TodoState, ResetTodoPage>(_resetTodoPageReducer),
  TypedReducer<TodoState, MoveToTrash>(_moveToTrashReducer),
  TypedReducer<TodoState, MoveToTrashSucceeded>(_moveToTrashReducerSucceeded),
  TypedReducer<TodoState, MoveToTrashFailed>(_moveToTrashReducerFailed),
  TypedReducer<TodoState, MoveToArchive>(_moveToArchiveReducer),
  TypedReducer<TodoState, MoveToArchiveSucceeded>(
      _moveToArchiveReducerSucceeded),
  TypedReducer<TodoState, MoveToArchiveFailed>(_moveToArchiveReducerFailed),
  TypedReducer<TodoState, Unarchive>(_unarchiveReducer),
  TypedReducer<TodoState, UnarchiveSucceeded>(_unarchiveReducerSucceeded),
  TypedReducer<TodoState, UnarchiveFailed>(_unarchiveReducerFailed),
  TypedReducer<TodoState, Restore>(_restoreReducer),
  TypedReducer<TodoState, RestoreSucceeded>(_restoreReducerSucceeded),
  TypedReducer<TodoState, RestoreFailed>(_restoreReducerFailed),
  TypedReducer<TodoState, DeleteTodo>(_deleteTodoReducer),
  TypedReducer<TodoState, DeleteTodoSucceeded>(_deleteTodoReducerSucceeded),
  TypedReducer<TodoState, DeleteTodoFailed>(_deleteTodoReducerFailed),
  TypedReducer<TodoState, FindTodo>(_findTodoReducer),
  TypedReducer<TodoState, FindTodoSucceeded>(_findTodoReducerSucceeded),
  TypedReducer<TodoState, FindTodoFailed>(_findTodoReducerFailed),
]);

TodoState _openNewTodoReducer(TodoState state, OpenNewTodo action) => state
  ..isLoading = false
  ..isEditing = true
  ..exception = null
  ..todo = null;

TodoState _openExistingTodoReducer(TodoState state, OpenExistingTodo action) =>
    state
      ..isLoading = false
      ..isEditing = false
      ..exception = null
      ..todo = action.todo;

TodoState _saveTodoReducer(TodoState state, SaveTodo action) => state
  ..isLoading = true
  ..isEditing = false;

TodoState _saveTodoReducerSucceeded(
        TodoState state, SaveTodoSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null
      ..todo = action.todo;

TodoState _saveTodoReducerFailed(TodoState state, SaveTodoFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

TodoState _editTodoReducer(TodoState state, EditTodo action) =>
    state..isEditing = true;

TodoState _cancelEditTodoReducer(TodoState state, CancelEditTodo action) =>
    state..isEditing = false;

TodoState _updateTodoReducer(TodoState state, UpdateTodo action) => state
  ..isEditing = false
  ..todo = action.todo;

TodoState _updateTodoReducerSucceeded(
        TodoState state, UpdateTodoSucceeded action) =>
    state..exception = null;

TodoState _updateTodoReducerFailed(TodoState state, UpdateTodoFailed action) =>
    state..exception = action.exception;

TodoState _resetTodoPageReducer(TodoState state, ResetTodoPage action) => state
  ..isEditing = false
  ..exception = null
  ..isLoading = false
  ..todo = null;

TodoState _moveToTrashReducer(TodoState state, MoveToTrash action) =>
    state..isLoading = true;

TodoState _moveToTrashReducerSucceeded(
        TodoState state, MoveToTrashSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

TodoState _moveToTrashReducerFailed(
        TodoState state, MoveToTrashFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

TodoState _moveToArchiveReducer(TodoState state, MoveToArchive action) =>
    state..isLoading = true;

TodoState _moveToArchiveReducerSucceeded(
        TodoState state, MoveToArchiveSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

TodoState _moveToArchiveReducerFailed(
        TodoState state, MoveToArchiveFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

TodoState _unarchiveReducer(TodoState state, Unarchive action) =>
    state..isLoading = true;

TodoState _unarchiveReducerSucceeded(
        TodoState state, UnarchiveSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

TodoState _unarchiveReducerFailed(TodoState state, UnarchiveFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

TodoState _restoreReducer(TodoState state, Restore action) =>
    state..isLoading = true;

TodoState _restoreReducerSucceeded(TodoState state, RestoreSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

TodoState _restoreReducerFailed(TodoState state, RestoreFailed action) => state
  ..isLoading = false
  ..exception = action.exception;

TodoState _deleteTodoReducer(TodoState state, DeleteTodo action) =>
    state..isLoading = true;

TodoState _deleteTodoReducerSucceeded(
        TodoState state, DeleteTodoSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

TodoState _deleteTodoReducerFailed(TodoState state, DeleteTodoFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

TodoState _findTodoReducer(TodoState state, FindTodo action) =>
    state..isLoading = true;

TodoState _findTodoReducerSucceeded(
        TodoState state, FindTodoSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null
      ..todo = action.todo;

TodoState _findTodoReducerFailed(TodoState state, FindTodoFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;
