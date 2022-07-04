import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/settings/view_models/settings_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/text_styles.dart';

import '../actions.dart';

class FontSizeDialogView extends StatelessWidget {
  const FontSizeDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, SettingsViewModel>(
        converter: (store) => SettingsViewModel(store.state),
        builder: _build,
      );

  Widget _build(BuildContext context, SettingsViewModel viewModel) {
    return Dialog(
      elevation: 0,
      child: SizedBox(
        height: 600,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Select font size',
                style: OhNotesTextStyles.button,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    viewModel.fontSizeNameList.length,
                    (i) => RadioListTile<int>(
                      groupValue: viewModel.selectedFontSize,
                      onChanged: (value) {
                        StoreProvider.of<AppState>(context)
                            .dispatch(SetFontSize(value!));
                        Navigator.pop(context);
                      },
                      value: viewModel.fontSizeList[i],
                      title: Text(viewModel.fontSizeNameList[i]),
                    ),
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
      ),
    );
  }
}
