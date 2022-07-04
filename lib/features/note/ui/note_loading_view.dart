import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/common_widgets/dialogs/dialogs.dart';
import 'package:mobipad/features/note/dtos.dart';
import 'package:mobipad/state.dart';

class NoteLoadingView extends StatelessWidget {
  const NoteLoadingView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, NoteStatusEnum>(
        converter: ((store) => store.state.noteState.status),
        onWillChange: (oldStatus, newStatus) {
          if (!(oldStatus?.isSaving ?? false) && newStatus.isSaving) {
            showLoadingDialog(context);
          }

          if ((oldStatus?.isSaving ?? false) && !newStatus.isSaving) {
            Navigator.pop(context);
          }
        },
        builder: (context, _) => child,
      );
}
