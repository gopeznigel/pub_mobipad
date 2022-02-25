import 'package:flutter/foundation.dart';

import '../../exception/action_exception.dart';
import 'model.dart';

@immutable
class OpenNotePage {
  @override
  String toString() => 'OpenNotePage';
}

@immutable
class OpenTodoPage {
  @override
  String toString() => 'OpenTodoPage';
}

@immutable
class GetNoteList {
  GetNoteList(this.sort) : assert(sort != null);

  final String sort;

  @override
  String toString() => 'GetNoteList  {sort: $sort}';
}

@immutable
class GetNoteListSucceeded {
  GetNoteListSucceeded(this.notes) : assert(notes != null);

  final List<Note> notes;
  @override
  String toString() => 'GetNoteListSucceeded {notes: $notes}';
}

@immutable
class GetNoteListFailed {
  GetNoteListFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'GetNoteListFailed {exception: $exception}';
}

@immutable
class InitCollection {
  InitCollection(this.userId) : assert(userId != null);

  final String userId;

  @override
  String toString() => 'InitCollection {userId: $userId}';
}

@immutable
class FetchNotes {
  @override
  String toString() => 'FetchNotes';
}

@immutable
class FetchNotesSucceeded {
  @override
  String toString() => 'FetchNotesSucceeded';
}

@immutable
class FetchNotesFailed {
  FetchNotesFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'FetchNotesFailed {exception: $exception}';
}

@immutable
class OpenSearch {
  @override
  String toString() => 'OpenSearch';
}

@immutable
class CloseSearch {
  @override
  String toString() => 'CloseSearch';
}

@immutable
class SearchNotes {
  SearchNotes(this.searchKey) : assert(searchKey != null);

  final String searchKey;

  @override
  String toString() => 'SearchNotes {searchKey: $searchKey}';
}

@immutable
class SearchNotesSucceeded {
  SearchNotesSucceeded(this.note) : assert(note != null);

  final List<Note> note;

  @override
  String toString() => 'SearchNotesSucceeded {note: $note}';
}

@immutable
class SearchNotesFailed {
  SearchNotesFailed(this.exception) : assert(exception != null);

  final ActionException exception;

  @override
  String toString() => 'SearchNotesFailed {exception: $exception}';
}

@immutable
class StartMultipleSelectionMode {
  @override
  String toString() => 'StartMultipleSelectionMode';
}

@immutable
class StopMultipleSelectionMode {
  @override
  String toString() => 'StartMultipleSelectionMode';
}

@immutable
class DeleteMultiple {
  DeleteMultiple(this.notes, this.selectedIndex)
      : assert(selectedIndex != null && notes != null);

  final List<int> selectedIndex;
  final List<Note> notes;

  @override
  String toString() =>
      'DeleteMultiple {selectedIndex: $selectedIndex, notes: $notes}';
}

@immutable
class MoveToTrashMultiple {
  MoveToTrashMultiple(this.notes, this.selectedIndex)
      : assert(selectedIndex != null && notes != null);

  final List<int> selectedIndex;
  final List<Note> notes;

  @override
  String toString() =>
      'MoveToTrashMultiple {selectedIndex: $selectedIndex, notes: $notes}';
}

@immutable
class RestoreMultiple {
  RestoreMultiple(this.notes, this.selectedIndex)
      : assert(selectedIndex != null && notes != null);

  final List<int> selectedIndex;
  final List<Note> notes;

  @override
  String toString() =>
      'RestoreMultiple {selectedIndex: $selectedIndex, notes: $notes}';
}

@immutable
class MoveToArchiveMultiple {
  MoveToArchiveMultiple(this.notes, this.selectedIndex)
      : assert(selectedIndex != null && notes != null);

  final List<int> selectedIndex;
  final List<Note> notes;

  @override
  String toString() =>
      'MoveToArchiveMultiple {selectedIndex: $selectedIndex, notes: $notes}';
}

@immutable
class UnarchiveMultiple {
  UnarchiveMultiple(this.notes, this.selectedIndex)
      : assert(selectedIndex != null && notes != null);

  final List<int> selectedIndex;
  final List<Note> notes;

  @override
  String toString() =>
      'UnarchiveMultiple {selectedIndex: $selectedIndex, notes: $notes}';
}

@immutable
class UpdatePinnedStatusMultiple {
  UpdatePinnedStatusMultiple(this.notes, this.selectedIndex, this.pinned)
      : assert(selectedIndex != null && notes != null);

  final List<int> selectedIndex;
  final List<Note> notes;
  final bool pinned;

  @override
  String toString() =>
      'UpdatePinnedStatusMultiple {selectedIndex: $selectedIndex, notes: $notes, pinned: $pinned}';
}

@immutable
class ViewArchive {
  @override
  String toString() => 'ViewArchive';
}

@immutable
class ViewTrash {
  @override
  String toString() => 'ViewTrash';
}

@immutable
class ViewDefault {
  @override
  String toString() => 'ViewDefault';
}
