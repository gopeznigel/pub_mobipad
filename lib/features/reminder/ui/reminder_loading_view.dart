import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/common_widgets/note_snackbar.dart';
import 'package:mobipad/state.dart';

import '../view_models/scheduling_reminder_view_model.dart';

class ReminderLoadingView extends StatelessWidget {
  const ReminderLoadingView({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, SchedulingReminderViewModel>(
        converter: ((store) =>
            SchedulingReminderViewModel(store.state.reminderState)),
        onDidChange: (oldState, newState) {
          if ((oldState?.isBusy ?? false) && !newState.isBusy) {
            if (newState.exception == null) {
              // Close Reminder Page after saving reminder
              showSnackbar(context, 'Reminder setup finished!');
              Navigator.pop(context);
            } else {
              showSnackbar(context, newState.exception!.exception.toString());
            }
          }
        },
        builder: (context, _) => child,
      );
}
