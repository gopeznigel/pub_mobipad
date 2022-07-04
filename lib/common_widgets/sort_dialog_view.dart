import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/settings/actions.dart';
import 'package:mobipad/features/settings/view_models/settings_view_model.dart';
import 'package:mobipad/state.dart';
import 'package:mobipad/styles/text_styles.dart';

class SortDialogView extends StatelessWidget {
  const SortDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, SettingsViewModel>(
        converter: (store) => SettingsViewModel(store.state),
        builder: _build,
      );

  Widget _build(BuildContext context, SettingsViewModel viewModel) {
    final options = <Map<String, dynamic>>[
      {
        'title': 'A-Z',
        'value': 'alpha',
        'icon': Icons.sort_by_alpha,
      },
      {
        'title': 'Date Created',
        'value': 'created',
        'icon': Icons.schedule,
      },
      {
        'title': 'Date Modified',
        'value': 'modified',
        'icon': Icons.slow_motion_video,
      },
    ];

    return Dialog(
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sort',
                  style: OhNotesTextStyles.appBarTitle.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                  children: List.generate(
                options.length,
                (i) => ListTile(
                  onTap: () {
                    StoreProvider.of<AppState>(context)
                        .dispatch(SetSort(options[i]['value']));
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    options[i]['icon'],
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    options[i]['title'],
                    style: TextStyle(
                        color: viewModel.selectedSorting
                                .contains(options[i]['value'])
                            ? Colors.lightBlueAccent
                            : Colors.black),
                  ),
                ),
              )),
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
