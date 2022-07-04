import 'package:flutter/material.dart';
import 'package:mobipad/constants/oh_notes_icons.dart';
import 'package:mobipad/features/home/actions.dart';
import 'package:mobipad/features/home/dtos.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/utils/app_bar_theme_util.dart';
import 'package:redux/redux.dart';

class HomePageViewModel {
  HomePageViewModel(
    this._context,
    this._store,
  );
  final Store<AppState> _store;

  final BuildContext _context;

  NoteCategoryEnum get homeViewMode => _store.state.homeState.noteCategory;

  SelectionModeEnum get selectionMode => _store.state.homeState.selectionMode;

  List<NoteDto> get allNotes => _store.state.homeState.notes;

  List<NoteDto> get selectedNotes => _store.state.homeState.selectedNotes;

  bool get isSearching => _store.state.homeState.isSearching;

  String get selectedDateTimeDisplay =>
      _store.state.settingsState.selectedDateTimeDisplay;

  String get selectedSorting => _store.state.settingsState.selectedSorting;

  List<NoteDto> get notes {
    switch (homeViewMode) {
      case NoteCategoryEnum.active:
        var noPrioList = allNotes
            .where((note) =>
                ((note.dateDeleted ?? 0) == 0) &&
                ((note.dateArchived ?? 0) == 0))
            .toList();

        if (isSearching) {
          return _searchedNotes(noPrioList);
        }

        // Get all pinned notes first
        var pinnedNoteList = noPrioList.where((note) => note.pinned).toList();

        // Get all not pinned notes
        var normalNoteList = noPrioList.where((note) => !note.pinned).toList();

        return [
          ...pinnedNoteList,
          ...normalNoteList,
        ];
      case NoteCategoryEnum.archived:
        return allNotes.where((note) => (note.dateArchived ?? 0) > 0).toList();
      case NoteCategoryEnum.trashed:
        return allNotes.where((note) => (note.dateDeleted ?? 0) > 0).toList();
      default:
        return allNotes;
    }
  }

  MultiPinEnum get multiPinStatus {
    int pinnedCount = 0;
    int unpinnedCount = 0;

    for (var selected in selectedNotes) {
      if (selected.pinned) {
        pinnedCount++;
      } else {
        unpinnedCount++;
      }
    }

    if (pinnedCount > 0 && unpinnedCount > 0) {
      return MultiPinEnum.disabled;
    } else if (pinnedCount > 0) {
      return MultiPinEnum.multiUnpin;
    } else if (unpinnedCount > 0) {
      return MultiPinEnum.multiPin;
    } else {
      return MultiPinEnum.disabled;
    }
  }

  Icon get pinIcon {
    switch (multiPinStatus) {
      case MultiPinEnum.disabled:
        return const Icon(
          OhNotes.pin,
          color: Colors.black26,
        );
      case MultiPinEnum.multiPin:
        return const Icon(
          OhNotes.pin,
          color: Colors.black,
        );
      case MultiPinEnum.multiUnpin:
        return const Icon(
          OhNotes.pinBorder,
          color: Colors.black,
        );
      default:
        return const Icon(
          OhNotes.pin,
          color: Colors.black26,
        );
    }
  }

  void addOrRemoveNoteFromList(NoteDto note) {
    if (isNoteSelected(note)) {
      _store.dispatch(RemoveNoteToSelection(note: note));
    } else {
      _store.dispatch(AddNoteToSelection(note: note));
    }
  }

  bool isNoteSelected(NoteDto note) {
    var currentlySelected = selectedNotes.contains(note);

    return currentlySelected;
  }

  List<NoteDto> _searchedNotes(List<NoteDto> noteList) {
    var searchKey = _store.state.homeState.searchKeyword.trim();
    var notes = <NoteDto>[];

    if (searchKey.isEmpty) {
      return [];
    }

    for (var note in noteList) {
      var title = note.title?.toLowerCase() ?? '';
      var description = note.description?.toLowerCase() ?? '';
      var todos = '';

      for (var element in (note.todoList?.asList() ?? [TodoDto()])) {
        todos += '${element.todo?.toLowerCase() ?? ''} ';
      }

      if (title.contains(searchKey.toLowerCase()) ||
          description.contains(searchKey.toLowerCase()) ||
          todos.contains(searchKey.toLowerCase())) {
        notes.add(note);
      }
    }

    return notes;
  }

  Future<bool> willPop(GlobalKey<ScaffoldState> key) async {
    if (key.currentState!.isDrawerOpen) {
      Navigator.pop(_context);
      return false;
    } else if (isSearching) {
      _store.dispatch(EndNoteSearch());
      return false;
    } else if (!homeViewMode.isActive) {
      _store.dispatch(const SetHomeViewMode(mode: NoteCategoryEnum.active));
      return false;
    } else if (selectionMode.isMultiple) {
      _store.dispatch(const SetSelectionMode(mode: SelectionModeEnum.none));
      return false;
    } else {
      return false;
    }
  }

  Color get appBarColor {
    return AppBarThemeUtil.getAppBarColor(homeViewMode);
  }

  String get appBarTitle {
    switch (homeViewMode) {
      case NoteCategoryEnum.active:
        return 'Your Notes';
      case NoteCategoryEnum.archived:
        return 'Archived Notes';
      case NoteCategoryEnum.trashed:
        return 'Deleted Notes';
      default:
        return 'Your Notes';
    }
  }

  String get deleteMessage {
    if (homeViewMode.isTrashed) {
      return 'Delete all selected permanently?';
    } else {
      return 'Delete all selected?';
    }
  }

  String get deleteButtonLabel {
    if (homeViewMode.isTrashed) {
      return 'Delete All Forever';
    } else {
      return 'Delete All';
    }
  }

  String get archiveMessage {
    if (homeViewMode.isArchived) {
      return 'Unarchive all selected?';
    } else {
      return 'Archive all selected?';
    }
  }

  String get archiveButtonLabel {
    if (homeViewMode.isArchived) {
      return 'Unarchive All';
    } else {
      return 'Archive All';
    }
  }

  String get restoreMessage {
    return 'Restore all selected?';
  }

  String get restoreButtonLabel {
    return 'Restore All';
  }

  String get pinMessage {
    if (multiPinStatus.isMultiPin) {
      return 'Pin all selected?';
    } else {
      return 'Unpin all selected?';
    }
  }

  String get pinButtonLabel {
    if (multiPinStatus.isMultiPin) {
      return 'Pin All';
    } else {
      return 'Unpin All';
    }
  }
}
