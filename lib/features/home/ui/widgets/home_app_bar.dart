import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/common_widgets/dialogs/dialogs.dart';
import 'package:mobipad/features/settings/ui/settings_page.dart';
import 'package:mobipad/common_widgets/sort_dialog_view.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/home/actions.dart';
import 'package:mobipad/features/home/dtos.dart';
import 'package:mobipad/features/home/view_models/home_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:redux/redux.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => HomePageViewModel(context, store),
        builder: _build,
      );

  AppBar _build(BuildContext context, HomePageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    final searchAppBar = AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        onChanged: (String val) {
          store.dispatch(SearchNote(keyword: val));
        },
        autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          hintText: 'Search',
          hintStyle: OhNotesTextStyles.appBarTitle.copyWith(
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
        style: OhNotesTextStyles.appBarTitle.copyWith(
          color: Colors.black,
        ),
      ),
      leading: IconButton(
        onPressed: () => store.dispatch(EndNoteSearch()),
        icon: const Icon(Icons.close),
        color: Colors.black,
      ),
    );

    final normalAppBar = AppBar(
      title: Text(
        viewModel.appBarTitle,
        style: OhNotesTextStyles.appBarTitle.copyWith(
          color: Colors.white,
        ),
      ),
      backgroundColor: viewModel.appBarColor,
      elevation: 1,
      actions: <Widget>[
        Visibility(
          visible: !viewModel.homeViewMode.isArchived &&
              !viewModel.homeViewMode.isTrashed,
          child: IconButton(
            onPressed: () {
              store.dispatch(StartNoteSearch());
            },
            color: Colors.white,
            icon: const Icon(
              Icons.search,
            ),
          ),
        ),
        PopupMenuButton<String>(
          offset: const Offset(0, 50),
          onSelected: (String? value) {
            switch (value) {
              case 'Settings':
                Navigator.pushNamed(context, SettingsPage.route);
                break;
              case 'Sort':
                showDialog(
                    context: context,
                    builder: (context) => const SortDialogView());
                break;
              default:
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              {'name': 'Sort', 'icon': Icons.sort},
              {'name': 'Settings', 'icon': Icons.settings},
            ].map((Map<String, dynamic> choice) {
              return PopupMenuItem<String>(
                value: choice['name'],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(choice['icon'], color: Colors.black87),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      choice['name'],
                      style: OhNotesTextStyles.notePreviewBody.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ],
    );

    final multipleSelectAppBar = AppBar(
      backgroundColor: OhNotesColor.multipleSelectionAppBar,
      leading: IconButton(
        onPressed: (() => store
            .dispatch(const SetSelectionMode(mode: SelectionModeEnum.none))),
        icon: const Icon(Icons.close),
        color: Colors.black,
      ),
      title: Text(
        '${viewModel.selectedNotes.length}/${viewModel.notes.length}',
        style: OhNotesTextStyles.notePreviewBody.copyWith(
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (viewModel.selectedNotes.length == viewModel.notes.length) {
              store.dispatch(DeselectAllNotes());
            } else {
              store.dispatch(SelectAllNotes(notes: viewModel.notes));
            }
          },
          icon: Icon(
            viewModel.selectedNotes.length == viewModel.notes.length
                ? Icons.clear_all
                : Icons.select_all,
            color: Colors.black,
          ),
        ),
        Visibility(
          visible: viewModel.homeViewMode.isActive,
          child: IconButton(
            onPressed: () {
              showConfirmationDialog(
                      context, viewModel.pinMessage, viewModel.pinButtonLabel)
                  .then((value) {
                if (value) {
                  if (viewModel.multiPinStatus.isMultiPin) {
                    store.dispatch(
                        PinSelectedNotes(notes: viewModel.selectedNotes));
                  } else {
                    store.dispatch(
                        UnpinSelectedNotes(notes: viewModel.selectedNotes));
                  }
                }
              });
            },
            icon: viewModel.pinIcon,
          ),
        ),
        Visibility(
          visible: viewModel.homeViewMode.isActive,
          child: IconButton(
            onPressed: () => showConfirmationDialog(context,
                    viewModel.archiveMessage, viewModel.archiveButtonLabel)
                .then((value) {
              if (value) {
                store.dispatch(
                    ArchiveSelectedNotes(notes: viewModel.selectedNotes));
              }
            }),
            icon: Icon(
              Icons.archive,
              color: viewModel.selectedNotes.isNotEmpty
                  ? Colors.black
                  : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: viewModel.homeViewMode.isArchived,
          child: IconButton(
            onPressed: () => showConfirmationDialog(context,
                    viewModel.archiveMessage, viewModel.archiveButtonLabel)
                .then((value) {
              if (value) {
                store.dispatch(
                    UnarchiveSelectedNotes(notes: viewModel.selectedNotes));
              }
            }),
            icon: Icon(
              Icons.unarchive,
              color: viewModel.selectedNotes.isNotEmpty
                  ? Colors.black
                  : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: !viewModel.homeViewMode.isTrashed,
          child: IconButton(
            onPressed: () => showConfirmationDialog(context,
                    viewModel.deleteMessage, viewModel.deleteButtonLabel)
                .then((value) {
              if (value) {
                store.dispatch(
                    DeleteSelectedNotes(notes: viewModel.selectedNotes));
              }
            }),
            icon: Icon(
              Icons.delete,
              color: viewModel.selectedNotes.isNotEmpty
                  ? Colors.black
                  : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: viewModel.homeViewMode.isTrashed,
          child: IconButton(
            onPressed: () => showConfirmationDialog(context,
                    viewModel.restoreMessage, viewModel.restoreButtonLabel)
                .then((value) {
              if (value) {
                store.dispatch(
                    RestoreSelectedNotes(notes: viewModel.selectedNotes));
              }
            }),
            icon: Icon(
              Icons.settings_backup_restore,
              color: viewModel.selectedNotes.isNotEmpty
                  ? Colors.black
                  : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: viewModel.homeViewMode.isTrashed,
          child: IconButton(
            onPressed: () => showConfirmationDialog(context,
                    viewModel.deleteMessage, viewModel.deleteButtonLabel)
                .then((value) {
              if (value) {
                store.dispatch(
                    PermaDeleteSelectedNotes(notes: viewModel.selectedNotes));
              }
            }),
            icon: Icon(
              Icons.delete_forever,
              color: viewModel.selectedNotes.isNotEmpty
                  ? Colors.black
                  : Colors.black26,
            ),
          ),
        ),
      ],
    );

    if (viewModel.selectionMode.isMultiple) {
      return multipleSelectAppBar;
    } else if (viewModel.isSearching) {
      return searchAppBar;
    } else {
      return normalAppBar;
    }
  }
}
