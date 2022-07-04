import 'package:built_collection/built_collection.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/state.dart';
import 'package:redux/redux.dart';

import 'actions.dart';

final Reducer<NoteState> noteStateReducer = combineReducers([
  TypedReducer<NoteState, SetNoteMode>(_handleSetNoteMode),
  TypedReducer<NoteState, CreateNote>(_handleCreateNote),
  TypedReducer<NoteState, DeleteNote>(_handleDeleteNote),
  TypedReducer<NoteState, PermanentDeleteNoteSuccessful>(
      _handlePermanentDeleteNoteSuccessful),
  TypedReducer<NoteState, PermanentDeleteNoteFailed>(
      _handlePermanentDeleteNoteFailed),
  TypedReducer<NoteState, EditNote>(_handleEditNote),
  TypedReducer<NoteState, CancelEditNote>(_handleCancelEditNote),
  TypedReducer<NoteState, SaveNote>(_handleSaveNote),
  TypedReducer<NoteState, UpdateTitle>(_handleUpdateTitle),
  TypedReducer<NoteState, UpdateNoteBody>(_handleUpdateNoteBody),
  TypedReducer<NoteState, AddTodo>(_handleAddTodo),
  TypedReducer<NoteState, RemoveTodo>(_handleRemoveTodo),
  TypedReducer<NoteState, ViewNote>(_handleViewNote),
  TypedReducer<NoteState, PinNote>(_handlePinNote),
  TypedReducer<NoteState, UpdatedNote>(_handleUpdatedNote),
  TypedReducer<NoteState, EditTodo>(_handleEditTodo),
  TypedReducer<NoteState, ReorderTodo>(_handleReorderTodo),
  TypedReducer<NoteState, CleanNotePage>(_handleCleanNotePage),
  TypedReducer<NoteState, SaveNewNote>(_handleSaveNewNote),
  TypedReducer<NoteState, SaveNewNoteSuccessful>(_handleSaveNewNoteSuccessful),
  TypedReducer<NoteState, SaveNewNoteFailed>(_handleSaveNewNoteFailed),
]);

NoteState _handleSaveNewNote(NoteState state, SaveNewNote action) =>
    state.rebuild((b) => b..status = NoteStatusEnum.saving);

NoteState _handleSaveNewNoteSuccessful(
        NoteState state, SaveNewNoteSuccessful action) =>
    state.rebuild((b) => b
      ..status = NoteStatusEnum.saved
      ..note.replace(action.note));

NoteState _handleSaveNewNoteFailed(NoteState state, SaveNewNoteFailed action) =>
    state.rebuild((b) => b
      ..status = NoteStatusEnum.initial
      ..exception = action.exception);

NoteState _handleSetNoteMode(NoteState state, SetNoteMode action) =>
    state.rebuild((b) => b..noteMode = action.mode);

NoteState _handleCreateNote(NoteState state, CreateNote action) =>
    state.rebuild((b) {
      final int now = DateTime.now().millisecondsSinceEpoch;
      final NoteDto initNote = NoteDto((b) => b
        ..dateCreated = now
        ..dateModified = now
        ..pinned = false);

      return b
        ..note.replace(initNote)
        ..status = NoteStatusEnum.initial;
    });

NoteState _handleDeleteNote(NoteState state, DeleteNote action) =>
    state.rebuild((b) => b..status = NoteStatusEnum.deleted);

NoteState _handlePermanentDeleteNoteSuccessful(
        NoteState state, PermanentDeleteNoteSuccessful action) =>
    state.rebuild((b) => b..status = NoteStatusEnum.deleted);

NoteState _handlePermanentDeleteNoteFailed(
        NoteState state, PermanentDeleteNoteFailed action) =>
    state.rebuild((b) => b..exception = action.exception);

NoteState _handleEditNote(NoteState state, EditNote action) =>
    state.rebuild((b) => b..status = NoteStatusEnum.editing);

NoteState _handleCancelEditNote(NoteState state, CancelEditNote action) =>
    state.rebuild((b) => b..status = NoteStatusEnum.viewing);

NoteState _handleSaveNote(NoteState state, SaveNote action) =>
    state.rebuild((b) => b..status = NoteStatusEnum.saved);

NoteState _handleUpdateTitle(NoteState state, UpdateTitle action) =>
    state.rebuild((b) => b..note.update((b) => b..title = action.title));

NoteState _handleUpdateNoteBody(NoteState state, UpdateNoteBody action) =>
    state.rebuild((b) => b..note.update((b) => b..description = action.body));

NoteState _handleAddTodo(NoteState state, AddTodo action) =>
    state.rebuild((b) => b
      ..note.update((b) => b
        ..todoList = ListBuilder([
          TodoDto((b) => b
            ..todo = action.todo
            ..done = false),
          ...b.todoList.build().toList()
        ])));

NoteState _handleRemoveTodo(NoteState state, RemoveTodo action) =>
    state.rebuild((b) => b
      ..note.update((b) => b
        ..todoList = ListBuilder([
          ...b.todoList.build().where((todo) => todo != action.todo).toList()
        ])));

NoteState _handleViewNote(NoteState state, ViewNote action) =>
    state.rebuild((b) => b
      ..note.replace(action.note)
      ..status = NoteStatusEnum.viewing);

NoteState _handlePinNote(NoteState state, PinNote action) =>
    state.rebuild((b) => b
      ..status = NoteStatusEnum.saved
      ..note.update((b) => b..pinned = action.pin));

NoteState _handleUpdatedNote(NoteState state, UpdatedNote action) =>
    state.rebuild((b) => b
      ..status = NoteStatusEnum.saved
      ..note.replace(action.note));

NoteState _handleEditTodo(NoteState state, EditTodo action) =>
    state.rebuild((b) {
      var toggledTodo =
          (action.todo.toBuilder()..todo = action.newTodoText).build();
      var todoIndexToReplace = action.note.todoList!.indexOf(action.todo);
      var newTodoList = action.note.todoList?.toList();
      newTodoList?.replaceRange(
          todoIndexToReplace, todoIndexToReplace + 1, [toggledTodo]);

      return b
        ..note.update((b) => b..todoList = ListBuilder([...?newTodoList]));
    });

NoteState _handleReorderTodo(NoteState state, ReorderTodo action) =>
    state.rebuild((b) {
      var newTodoList = action.note.todoList?.toList();
      var todoToMove = newTodoList![action.oldIndex];
      newTodoList.removeAt(action.oldIndex);
      newTodoList.insert(
          action.oldIndex < action.newIndex
              ? action.newIndex - 1
              : action.newIndex,
          todoToMove);

      return b..note.update((b) => b..todoList = ListBuilder([...newTodoList]));
    });

NoteState _handleCleanNotePage(NoteState state, CleanNotePage action) =>
    state = NoteState.initial();
