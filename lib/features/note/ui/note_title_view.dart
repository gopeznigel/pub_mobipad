import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

class NoteTitleView extends StatefulWidget {
  const NoteTitleView({Key? key}) : super(key: key);

  @override
  State<NoteTitleView> createState() => _NoteTitleViewState();
}

class _NoteTitleViewState extends State<NoteTitleView> {
  final TextEditingController _titleController = TextEditingController();

  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, NotePageViewModel>(
        converter: (store) => NotePageViewModel(store),
        onInitialBuild: (viewModel) {
          _titleController.text = viewModel.title;

          // Place cursor at the end always
          _titleController.selection = TextSelection.fromPosition(
              TextPosition(offset: viewModel.title.length));
        },
        onDidChange: (_, viewModel) {
          if (_titleController.text.isEmpty && viewModel.title.isNotEmpty) {
            _titleController.text = viewModel.title;

            // Place cursor at the end always
            _titleController.selection = TextSelection.fromPosition(
                TextPosition(offset: viewModel.title.length));
          }
        },
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: viewModel.appBarColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 1),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: TextFormField(
        controller: _titleController,
        autofocus: false,
        readOnly: viewModel.readOnly,
        onChanged: (value) {
          // dispatch action to update note title
          store.dispatch(UpdateTitle(title: value));
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          hintText: 'Add Title',
          hintStyle: OhNotesTextStyles.notePreviewTitle.copyWith(
            color: Colors.white54,
          ),
          border: InputBorder.none,
        ),
        style: OhNotesTextStyles.notePreviewTitle.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
