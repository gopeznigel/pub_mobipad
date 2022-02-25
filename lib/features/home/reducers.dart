import 'package:mobipad/features/login/actions.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'state.dart';

final Reducer<HomeState> homeStateReducer = combineReducers([
  TypedReducer<HomeState, FetchNotes>(_fetchNotesReducer),
  TypedReducer<HomeState, FetchNotesSucceeded>(_fetchNotesReducerSucceeded),
  TypedReducer<HomeState, FetchNotesFailed>(_fetchNotesReducerFailed),
  TypedReducer<HomeState, GetNoteListSucceeded>(_getNoteListReducerSucceeded),
  TypedReducer<HomeState, GetNoteListFailed>(_getNoteListReducerFailed),
  TypedReducer<HomeState, OpenSearch>(_openSearchReducer),
  TypedReducer<HomeState, CloseSearch>(_closeSearchReducer),
  TypedReducer<HomeState, StartMultipleSelectionMode>(
      _startMultipleSelectionModeReducer),
  TypedReducer<HomeState, StopMultipleSelectionMode>(
      _stopMultipleSelectionModeReducer),
  TypedReducer<HomeState, Logout>(_logoutReducer),
  TypedReducer<HomeState, ViewArchive>(_viewArchiveReducer),
  TypedReducer<HomeState, ViewTrash>(_viewTrashReducer),
  TypedReducer<HomeState, ViewDefault>(_viewDefaultReducer),
]);

HomeState _fetchNotesReducer(HomeState state, FetchNotes action) =>
    state..isLoading = true;

HomeState _fetchNotesReducerSucceeded(
        HomeState state, FetchNotesSucceeded action) =>
    state..exception = null;

HomeState _fetchNotesReducerFailed(HomeState state, FetchNotesFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

HomeState _getNoteListReducerSucceeded(
        HomeState state, GetNoteListSucceeded action) =>
    state
      ..isLoading = false
      ..noteList = action.notes
      ..exception = null;

HomeState _getNoteListReducerFailed(
        HomeState state, GetNoteListFailed action) =>
    state
      ..isLoading = false
      ..exception = action.exception;

HomeState _openSearchReducer(HomeState state, OpenSearch action) =>
    state..isSearching = true;

HomeState _closeSearchReducer(HomeState state, CloseSearch action) =>
    state..isSearching = false;

HomeState _startMultipleSelectionModeReducer(
        HomeState state, StartMultipleSelectionMode action) =>
    state..multipleSelectionMode = true;

HomeState _stopMultipleSelectionModeReducer(
        HomeState state, StopMultipleSelectionMode action) =>
    state..multipleSelectionMode = false;

HomeState _logoutReducer(HomeState state, Logout action) =>
    state..noteList = [];

HomeState _viewArchiveReducer(HomeState state, ViewArchive action) => state
  ..archiveMode = true
  ..trashMode = false;

HomeState _viewTrashReducer(HomeState state, ViewTrash action) => state
  ..archiveMode = false
  ..trashMode = true;

HomeState _viewDefaultReducer(HomeState state, ViewDefault action) => state
  ..archiveMode = false
  ..trashMode = false;
