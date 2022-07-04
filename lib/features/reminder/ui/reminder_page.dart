import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/features/reminder/ui/quick_reminder_dialog.dart';
import 'package:mobipad/features/reminder/ui/reminder_loading_view.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';

import '../view_models/reminder_page_view_model.dart';
import 'reminder_repeat_view.dart';

class ReminderPage extends StatelessWidget {
  static const String route = '/reminderPage';

  const ReminderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ReminderPageViewModel>(
        converter: (store) => ReminderPageViewModel(context, store.state),
        onDispose: (store) => store.dispatch(ResetReminder()),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, ReminderPageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    final setupReminder = Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Specify date and time',
            style: OhNotesTextStyles.appBarTitle,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white54,
                  backgroundColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: viewModel.withReminderId
                    ? null
                    : () async {
                        await showDialog(
                            context: context,
                            builder: (context) => const QuickReminderDialog());
                      },
                child: Text(
                  'Quick setup',
                  style: OhNotesTextStyles.drawerOptions.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select date',
              style: OhNotesTextStyles.reminderTitle.copyWith(
                color: Colors.cyan,
              ),
            ),
          ),
          TextButton(
            onPressed: viewModel.withReminderId
                ? null
                : () async {
                    var date = await showDatePicker(
                      context: context,
                      initialDate: viewModel.selectedDate,
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365 * 100)),
                    );
                    if (date != null) {
                      store
                        ..dispatch(SetDate(date: date))
                        ..dispatch(AutoSelectWeekDay(selectedDate: date));
                    }
                  },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('MM/dd/yyyy').format(viewModel.selectedDate),
                style: OhNotesTextStyles.notePreviewBody,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select time',
              style: OhNotesTextStyles.reminderTitle.copyWith(
                color: Colors.cyan,
              ),
            ),
          ),
          TextButton(
            onPressed: viewModel.withReminderId
                ? null
                : () async {
                    var time = await showTimePicker(
                      context: context,
                      initialTime: viewModel.selectedTime,
                    );

                    if (time != null) {
                      store.dispatch(SetTime(time: time));
                    }
                  },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                viewModel.selectedTime.format(context),
                style: OhNotesTextStyles.notePreviewBody,
              ),
            ),
          ),
        ],
      ),
    );

    final setupChoices = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        setupReminder,
        const Divider(
          color: Colors.grey,
          thickness: 0.75,
          height: 0,
        ),
        const ReminderRepeatView(),
      ],
    );

    return ReminderLoadingView(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: OhNotesColor.primary,
          title: Text(
            'Setup Reminder',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white54,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  if (viewModel.reminder!.remId == null) {
                    // Check if selected date and time is in the future
                    if (viewModel.isSelectedDateValid) {
                      store.dispatch(ScheduleReminder(
                          note: viewModel.note, reminder: viewModel.reminder!));
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Invalid Reminder'),
                          content: const Text(
                              'Please select a time somewhere in the future.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    store.dispatch(ClearReminder(
                        remId: viewModel.reminder!.remId!,
                        note: viewModel.note));
                  }
                },
                child: Text(
                  viewModel.withReminderId ? 'Clear' : 'Done',
                  style: OhNotesTextStyles.notePreviewBody.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: setupChoices,
        ),
      ),
    );
  }
}
