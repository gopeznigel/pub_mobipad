import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/ui/widgets/add_todo_dialog.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';

class AddTodoItemButton extends StatelessWidget {
  const AddTodoItemButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, NotePageViewModel>(
        builder: _build,
        converter: (store) => NotePageViewModel(store),
      );

  Widget _build(BuildContext context, NotePageViewModel viewModel) {
    return Visibility(
      visible: viewModel.status.isEditing || viewModel.status.isInitial,
      child: InkWell(
        onTap: () async {
          await showDialog(
            context: context,
            builder: (context) => AddTodoDialog(
              onAddTodo: (String todo) {
                StoreProvider.of<AppState>(context)
                    .dispatch(AddTodo(todo: todo));
              },
            ),
          );
        },
        child: Ink(
          width: double.infinity,
          height: 40,
          // color: Colors.blueGrey[50],
          color: Theme.of(context).colorScheme.secondary,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                'Add',
                style: OhNotesTextStyles.notePreviewTitle.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
