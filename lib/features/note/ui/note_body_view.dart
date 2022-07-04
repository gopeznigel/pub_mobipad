import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/constants/assets.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

class NoteBodyView extends StatefulWidget {
  const NoteBodyView({Key? key}) : super(key: key);

  @override
  State<NoteBodyView> createState() => _NoteBodyViewState();
}

class _NoteBodyViewState extends State<NoteBodyView> {
  final TextEditingController _noteController = TextEditingController();

  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _noteController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, NotePageViewModel>(
        converter: (store) => NotePageViewModel(store),
        onInitialBuild: (viewModel) {
          _noteController.text = viewModel.noteBody;

          // Place cursor at the end always
          _noteController.selection = TextSelection.fromPosition(
              TextPosition(offset: viewModel.noteBody.length));
        },
        onDidChange: (_, viewModel) {
          if (_noteController.text.isEmpty && viewModel.noteBody.isNotEmpty) {
            _noteController.text = viewModel.noteBody;

            // Place cursor at the end always
            _noteController.selection = TextSelection.fromPosition(
                TextPosition(offset: viewModel.noteBody.length));
          }
        },
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    final descriptionImage = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image.asset(
              noteArt,
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Create a \nNote here',
            textAlign: TextAlign.center,
            style: OhNotesTextStyles.notePreviewTitle.copyWith(
              color: Colors.black38,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );

    final description = TextFormField(
      controller: _noteController,
      autofocus: false,
      readOnly: viewModel.readOnly,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        hintText: 'Type Something . . .',
        border: InputBorder.none,
      ),
      onChanged: (value) {
        // dispatch action to update note body
        store.dispatch(UpdateNoteBody(body: value));
      },
      style: OhNotesTextStyles.notePreviewTitle.copyWith(
        color: Colors.black,
        fontSize: viewModel.selectedFontSize.toDouble(),
      ),
    );

    return GestureDetector(
      onDoubleTap: () {
        if (!viewModel.status.isEditing && !viewModel.noteCategory.isTrashed) {
          store.dispatch(EditNote());
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            description,
            viewModel.noteBody.isEmpty ? descriptionImage : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
