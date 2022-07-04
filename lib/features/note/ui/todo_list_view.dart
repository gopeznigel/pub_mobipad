import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/constants/assets.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/features/note/ui/widgets/add_todo_item_button.dart';
import 'package:mobipad/features/note/ui/widgets/reordable_todo_list.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

import '../view_models/note_page_view_model.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    final todoImage = SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tap button \nbelow to add a \nTodo item',
                  textAlign: TextAlign.center,
                  style: OhNotesTextStyles.notePreviewBody.copyWith(
                    color: Colors.black38,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.arrow_downward,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Image.asset(
                todoArt,
                alignment: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );

    return Column(
      children: [
        Expanded(
          child:
              viewModel.todos.isEmpty ? todoImage : const ReordableTodoList(),
        ),
        const AddTodoItemButton(),
      ],
    );
  }
}
