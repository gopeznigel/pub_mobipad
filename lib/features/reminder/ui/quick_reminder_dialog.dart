import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/constants/reminder_objects.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/text_styles.dart';

class QuickReminderDialog extends StatelessWidget {
  const QuickReminderDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return Dialog(
      child: SizedBox(
        height: 600,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Quick reminder',
                style: OhNotesTextStyles.reminderTitle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: quickMins.length,
                itemBuilder: (context, i) => RadioListTile<int?>(
                  groupValue: null,
                  onChanged: (val) {
                    if (val != null) {
                      var selDate = DateTime.now().add(quickMins[i]['value']);

                      store
                        ..dispatch(SetDate(date: selDate))
                        ..dispatch(
                            SetTime(time: TimeOfDay.fromDateTime(selDate)));
                    }

                    Navigator.pop(context);
                  },
                  value: i,
                  title: Text('${quickMins[i]['name']}'),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 30),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text(
                      'Cancel',
                      style: OhNotesTextStyles.reminderTitle.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
