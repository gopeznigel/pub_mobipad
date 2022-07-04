import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/note/ui/note_body_view.dart';
import 'package:mobipad/features/note/ui/todo_list_view.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';

class BodyViewSelector extends StatelessWidget {
  const BodyViewSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, NotePageViewModel>(
        converter: (store) => NotePageViewModel(store),
        builder: (context, viewModel) {
          if (viewModel.mode.isNote) {
            return const NoteBodyView();
          } else {
            return const TodoListView();
          }
        },
      );
}
