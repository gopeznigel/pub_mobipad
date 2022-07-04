import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/settings/view_models/settings_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/text_styles.dart';

import '../actions.dart';

class DateTimeDisplayDialogView extends StatelessWidget {
  const DateTimeDisplayDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, SettingsViewModel>(
        converter: (store) => SettingsViewModel(store.state),
        builder: _build,
      );

  Widget _build(BuildContext context, SettingsViewModel viewModel) {
    return Dialog(
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Select date & time display',
                  style: OhNotesTextStyles.button,
                ),
              ),
              Column(
                children: List.generate(
                  viewModel.dateTimeDisplayList.length,
                  (i) => RadioListTile<String?>(
                    groupValue: viewModel.selectedDateTimeDisplay,
                    onChanged: (value) {
                      StoreProvider.of<AppState>(context)
                          .dispatch(SetDateTimeDisplay(value!));
                      Navigator.pop(context);
                    },
                    value: viewModel.dateTimeDisplayList[i]['title'],
                    title: Text(viewModel.dateTimeDisplayList[i]['title']!),
                    secondary: Text(
                      '(${viewModel.dateTimeDisplayList[i]['sample']})',
                      style: const TextStyle(color: Colors.grey),
                    ),
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
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
