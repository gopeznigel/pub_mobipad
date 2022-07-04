import 'package:flutter/material.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/exception/action_exception.dart';

import 'dtos.dart';

@immutable
class SaveNewNote {
  final NoteDto newNote;

  const SaveNewNote({required this.newNote});

  @override
  String toString() => 'SaveNewNote  { newNote: $newNote }';
}

@immutable
class SaveNewNoteSuccessful {
  final NoteDto note;

  const SaveNewNoteSuccessful({required this.note});

  @override
  String toString() => 'SaveNewNoteSuccessful { note: $note }';
}

@immutable
class SaveNewNoteFailed {
  final ActionException exception;

  const SaveNewNoteFailed({required this.exception});

  @override
  String toString() => 'SaveNewNoteFailed { exception: $exception }';
}

@immutable
class SetNoteStatus {
  const SetNoteStatus({required this.status});

  final NoteStatusEnum status;

  @override
  String toString() => 'SetNoteStatus {status: $status}';
}

@immutable
class SaveNote {
  final NoteDto note;

  const SaveNote({required this.note});

  @override
  String toString() => 'SaveNote { note: $note }';
}

@immutable
class PinNote {
  final bool pin;
  final NoteDto note;

  const PinNote({required this.pin, required this.note});

  @override
  String toString() => 'PinNote { pin: $pin, note: $note }';
}

@immutable
class ArchiveNote {
  final NoteDto note;

  const ArchiveNote({required this.note});

  @override
  String toString() => 'ArchiveNote { note: $note }';
}

@immutable
class UnarchiveNote {
  final NoteDto note;

  const UnarchiveNote({required this.note});

  @override
  String toString() => 'UnarchiveNote { note: $note }';
}

@immutable
class DeleteNote {
  final NoteDto note;

  const DeleteNote({required this.note});

  @override
  String toString() => 'DeleteNote { note: $note }';
}

@immutable
class RestoreNote {
  final NoteDto note;

  const RestoreNote({required this.note});

  @override
  String toString() => 'RestoreNote { note: $note }';
}

@immutable
class UpdatedNote {
  final NoteDto note;

  const UpdatedNote({required this.note});

  @override
  String toString() => 'UpdatedNote { note: $note }';
}

@immutable
class PermanentDeleteNote {
  final NoteDto note;

  const PermanentDeleteNote({required this.note});

  @override
  String toString() => 'PermanentDeleteNote { note: $note }';
}

@immutable
class PermanentDeleteNoteSuccessful {
  @override
  String toString() => 'PermanentDeleteNoteSuccessful';
}

@immutable
class PermanentDeleteNoteFailed {
  final ActionException exception;

  const PermanentDeleteNoteFailed({required this.exception});

  @override
  String toString() => 'PermanentDeleteNoteFailed { exception: $exception }';
}

@immutable
class EditNote {
  @override
  String toString() => 'EditNote';
}

@immutable
class CancelEditNote {
  @override
  String toString() => 'EditNote';
}

@immutable
class UpdateTitle {
  final String title;

  const UpdateTitle({required this.title});

  @override
  String toString() => 'UpdateTitle { title: $title }';
}

@immutable
class UpdateNoteBody {
  final String body;

  const UpdateNoteBody({required this.body});

  @override
  String toString() => 'UpdateNoteBody { body: $body }';
}

@immutable
class AddTodo {
  final String todo;

  const AddTodo({required this.todo});

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

@immutable
class RemoveTodo {
  final TodoDto todo;

  const RemoveTodo({required this.todo});

  @override
  String toString() => 'RemoveTodo { todo: $todo }';
}

@immutable
class ToggleTodo {
  final NoteDto note;
  final TodoDto todo;

  const ToggleTodo({required this.todo, required this.note});

  @override
  String toString() => 'ToggleTodo { note: $note, todo: $todo }';
}

@immutable
class EditTodo {
  final NoteDto note;
  final TodoDto todo;
  final String newTodoText;

  const EditTodo(
      {required this.todo, required this.note, required this.newTodoText});

  @override
  String toString() =>
      'EditTodo { note: $note, todo: $todo, newTodoText: $newTodoText }';
}

@immutable
class ReorderTodo {
  final NoteDto note;
  final int newIndex;
  final int oldIndex;

  const ReorderTodo({
    required this.note,
    required this.newIndex,
    required this.oldIndex,
  });

  @override
  String toString() =>
      'ReorderTodo { note: $note, newIndex: $newIndex, oldIndex: $oldIndex }';
}

class CleanNotePage {
  @override
  String toString() => 'CleanNotePage';
}
