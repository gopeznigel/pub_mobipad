import 'package:mobipad/core/actions.dart';
import 'package:mobipad/features/home/actions.dart';
import 'package:mobipad/features/home/dtos.dart';
import 'package:mobipad/features/home/state.dart';
import 'package:redux/redux.dart';

final Reducer<HomeState> homeStateReducer = combineReducers([
  TypedReducer<HomeState, SetHomeViewMode>(_handleSetHomeViewMode),
  TypedReducer<HomeState, SetSelectionMode>(_handleSetSelectionMode),
  TypedReducer<HomeState, ListenToNotesUpdates>(_handleListenToNotesUpdates),
  TypedReducer<HomeState, OnNotesUpdates>(_handleOnNotesUpdates),
  TypedReducer<HomeState, StartNoteSearch>(_handleStartNoteSearch),
  TypedReducer<HomeState, SearchNote>(_handleSearchNote),
  TypedReducer<HomeState, EndNoteSearch>(_handleEndNoteSearch),
  TypedReducer<HomeState, AddNoteToSelection>(_handleAddNoteToSelection),
  TypedReducer<HomeState, RemoveNoteToSelection>(_handleRemoveNoteToSelection),
  TypedReducer<HomeState, PinSelectedNotes>(_handleClearMultipleMode),
  TypedReducer<HomeState, UnpinSelectedNotes>(_handleClearMultipleMode),
  TypedReducer<HomeState, ArchiveSelectedNotes>(_handleClearMultipleMode),
  TypedReducer<HomeState, UnarchiveSelectedNotes>(_handleClearMultipleMode),
  TypedReducer<HomeState, DeleteSelectedNotes>(_handleClearMultipleMode),
  TypedReducer<HomeState, PermaDeleteSelectedNotes>(_handleClearMultipleMode),
  TypedReducer<HomeState, RestoreSelectedNotes>(_handleClearMultipleMode),
  TypedReducer<HomeState, SelectAllNotes>(_handleSelectAllNotes),
  TypedReducer<HomeState, DeselectAllNotes>(_handleDeselectAllNotes),
]);

HomeState _handleStartNoteSearch(HomeState state, StartNoteSearch action) =>
    state.rebuild((b) => b..isSearching = true);

HomeState _handleSearchNote(HomeState state, SearchNote action) =>
    state.rebuild((b) => b..searchKeyword = action.keyword);

HomeState _handleEndNoteSearch(HomeState state, EndNoteSearch action) =>
    state.rebuild((b) => b
      ..isSearching = false
      ..searchKeyword = '');

HomeState _handleSetHomeViewMode(HomeState state, SetHomeViewMode action) =>
    state.rebuild((b) => b..noteCategory = action.mode);

HomeState _handleSetSelectionMode(HomeState state, SetSelectionMode action) =>
    state.rebuild((b) => b
      ..selectionMode = action.mode
      ..selectedNotes = action.mode.isNone ? [] : b.selectedNotes);

HomeState _handleListenToNotesUpdates(
        HomeState state, ListenToNotesUpdates action) =>
    state.rebuild((b) => b..isLoading = true);

HomeState _handleOnNotesUpdates(HomeState state, OnNotesUpdates action) =>
    state.rebuild((b) => b
      ..notes = action.notes
      ..isLoading = false);

HomeState _handleAddNoteToSelection(
        HomeState state, AddNoteToSelection action) =>
    state.rebuild((b) => b..selectedNotes = [action.note, ...b.selectedNotes!]);

HomeState _handleRemoveNoteToSelection(
        HomeState state, RemoveNoteToSelection action) =>
    state.rebuild((b) => b
      ..selectedNotes =
          b.selectedNotes?.where((note) => note != action.note).toList());

HomeState _handleClearMultipleMode(HomeState state, dynamic action) =>
    state.rebuild((b) => b
      ..selectionMode = SelectionModeEnum.none
      ..selectedNotes = []);

HomeState _handleSelectAllNotes(HomeState state, SelectAllNotes action) =>
    state.rebuild((b) => b..selectedNotes = action.notes);

HomeState _handleDeselectAllNotes(HomeState state, DeselectAllNotes action) =>
    state.rebuild((b) => b..selectedNotes = []);
