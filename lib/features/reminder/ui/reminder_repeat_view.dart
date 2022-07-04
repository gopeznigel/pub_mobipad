import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/constants/reminder_objects.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/features/reminder/view_models/reminder_page_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/text_styles.dart';

import 'widgets/day_check_box.dart';
import 'widgets/repeat_radio_tile.dart';

class ReminderRepeatView extends StatelessWidget {
  const ReminderRepeatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, ReminderPageViewModel>(
        converter: (store) => ReminderPageViewModel(context, store.state),
        builder: _build,
      );

  Widget _build(BuildContext context, ReminderPageViewModel viewModel) {
    final store = StoreProvider.of<AppState>(context);

    final repeatSelection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Select repetition',
            style: OhNotesTextStyles.reminderTitle.copyWith(
              color: Colors.cyan,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(repeat.length, (i) {
              return RepeatRadioTile(
                groupValue: viewModel.selectedRepeat,
                value: i,
                onChanged: viewModel.withReminderId
                    ? null
                    : (int value) {
                        store.dispatch(SetRepeat(repeatValue: value));

                        if (i == 5) {
                          store.dispatch(ResetSelectedWeekDay());
                        } else {
                          store.dispatch(AutoSelectWeekDay(
                              selectedDate: viewModel.selectedDate));
                        }
                      },
                title: repeat[i]['name'],
              );
            }),
          ),
        ),
      ],
    );

    final daysSelection = Visibility(
      visible: viewModel.selectedRepeat == 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select day/s',
              style: OhNotesTextStyles.reminderTitle.copyWith(
                color: Colors.cyan,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(viewModel.reminder!.days!.length, (i) {
                return DayCheckBox(
                  count: viewModel.numberOfWeekDaySelected,
                  repetition: viewModel.selectedRepeat,
                  value: viewModel.reminder!.days![i].value!,
                  onChanged: viewModel.withReminderId
                      ? null
                      : (value) {
                          store.dispatch(
                              UpdateReminderDays(dayIndex: i, value: value));
                        },
                  title: days[i]['name'],
                );
              }),
            ),
          ),
        ],
      ),
    );

    final repeatSetup = Column(
      children: [
        CheckboxListTile(
          value: viewModel.onRepeat,
          title: Text(
            'Repeat reminder',
            style: OhNotesTextStyles.appBarTitle.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            viewModel.repeatDescription,
            style: OhNotesTextStyles.notePreviewBody,
          ),
          onChanged: viewModel.withReminderId
              ? null
              : (repeat) {
                  if (repeat != null) {
                    store.dispatch(SetOnRepeat(repeat: repeat));
                  }
                },
        ),
        Visibility(
          visible: viewModel.onRepeat,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                repeatSelection,
                daysSelection,
              ],
            ),
          ),
        ),
      ],
    );

    return repeatSetup;
  }
}
