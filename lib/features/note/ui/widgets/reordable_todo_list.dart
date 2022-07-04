import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

import 'add_todo_dialog.dart';
import 'todo_list_item.dart';

class ReordableTodoList extends StatefulWidget {
  const ReordableTodoList({Key? key}) : super(key: key);

  @override
  State<ReordableTodoList> createState() => _ReordableTodoListState();
}

class _ReordableTodoListState extends State<ReordableTodoList> {
  Store<AppState> get store => StoreProvider.of(context);

  int draggingIndex = 0;
  bool dragging = false;

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _build,
      );

  Widget _build(BuildContext context, NotePageViewModel viewModel) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        store.dispatch(ReorderTodo(
            note: viewModel.note!, newIndex: newIndex, oldIndex: oldIndex));
      },
      children: viewModel.todos
          .map(
            (todo) => TodoListItem(
              key: UniqueKey(),
              fontSize: viewModel.selectedFontSize.toDouble(),
              editing: viewModel.status.isEditing || viewModel.status.isInitial,
              todoItem: todo.todo!,
              todoDone: todo.done!,
              deleteItem: () {
                store.dispatch(RemoveTodo(todo: todo));
              },
              toggleItem: () {
                store.dispatch(ToggleTodo(todo: todo, note: viewModel.note!));
              },
              editItem: () async {
                await showDialog(
                  context: context,
                  builder: (context) => AddTodoDialog(
                    todo: todo.todo,
                    onEditTodo: (String val) {
                      store.dispatch(EditTodo(
                          todo: todo, note: viewModel.note!, newTodoText: val));
                    },
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
