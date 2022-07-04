import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/note/view_models/note_page_view_model.dart';
import 'package:mobipad/state.dart';

class NotePageWillPop extends StatelessWidget {
  const NotePageWillPop({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, NotePageViewModel>(
        converter: (store) => NotePageViewModel(store),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    return WillPopScope(
      onWillPop: () async {
        return await viewModel.canExit;
      },
      child: child,
    );
  }
}
