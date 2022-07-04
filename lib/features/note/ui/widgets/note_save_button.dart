import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

class NoteSaveButton extends StatelessWidget {
  const NoteSaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    return Visibility(
      visible: viewModel.status.isEditing || viewModel.status.isInitial,
      child: IconButton(
        color: Colors.white,
        onPressed: viewModel.canDoSave
            ? () {
                if (viewModel.withNoteId) {
                  store.dispatch(SaveNote(note: viewModel.note!));
                } else {
                  store.dispatch(SaveNewNote(newNote: viewModel.note!));
                }
              }
            : null,
        icon: const Icon(Icons.save),
      ),
    );
  }
}
