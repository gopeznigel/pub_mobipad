import 'package:flutter/material.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/utils/app_bar_theme_util.dart';
import 'package:mobipad/utils/date_time_util.dart';
import 'package:redux/redux.dart';

class NotePageViewModel {
  NotePageViewModel(this._store);

  final Store<AppState> _store;

  NoteDto? get note => _store.state.noteState.note;

  String get title => note?.title ?? '';

  String get noteBody => note?.description ?? '';

  int get dateCreated =>
      note?.dateCreated ?? DateTime.now().millisecondsSinceEpoch;

  int get dateModified =>
      note?.dateModified ?? DateTime.now().millisecondsSinceEpoch;

  bool get withActiveReminder =>
      note?.reminder?.reminderStart?.isNotEmpty ?? false;

  int get selectedFontSize => _store.state.settingsState.selectedFontSize;

  String get selectedDateTimeDisplay =>
      _store.state.settingsState.selectedDateTimeDisplay;

  bool get canPinNote {
    // User can pin notes when they are not editing active notes
    return (status.isSaved || status.isViewing) && (noteCategory.isActive);
  }

  bool get canDoSave {
    // User can save notes when editing notes where title and body are not empty
    return (status.isEditing || status.isInitial) &&
        title.isNotEmpty &&
        (noteBody.isNotEmpty || todos.isNotEmpty);
  }

  bool get withNoteId {
    return note?.id != null;
  }

  Future<bool> get canExit async {
    // Return true right away if status is deleted
    // if (status.isDeleted) return true;

    switch (status) {
      case NoteStatusEnum.editing:
        if (title.isNotEmpty && (noteBody.isNotEmpty || todos.isNotEmpty)) {
          // save and it will cancel edit too
          if (withNoteId) {
            _store.dispatch(SaveNote(note: note!));
          } else {
            _store.dispatch(SaveNewNote(newNote: note!));
          }
        } else {
          // cancel edit
          _store.dispatch(CancelEditNote());
        }

        return false;
      case NoteStatusEnum.initial:
        // Check whether there is new data, if not
        // just delete the empty note permanently and return false
        // to not interfere with auto note closing after deletion
        if (title.isEmpty && (noteBody.isEmpty || todos.isEmpty)) {
          return true;
        }

        if (title.isNotEmpty && (noteBody.isNotEmpty || todos.isNotEmpty)) {
          // save and it will cancel edit too
          if (withNoteId) {
            _store.dispatch(SaveNote(note: note!));
          } else {
            _store.dispatch(SaveNewNote(newNote: note!));
          }

          return false;
        }
        return true;
      case NoteStatusEnum.saved:
      case NoteStatusEnum.viewing:
      default:
        return true;
    }
  }

  List<TodoDto> get todos => note?.todoList?.asList() ?? [];

  NoteModeEnum get mode => _store.state.noteState.noteMode;

  NoteStatusEnum get status => _store.state.noteState.status;

  bool get readOnly => !status.isInitial && !status.isEditing;

  String get nextReminder {
    if (withActiveReminder) {
      var reminders = note!.reminder!.reminderStart!;
      var next = reminders[0];
      for (var rem in reminders) {
        if (next > rem) {
          next = rem;
        }
      }

      return DateTimeUtil.dateAndTime(next);
    } else {
      return '';
    }
  }

  String get deleteMessage {
    if (noteCategory.isTrashed) {
      return 'Delete ${mode.name} permanently?';
    } else {
      return 'Delete ${mode.name}?';
    }
  }

  String get deleteButtonLabel {
    if (noteCategory.isTrashed) {
      return 'Delete Forever';
    } else {
      return 'Delete';
    }
  }

  String get archiveMessage {
    if (noteCategory.isArchived) {
      return 'Unarchive ${mode.name}?';
    } else {
      return 'Archive ${mode.name}?';
    }
  }

  String get archiveButtonLabel {
    if (noteCategory.isArchived) {
      return 'Unarchive';
    } else {
      return 'Archive';
    }
  }

  String get restoreMessage {
    return 'Restore ${mode.name}?';
  }

  String get restoreButtonLabel {
    return 'Restore';
  }

  void deleteNote() {
    if (noteCategory.isTrashed) {
      _store.dispatch(PermanentDeleteNote(note: note!));
    } else {
      _store.dispatch(DeleteNote(note: note!));
    }
  }

  NoteCategoryEnum get noteCategory {
    NoteCategoryEnum cat = NoteCategoryEnum.active;

    if ((note?.dateArchived ?? 0) > 0) {
      cat = NoteCategoryEnum.archived;
    } else if ((note?.dateDeleted ?? 0) > 0) {
      cat = NoteCategoryEnum.trashed;
    }

    return cat;
  }

  Color get appBarColor {
    return AppBarThemeUtil.getAppBarColor(noteCategory);
  }

  List<NoteMenuDto> get menus {
    if (noteCategory.isTrashed) {
      return <NoteMenuDto>[
        NoteMenuDto(
          (b) => b
            ..menu = NotePopupMenuEnum.restore
            ..icon = Icons.settings_backup_restore,
        )
      ];
    } else {
      return <NoteMenuDto>[
        if (noteCategory.isActive)
          NoteMenuDto(
            (b) => b
              ..menu = NotePopupMenuEnum.archive
              ..icon = Icons.archive,
          ),
        if (noteCategory.isArchived)
          NoteMenuDto(
            (b) => b
              ..menu = NotePopupMenuEnum.unarchive
              ..icon = Icons.unarchive,
          ),
        NoteMenuDto(
          (b) => b
            ..menu = NotePopupMenuEnum.reminder
            ..icon = Icons.notifications,
        ),
      ];
    }
  }
}
