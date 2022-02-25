import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

final Reducer<NoteState> noteStateReducer = combineReducers([
  TypedReducer<NoteState, OpenNewNote>(_openNewNoteReducer),
  TypedReducer<NoteState, OpenExistingNote>(_openExistingNoteReducer),
  TypedReducer<NoteState, SaveNote>(_saveNoteReducer),
  TypedReducer<NoteState, SaveNoteSucceeded>(_saveNoteReducerSucceeded),
  TypedReducer<NoteState, SaveNoteFailed>(_saveNoteReducerFailed),
  TypedReducer<NoteState, EditNote>(_editNoteReducer),
  TypedReducer<NoteState, CancelEditNote>(_cancelEditNoteReducer),
  TypedReducer<NoteState, UpdateNote>(_updateNoteReducer),
  TypedReducer<NoteState, UpdateNoteSucceeded>(_updateNoteReducerSucceeded),
  TypedReducer<NoteState, UpdateNoteFailed>(_updateNoteReducerFailed),
  TypedReducer<NoteState, ResetNotePage>(_resetNotePageReducer),
  TypedReducer<NoteState, MoveToTrash>(_moveToTrashReducer),
  TypedReducer<NoteState, MoveToTrashSucceeded>(_moveToTrashReducerSucceeded),
  TypedReducer<NoteState, MoveToTrashFailed>(_moveToTrashReducerFailed),
  TypedReducer<NoteState, MoveToArchive>(_moveToArchiveReducer),
  TypedReducer<NoteState, MoveToArchiveSucceeded>(
      _moveToArchiveReducerSucceeded),
  TypedReducer<NoteState, MoveToArchiveFailed>(_moveToArchiveReducerFailed),
  TypedReducer<NoteState, DeleteNote>(_deleteNoteReducer),
  TypedReducer<NoteState, DeleteNoteSucceeded>(_deleteNoteReducerSucceeded),
  TypedReducer<NoteState, DeleteNoteFailed>(_deleteNoteReducerFailed),
  TypedReducer<NoteState, Unarchive>(_unarchiveReducer),
  TypedReducer<NoteState, UnarchiveSucceeded>(_unarchiveReducerSucceeded),
  TypedReducer<NoteState, UnarchiveFailed>(_unarchiveReducerFailed),
  TypedReducer<NoteState, Restore>(_restoreReducer),
  TypedReducer<NoteState, RestoreSucceeded>(_restoreReducerSucceeded),
  TypedReducer<NoteState, RestoreFailed>(_restoreReducerFailed),
  TypedReducer<NoteState, FindNote>(_findNoteReducer),
  TypedReducer<NoteState, FindNoteSucceeded>(_findNoteReducerSucceeded),
  TypedReducer<NoteState, FindNoteFailed>(_findNoteReducerFailed),
]);

NoteState _openNewNoteReducer(NoteState state, OpenNewNote action) => state
  ..isLoading = false
  ..isEditing = true
  ..exception = null
  ..note = null;

NoteState _openExistingNoteReducer(NoteState state, OpenExistingNote action) =>
    state
      ..isLoading = false
      ..isEditing = false
      ..exception = null
      ..note = action.note;

NoteState _saveNoteReducer(NoteState state, SaveNote action) => state
  ..isLoading = true
  ..isEditing = false;

NoteState _saveNoteReducerSucceeded(
        NoteState state, SaveNoteSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null
      ..note = action.note;

NoteState _saveNoteReducerFailed(NoteState state, SaveNoteFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

NoteState _editNoteReducer(NoteState state, EditNote action) =>
    state..isEditing = true;

NoteState _cancelEditNoteReducer(NoteState state, CancelEditNote action) =>
    state..isEditing = false;

NoteState _updateNoteReducer(NoteState state, UpdateNote action) => state
  ..isEditing = false
  ..note = action.note;

NoteState _updateNoteReducerSucceeded(
        NoteState state, UpdateNoteSucceeded action) =>
    state..exception = null;

NoteState _updateNoteReducerFailed(NoteState state, UpdateNoteFailed action) =>
    state..exception = action.exception;

NoteState _resetNotePageReducer(NoteState state, ResetNotePage action) => state
  ..isEditing = false
  ..exception = null
  ..isLoading = false
  ..note = null;

NoteState _moveToTrashReducer(NoteState state, MoveToTrash action) =>
    state..isLoading = true;

NoteState _moveToTrashReducerSucceeded(
        NoteState state, MoveToTrashSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

NoteState _moveToTrashReducerFailed(
        NoteState state, MoveToTrashFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

NoteState _moveToArchiveReducer(NoteState state, MoveToArchive action) =>
    state..isLoading = true;

NoteState _moveToArchiveReducerSucceeded(
        NoteState state, MoveToArchiveSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

NoteState _moveToArchiveReducerFailed(
        NoteState state, MoveToArchiveFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

NoteState _deleteNoteReducer(NoteState state, DeleteNote action) =>
    state..isLoading = true;

NoteState _deleteNoteReducerSucceeded(
        NoteState state, DeleteNoteSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

NoteState _deleteNoteReducerFailed(NoteState state, DeleteNoteFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

NoteState _unarchiveReducer(NoteState state, Unarchive action) =>
    state..isLoading = true;

NoteState _unarchiveReducerSucceeded(
        NoteState state, UnarchiveSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

NoteState _unarchiveReducerFailed(NoteState state, UnarchiveFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

NoteState _restoreReducer(NoteState state, Restore action) =>
    state..isLoading = true;

NoteState _restoreReducerSucceeded(NoteState state, RestoreSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null;

NoteState _restoreReducerFailed(NoteState state, RestoreFailed action) => state
  ..isLoading = false
  ..exception = action.exception;

NoteState _findNoteReducer(NoteState state, FindNote action) => state
  ..isLoading = true
  ..isEditing = false;

NoteState _findNoteReducerSucceeded(
        NoteState state, FindNoteSucceeded action) =>
    state
      ..isLoading = false
      ..exception = null
      ..note = action.note;

NoteState _findNoteReducerFailed(NoteState state, FindNoteFailed action) =>
    state
      ..isLoading = false
      ..isEditing = false
      ..exception = action.exception;
