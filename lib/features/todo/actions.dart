import 'package:flutter/foundation.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/home/model.dart';

@immutable
class SaveTodo {
  SaveTodo(this.todo) : assert(todo != null);

  final Note todo;

  @override
  String toString() => 'SaveTodo {todo: $todo}';
}

@immutable
class SaveTodoSucceeded {
  SaveTodoSucceeded(this.todo) : assert(todo != null);

  final Note todo;

  @override
  String toString() => 'SaveTodoSucceeded {todo: $todo}';
}

@immutable
class SaveTodoFailed {
  SaveTodoFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'SaveTodoFailed {exception: $exception}';
}

@immutable
class UpdateTodo {
  UpdateTodo(this.todo) : assert(todo != null);

  final Note todo;

  @override
  String toString() => 'UpdateTodo {todo: $todo}';
}

@immutable
class UpdateTodoSucceeded {
  @override
  String toString() => 'UpdateTodoSucceeded';
}

@immutable
class UpdateTodoFailed {
  UpdateTodoFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'UpdateTodoFailed {exception: $exception}';
}

@immutable
class EditTodo {
  @override
  String toString() => 'EditTodo';
}

@immutable
class CancelEditTodo {
  @override
  String toString() => 'CancelEditTodo';
}

@immutable
class ResetTodoPage {
  @override
  String toString() => 'ResetTodoPage';
}

@immutable
class OpenExistingTodo {
  OpenExistingTodo(this.todo) : assert(todo != null);

  final Note todo;

  @override
  String toString() => 'OpenExistingTodo {todo: ${todo.title}}';
}

@immutable
class OpenNewTodo {
  @override
  String toString() => 'OpenNewTodo';
}

@immutable
class DeleteTodo {
  DeleteTodo(this.todoId) : assert(todoId != null);

  final String todoId;

  @override
  String toString() => 'DeleteTodo {todoId: $todoId}';
}

@immutable
class DeleteTodoSucceeded {
  @override
  String toString() => 'DeleteTodoSucceeded';
}

@immutable
class DeleteTodoFailed {
  DeleteTodoFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'DeleteTodoFailed {exception: $exception}';
}

@immutable
class FindTodo {
  FindTodo(this.todoId) : assert(todoId != null);

  final String todoId;

  @override
  String toString() => 'FindTodo {todoId: $todoId}';
}

@immutable
class FindTodoSucceeded {
  FindTodoSucceeded(this.todo) : assert(todo != null);

  final Note todo;

  @override
  String toString() => 'FindTodoSucceeded {todo: $todo}';
}

@immutable
class FindTodoFailed {
  FindTodoFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'FindTodoFailed {exception: $exception}';
}