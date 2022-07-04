import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/home/actions.dart';
import 'package:mobipad/features/home/dtos.dart';
import 'package:mobipad/features/home/view_models/home_page_view_model.dart';
import 'package:mobipad/features/note/ui/note_page.dart';
import 'package:mobipad/state.dart';

import 'widgets/note_tile.dart';

class NotesView extends StatelessWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomePageViewModel>(
        converter: (store) => HomePageViewModel(context, store),
        onInitialBuild: (viewModel) => StoreProvider.of<AppState>(context)
            .dispatch(ListenToNotesUpdates(sort: viewModel.selectedSorting)),
        builder: _buildPage);
  }

  Widget _buildPage(BuildContext context, HomePageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: viewModel.notes
            .map(
              (note) => NoteTile(
                note: note,
                dateTimeDisplay: viewModel.selectedDateTimeDisplay,
                onTap: () {
                  // Select current tile if selectionMode is multiple
                  // else just open the note on the note page
                  if (viewModel.selectionMode.isMultiple) {
                    viewModel.addOrRemoveNoteFromList(note);
                  } else {
                    store
                      ..dispatch(SetNoteMode(
                          mode: (note.description?.isNotEmpty ?? false)
                              ? NoteModeEnum.note
                              : NoteModeEnum.todo))
                      ..dispatch(ViewNote(note: note));

                    Navigator.pushNamed(context, NotePage.route);
                  }
                },
                onLongPress: () {
                  // Set selection mode to multiple if not currently
                  if (!viewModel.selectionMode.isMultiple &&
                      !viewModel.isSearching) {
                    store
                      ..dispatch(const SetSelectionMode(
                          mode: SelectionModeEnum.multiple))
                      ..dispatch(AddNoteToSelection(note: note));
                  }
                },
                isSelected: viewModel.isNoteSelected(note),
              ),
            )
            .toList(),
      ),
    );
  }
}
