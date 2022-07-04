import 'package:flutter/material.dart';
import 'package:mobipad/exception/action_exception.dart';

import 'dtos.dart';

@immutable
class SetNoteMode {
  const SetNoteMode({required this.mode});

  final NoteModeEnum mode;

  @override
  String toString() => 'SetNoteMode {mode: $mode}';
}

@immutable
class CreateNote {
  @override
  String toString() => 'CreateNote';
}

@immutable
class ViewNote {
  final NoteDto note;

  const ViewNote({required this.note});

  @override
  String toString() => 'ViewNote { note: $note }';
}

@immutable
class LogOut {
  @override
  String toString() => 'LogOut';
}

@immutable
class LogOutSuccessful {
  @override
  String toString() => 'LogOutSuccessful';
}

@immutable
class LogOutFailed {
  final ActionException exception;

  const LogOutFailed({required this.exception});

  @override
  String toString() => 'LogOutFailed { exception: $exception }';
}

@immutable
class PinSelectedNotes {
  final List<NoteDto> notes;

  const PinSelectedNotes({required this.notes});

  @override
  String toString() => 'PinSelectedNotes { note: $notes }';
}

@immutable
class UnpinSelectedNotes {
  final List<NoteDto> notes;

  const UnpinSelectedNotes({required this.notes});

  @override
  String toString() => 'UnpinSelectedNotes { note: $notes }';
}

@immutable
class ArchiveSelectedNotes {
  final List<NoteDto> notes;

  const ArchiveSelectedNotes({required this.notes});

  @override
  String toString() => 'ArchiveSelectedNotes { note: $notes }';
}

@immutable
class UnarchiveSelectedNotes {
  final List<NoteDto> notes;

  const UnarchiveSelectedNotes({required this.notes});

  @override
  String toString() => 'UnarchiveSelectedNotes { note: $notes }';
}

@immutable
class DeleteSelectedNotes {
  final List<NoteDto> notes;

  const DeleteSelectedNotes({required this.notes});

  @override
  String toString() => 'DeleteSelectedNotes { note: $notes }';
}

@immutable
class PermaDeleteSelectedNotes {
  final List<NoteDto> notes;

  const PermaDeleteSelectedNotes({required this.notes});

  @override
  String toString() => 'PermaDeleteSelectedNotes { note: $notes }';
}

@immutable
class RestoreSelectedNotes {
  final List<NoteDto> notes;

  const RestoreSelectedNotes({required this.notes});

  @override
  String toString() => 'RestoreSelectedNotes { notes: $notes }';
}

@immutable
class InitReminderSettings {
  final ReminderDto? reminder;

  const InitReminderSettings({required this.reminder});

  @override
  String toString() => 'InitReminderSettings { reminder: $reminder }';
}

@immutable
class UpdateNoteReminder {
  final ReminderDto reminder;
  final NoteDto note;

  const UpdateNoteReminder({
    required this.reminder,
    required this.note,
  });

  @override
  String toString() =>
      'UpdateNoteReminder { reminder: $reminder, note: $note }';
}

@immutable
class ClearNoteReminder {
  final NoteDto note;

  const ClearNoteReminder({
    required this.note,
  });

  @override
  String toString() => 'ClearNoteReminder { note: $note }';
}

@immutable
class NotificationClickListener {
  @override
  String toString() => 'NotificationClickListener ';
}

@immutable
class DisposeNotificationClickListener {
  @override
  String toString() => 'DisposeNotificationClickListener ';
}

@immutable
class SelectANote {
  final String noteId;

  const SelectANote({
    required this.noteId,
  });

  @override
  String toString() => 'SelectANote { noteId: $noteId }';
}

@immutable
class ClearReminder {
  const ClearReminder({required this.remId, required this.note});

  final int remId;
  final NoteDto note;

  @override
  String toString() => 'ClearReminder { remId: $remId, note: $note }';
}

@immutable
class ClearReminderSucceeded {
  @override
  String toString() => 'ClearReminderSucceeded';
}

@immutable
class ClearReminderFailed {
  const ClearReminderFailed({required this.exception});

  final ActionException exception;

  @override
  String toString() => 'ClearReminderFailed {exception: $exception}';
}

@immutable
class ClearAllReminder {
  @override
  String toString() => 'ClearAllReminder';
}

@immutable
class GetFontSize {
  @override
  String toString() => 'GetFontSize';
}

@immutable
class GetSort {
  @override
  String toString() => 'GetSort';
}

@immutable
class GetDateTimeDisplay {
  @override
  String toString() => 'GetDateTimeDisplay';
}

@immutable
class GetSortedNotes {
  final String sort;

  const GetSortedNotes({required this.sort});

  @override
  String toString() => 'GetSortedNotes { sort: $sort }';
}
