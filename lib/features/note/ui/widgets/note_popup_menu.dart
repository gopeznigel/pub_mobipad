import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/common_widgets/dialogs/dialogs.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/ui/widgets/note_popup_menu_item.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/features/reminder/ui/reminder_page.dart';
import 'package:mobipad/state.dart';

class NotePopupMenu extends StatelessWidget {
  const NotePopupMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, NotePageViewModel>(
        converter: (store) => NotePageViewModel(store),
        builder: _buildMenu,
      );

  Widget _buildMenu(BuildContext context, NotePageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    return PopupMenuButton<NotePopupMenuEnum>(onSelected: (value) async {
      switch (value) {
        case NotePopupMenuEnum.reminder:
          store.dispatch(
              InitReminderSettings(reminder: viewModel.note!.reminder));
          Navigator.pushNamed(context, ReminderPage.route);
          break;
        case NotePopupMenuEnum.archive:
          final archive = await showConfirmationDialog(
              context, viewModel.archiveMessage, viewModel.archiveButtonLabel);

          if (archive) {
            store.dispatch(ArchiveNote(note: viewModel.note!));
          }

          break;
        case NotePopupMenuEnum.unarchive:
          final unarchive = await showConfirmationDialog(
              context, viewModel.archiveMessage, viewModel.archiveButtonLabel);

          if (unarchive) {
            store.dispatch(UnarchiveNote(note: viewModel.note!));
          }

          break;
        case NotePopupMenuEnum.restore:
          final restore = await showConfirmationDialog(
              context, viewModel.restoreMessage, viewModel.restoreButtonLabel);

          if (restore) {
            store.dispatch(RestoreNote(note: viewModel.note!));
          }

          break;
        default:
      }
    }, itemBuilder: (BuildContext context) {
      return viewModel.menus
          .map((menu) => PopupMenuItem<NotePopupMenuEnum>(
                value: menu.menu,
                child: NotePopupMenuItem(
                  disabled: viewModel.status.isEditing,
                  menu: menu,
                ),
              ))
          .toList();
    });
  }
}
