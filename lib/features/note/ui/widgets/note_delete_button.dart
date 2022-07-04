import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/common_widgets/dialogs/dialogs.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

class NoteDeleteButton extends StatelessWidget {
  const NoteDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    return Visibility(
      visible: !viewModel.status.isEditing && !viewModel.status.isInitial,
      child: IconButton(
        color: Colors.white,
        onPressed: () async {
          final delete = await showConfirmationDialog(
              context, viewModel.deleteMessage, viewModel.deleteButtonLabel);

          if (delete) {
            viewModel.deleteNote();
          }
        },
        icon: Icon(!viewModel.noteCategory.isTrashed
            ? Icons.delete
            : Icons.delete_forever),
      ),
    );
  }
}
