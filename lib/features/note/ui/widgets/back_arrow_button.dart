import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    return GestureDetector(
      onTap: () async {
        if (await viewModel.canExit) {
          Navigator.pop(context);
        }
      },
      child: const Icon(
        Icons.arrow_back,
        size: 26.0,
        color: Colors.white,
      ),
    );
  }
}
