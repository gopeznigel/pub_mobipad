import 'package:flutter/foundation.dart';
import 'package:mobipad/features/home/dtos.dart';
import 'package:mobipad/core/dtos.dart';

@immutable
class SetHomeViewMode {
  const SetHomeViewMode({required this.mode});

  final NoteCategoryEnum mode;

  @override
  String toString() => 'SetHomeViewMode {mode: $mode}';
}

@immutable
class SetSelectionMode {
  const SetSelectionMode({required this.mode});

  final SelectionModeEnum mode;

  @override
  String toString() => 'SetSelectionMode {mode: $mode}';
}

@immutable
class ListenToNotesUpdates {
  const ListenToNotesUpdates({required this.sort});

  final String sort;

  @override
  String toString() => 'ListenToNotesUpdates {sort: $sort}';
}

@immutable
class OnNotesUpdates {
  const OnNotesUpdates({required this.notes});

  final List<NoteDto> notes;

  @override
  String toString() => 'OnNotesUpdates {notes: $notes}';
}

@immutable
class StartNoteSearch {
  @override
  String toString() => 'StartNoteSearch ';
}

@immutable
class EndNoteSearch {
  @override
  String toString() => 'EndNoteSearch ';
}

@immutable
class SearchNote {
  final String keyword;

  const SearchNote({required this.keyword});

  @override
  String toString() => 'SearchNote { keyword: $keyword }';
}

@immutable
class AddNoteToSelection {
  final NoteDto note;

  const AddNoteToSelection({required this.note});

  @override
  String toString() => 'AddNoteToSelection { note: $note }';
}

@immutable
class RemoveNoteToSelection {
  final NoteDto note;

  const RemoveNoteToSelection({required this.note});

  @override
  String toString() => 'RemoveNoteToSelection { note: $note }';
}

@immutable
class SelectAllNotes {
  final List<NoteDto> notes;

  const SelectAllNotes({required this.notes});

  @override
  String toString() => 'SelectAllNotes { notes: $notes }';
}

@immutable
class DeselectAllNotes {
  @override
  String toString() => 'DeselectAllNotes';
}
