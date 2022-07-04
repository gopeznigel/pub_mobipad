import 'package:flutter/material.dart';
import 'package:mobipad/common_widgets/note_snackbar.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

import 'api.dart';

List<Middleware<AppState>> getMiddleware(
        GlobalKey<NavigatorState> navigatorKey, NoteApi homeApi) =>
    [
      ApiIntegration(homeApi).getMiddlewareBindings(),
      Routing(navigatorKey).getMiddlewareBindings(),
    ].expand((x) => x).toList();

class ApiIntegration {
  const ApiIntegration(this.api);

  final NoteApi api;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, SaveNewNote>(_handleSaveNewNote),
        TypedMiddleware<AppState, SaveNote>(_handleSaveNote),
        TypedMiddleware<AppState, PinNote>(_handlePinNote),
        TypedMiddleware<AppState, PermanentDeleteNote>(
            _handlePermanentDeleteNote),
        TypedMiddleware<AppState, DeleteNote>(_handleDeleteNote),
        TypedMiddleware<AppState, ArchiveNote>(_handleArchiveNote),
        TypedMiddleware<AppState, UnarchiveNote>(_handleUnarchiveNote),
        TypedMiddleware<AppState, RestoreNote>(_handleRestoreNote),
        TypedMiddleware<AppState, ToggleTodo>(_handleToggleTodo),
        TypedMiddleware<AppState, PinSelectedNotes>(_handlePinSelectedNotes),
        TypedMiddleware<AppState, UnpinSelectedNotes>(
            _handleUnpinSelectedNotes),
        TypedMiddleware<AppState, ArchiveSelectedNotes>(
            _handleArchiveSelectedNotes),
        TypedMiddleware<AppState, UnarchiveSelectedNotes>(
            _handleUnarchiveSelectedNotes),
        TypedMiddleware<AppState, DeleteSelectedNotes>(
            _handleDeleteSelectedNotes),
        TypedMiddleware<AppState, PermaDeleteSelectedNotes>(
            _handlePermaDeleteSelectedNotes),
        TypedMiddleware<AppState, RestoreSelectedNotes>(
            _handleRestoreSelectedNotes),
        TypedMiddleware<AppState, UpdateNoteReminder>(
            _handleUpdateNoteReminder),
        TypedMiddleware<AppState, ClearNoteReminder>(_handleClearNoteReminder),
        TypedMiddleware<AppState, SelectANote>(_handleSelectANote),
      ];

  void _handleSaveNewNote(
      Store<AppState> store, SaveNewNote action, NextDispatcher next) {
    Future<void> _saveNewNote(Store<AppState> store, SaveNewNote action) async {
      try {
        final note = await api.createNote(action.newNote);

        store.dispatch(SaveNewNoteSuccessful(note: note));
      } on Exception catch (exception) {
        store.dispatch(
            SaveNewNoteFailed(exception: ActionException(exception, action)));
      }
    }

    _saveNewNote(store, action);
    next(action);
  }

  void _handleSaveNote(
      Store<AppState> store, SaveNote action, NextDispatcher next) {
    final note = api.updateNote(action.note);

    next(action);

    store.dispatch(UpdatedNote(note: note));
  }

  void _handlePinNote(
      Store<AppState> store, PinNote action, NextDispatcher next) {
    api.pinNote(action.note, action.pin);
    next(action);
  }

  void _handlePermanentDeleteNote(
      Store<AppState> store, PermanentDeleteNote action, NextDispatcher next) {
    Future<void> _permanentDeleteNote(
        Store<AppState> store, PermanentDeleteNote action) async {
      try {
        await api.permanentDeleteNote(action.note);

        store.dispatch(PermanentDeleteNoteSuccessful());
      } on Exception catch (exception) {
        store.dispatch(PermanentDeleteNoteFailed(
            exception: ActionException(exception, action)));
      }
    }

    _permanentDeleteNote(store, action);
    next(action);
  }

  void _handleDeleteNote(
      Store<AppState> store, DeleteNote action, NextDispatcher next) {
    api.deleteNote(action.note);

    if (action.note.reminder!.remId != null) {
      store.dispatch(ClearReminder(
          remId: action.note.reminder!.remId!, note: action.note));
    }

    next(action);
  }

  void _handleArchiveNote(
      Store<AppState> store, ArchiveNote action, NextDispatcher next) {
    final note = api.archiveNote(action.note, true);

    next(action);

    store.dispatch(UpdatedNote(note: note));
  }

  void _handleUnarchiveNote(
      Store<AppState> store, UnarchiveNote action, NextDispatcher next) {
    final note = api.archiveNote(action.note, false);

    next(action);

    store.dispatch(UpdatedNote(note: note));
  }

  void _handleRestoreNote(
      Store<AppState> store, RestoreNote action, NextDispatcher next) {
    final note = api.restoreNote(action.note);

    next(action);

    store.dispatch(UpdatedNote(note: note));
  }

  void _handleToggleTodo(
      Store<AppState> store, ToggleTodo action, NextDispatcher next) {
    final note = api.toggleTodo(action.note, action.todo);

    next(action);

    store.dispatch(UpdatedNote(note: note));
  }

  void _handlePinSelectedNotes(
      Store<AppState> store, PinSelectedNotes action, NextDispatcher next) {
    for (var note in action.notes) {
      api.pinNote(note, true);
    }

    next(action);
  }

  void _handleUnpinSelectedNotes(
      Store<AppState> store, UnpinSelectedNotes action, NextDispatcher next) {
    for (var note in action.notes) {
      api.pinNote(note, false);
    }

    next(action);
  }

  void _handleArchiveSelectedNotes(
      Store<AppState> store, ArchiveSelectedNotes action, NextDispatcher next) {
    for (var note in action.notes) {
      api.archiveNote(note, true);
    }

    next(action);
  }

  void _handleUnarchiveSelectedNotes(Store<AppState> store,
      UnarchiveSelectedNotes action, NextDispatcher next) {
    for (var note in action.notes) {
      api.archiveNote(note, false);
    }

    next(action);
  }

  void _handleDeleteSelectedNotes(
      Store<AppState> store, DeleteSelectedNotes action, NextDispatcher next) {
    for (var note in action.notes) {
      api.deleteNote(note);

      if (note.reminder!.remId != null) {
        store.dispatch(ClearReminder(remId: note.reminder!.remId!, note: note));
      }
    }

    next(action);
  }

  void _handlePermaDeleteSelectedNotes(Store<AppState> store,
      PermaDeleteSelectedNotes action, NextDispatcher next) {
    for (var note in action.notes) {
      api.permanentDeleteNote(note);

      if (note.reminder!.remId != null) {
        store.dispatch(ClearReminder(remId: note.reminder!.remId!, note: note));
      }
    }

    next(action);
  }

  void _handleRestoreSelectedNotes(
      Store<AppState> store, RestoreSelectedNotes action, NextDispatcher next) {
    for (var note in action.notes) {
      api.restoreNote(note);
    }

    next(action);
  }

  void _handleUpdateNoteReminder(
      Store<AppState> store, UpdateNoteReminder action, NextDispatcher next) {
    final note = api.updateNoteReminder(action.note, action.reminder);

    next(action);

    store
      ..dispatch(UpdatedNote(note: note))
      ..dispatch(InitReminderSettings(reminder: note.reminder));
  }

  void _handleClearNoteReminder(
      Store<AppState> store, ClearNoteReminder action, NextDispatcher next) {
    final note = api.clearNoteReminder(action.note);

    next(action);

    store
      ..dispatch(UpdatedNote(note: note))
      ..dispatch(InitReminderSettings(reminder: note.reminder));
  }

  void _handleSelectANote(
      Store<AppState> store, SelectANote action, NextDispatcher next) {
    Future<void> _selectANote(Store<AppState> store, SelectANote action) async {
      try {
        final note = await api.selectANote(action.noteId);

        store
          ..dispatch(UpdatedNote(note: note))
          ..dispatch(SetNoteMode(
              mode: note.description == null
                  ? NoteModeEnum.todo
                  : NoteModeEnum.note));
      } on Exception catch (_) {
        debugPrint('Note not fetched. Please try again later');
      }
    }

    _selectANote(store, action);
    next(action);
  }
}

class Routing {
  const Routing(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  List<Middleware<AppState>> getMiddlewareBindings() => [
        TypedMiddleware<AppState, SaveNote>(_routeShowSaved),
        TypedMiddleware<AppState, SaveNewNoteSuccessful>(_routeShowSaved),
        TypedMiddleware<AppState, SaveNewNoteFailed>(_routeSavingError),
      ];

  NavigatorState get _navigatorState => navigatorKey.currentState!;

  void _routeShowSaved(
      Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    showSnackbar(_navigatorState.context, 'Saved!');
  }

  void _routeSavingError(
      Store<AppState> store, SaveNewNoteFailed action, NextDispatcher next) {
    next(action);

    showSnackbar(_navigatorState.context, 'Saving Failed!');
  }
}
