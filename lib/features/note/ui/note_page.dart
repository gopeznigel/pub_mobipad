import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/features/note/ui/note_loading_view.dart';
import 'package:mobipad/features/note/ui/note_title_view.dart';
import 'package:mobipad/features/note/ui/widgets/note_app_bar.dart';
import 'package:mobipad/features/note/ui/widgets/note_date_info_container.dart';
import 'package:mobipad/features/note/ui/widgets/note_page_will_pop.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

import 'body_view_selector.dart';

class NotePage extends StatelessWidget {
  static const String route = '/notePage';

  const NotePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, bool>(
        converter: (store) => store.state.noteState.status.isDeleted,
        onWillChange: (deletedBefore, deletedNow) {
          // Close note page if current status is deleted.
          // If old status is deleted, then do not close the page
          // it means that we already did a close page
          if ((deletedBefore != true) && deletedNow) {
            Navigator.pop(context);
          }
        },
        onDispose: (Store<AppState> store) {
          store.dispatch(CleanNotePage());
        },
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, _) {
    final body = Column(
      children: const <Widget>[
        NoteTitleView(),
        NoteDateInfoContainer(),
        Expanded(
          child: BodyViewSelector(),
        ),
      ],
    );

    final scaffold = Scaffold(
      backgroundColor: Colors.white,
      appBar: const NoteAppBar(),
      body: NoteLoadingView(
        child: body,
      ),
    );

    return NotePageWillPop(
      child: scaffold,
    );
  }
}
