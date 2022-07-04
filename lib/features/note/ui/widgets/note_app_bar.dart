import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/note/ui/widgets/note_popup_menu.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

import 'back_arrow_button.dart';
import 'note_delete_button.dart';
import 'note_edit_button.dart';
import 'note_pin_button.dart';
import 'note_save_button.dart';

class NoteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NoteAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    return AppBar(
      backgroundColor: viewModel.appBarColor,
      elevation: 0,
      leading: const BackArrowButton(),
      actions: const <Widget>[
        NotePinButton(),
        NoteEditButton(),
        NoteDeleteButton(),
        NoteSaveButton(),
        NotePopupMenu(),
      ],
    );
  }
}
