import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/common_widgets/note_snackbar.dart';
import 'package:mobipad/constants/oh_notes_icons.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

class NotePinButton extends StatelessWidget {
  const NotePinButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    return Visibility(
      visible: viewModel.canPinNote,
      child: IconButton(
        color: Colors.white,
        onPressed: () {
          final bool pin = !(viewModel.note!.pinned);

          store.dispatch(PinNote(note: viewModel.note!, pin: pin));

          showSnackbar(context, pin ? 'Pinned!' : 'Unpinned!');
        },
        icon: Icon((viewModel.note?.pinned ?? false)
            ? OhNotes.pin
            : OhNotes.pinBorder),
      ),
    );
  }
}
