import 'package:flutter/foundation.dart';

import '../../exception/action_exception.dart';
import '../home/model.dart';

@immutable
class SaveNote {
  SaveNote(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'SaveNote {note: $note}';
}

@immutable
class SaveNoteSucceeded {
  SaveNoteSucceeded(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'SaveNoteSucceeded {note: $note}';
}

@immutable
class SaveNoteFailed {
  SaveNoteFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'SaveNoteFailed {exception: $exception}';
}

@immutable
class UpdateNote {
  UpdateNote(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'UpdateNote {note: $note}';
}

@immutable
class UpdateNoteSucceeded {
  @override
  String toString() => 'UpdateNoteSucceeded';
}

@immutable
class UpdateNoteFailed {
  UpdateNoteFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'UpdateNoteFailed {exception: $exception}';
}

@immutable
class EditNote {
  @override
  String toString() => 'EditNote';
}

@immutable
class CancelEditNote {
  @override
  String toString() => 'CancelEditNote';
}

@immutable
class ResetNotePage {
  @override
  String toString() => 'ResetNotePage';
}

@immutable
class OpenExistingNote {
  OpenExistingNote(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'OpenExistingNote {note: ${note.title}}';
}

@immutable
class OpenNewNote {
  @override
  String toString() => 'OpenNewNote';
}

@immutable
class TogglePinnedStatus {
  TogglePinnedStatus(this.pinned) : assert(pinned != null);

  final bool pinned;

  @override
  String toString() => 'TogglePinnedStatus {pinned: $pinned}';
}

@immutable
class MoveToTrash {
  MoveToTrash(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'MoveToTrash {note: $note}';
}

@immutable
class MoveToTrashSucceeded {
  @override
  String toString() => 'MoveToTrashSucceeded';
}

@immutable
class MoveToTrashFailed {
  MoveToTrashFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'MoveToTrashFailed {exception: $exception}';
}

@immutable
class Restore {
  Restore(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'Restore {note: $note}';
}

@immutable
class RestoreSucceeded {
  @override
  String toString() => 'RestoreSucceeded';
}

@immutable
class RestoreFailed {
  RestoreFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'RestoreFailed {exception: $exception}';
}

@immutable
class MoveToArchive {
  MoveToArchive(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'MoveToArchive {note: $note}';
}

@immutable
class MoveToArchiveSucceeded {
  @override
  String toString() => 'MoveToArchiveSucceeded';
}

@immutable
class MoveToArchiveFailed {
  MoveToArchiveFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'MoveToArchiveFailed {exception: $exception}';
}

@immutable
class Unarchive {
  Unarchive(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'Unarchive {note: $note}';
}

@immutable
class UnarchiveSucceeded {
  @override
  String toString() => 'UnarchiveSucceeded';
}

@immutable
class UnarchiveFailed {
  UnarchiveFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'UnarchiveFailed {exception: $exception}';
}

@immutable
class DeleteNote {
  DeleteNote(this.noteId) : assert(noteId != null);

  final String noteId;

  @override
  String toString() => 'DeleteNote {noteId: $noteId}';
}

@immutable
class DeleteNoteSucceeded {
  @override
  String toString() => 'DeleteNoteSucceeded';
}

@immutable
class DeleteNoteFailed {
  DeleteNoteFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'DeleteNoteFailed {exception: $exception}';
}

@immutable
class FindNote {
  FindNote(this.noteId) : assert(noteId != null);

  final String noteId;

  @override
  String toString() => 'FindNote {noteId: $noteId}';
}

@immutable
class FindNoteSucceeded {
  FindNoteSucceeded(this.note) : assert(note != null);

  final Note note;

  @override
  String toString() => 'FindNoteSucceeded {note: $note}';
}

@immutable
class FindNoteFailed {
  FindNoteFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'FindNoteFailed {exception: $exception}';
}