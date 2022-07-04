import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/settings/ui/date_time_display_dialog_view.dart';
import 'package:mobipad/features/settings/ui/font_size_dialog_view.dart';
import 'package:mobipad/common_widgets/sort_dialog_view.dart';
import 'package:mobipad/features/settings/view_models/settings_view_model.dart';
import 'package:mobipad/state.dart';

import 'widgets/settings_group.dart';
import 'widgets/settings_item.dart';

class GeneralSettingsView extends StatelessWidget {
  const GeneralSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      StoreConnector<AppState, SettingsViewModel>(
          converter: (store) => SettingsViewModel(store.state),
          builder: _build);

  Widget _build(BuildContext context, SettingsViewModel viewModel) {
    return SettingsGroup(
      title: 'General',
      items: [
        SettingsItem(
          title: 'Font Size',
          subTitle: viewModel.fontSizeNameList[
              viewModel.fontSizeList.indexOf(viewModel.selectedFontSize)],
          onTap: () async {
            await showFontSizePickerDialog(context, viewModel.selectedFontSize);
          },
        ),
        SettingsItem(
          title: 'Sorting',
          subTitle: viewModel.selectedSorting == 'alpha'
              ? viewModel.sortingTitle[0]
              : viewModel.selectedSorting == 'created'
                  ? viewModel.sortingTitle[1]
                  : viewModel.sortingTitle[2],
          onTap: () async {
            await showSortingPickerDialog(context, viewModel.selectedSorting);
          },
        ),
        SettingsItem(
          title: 'Date/Time Display',
          subTitle: viewModel.selectedDateTimeDisplay,
          onTap: () async {
            await showDateTimeDisplayPickerDialog(
                context, viewModel.selectedDateTimeDisplay);
          },
        ),
      ],
    );
  }
}

Future<void> showFontSizePickerDialog(
    BuildContext context, int selectedFontSize) async {
  await showDialog(
    context: context,
    builder: (context) => const FontSizeDialogView(),
  );
}

Future<void> showSortingPickerDialog(
    BuildContext context, String? selectedSorting) async {
  await showDialog(
    context: context,
    builder: (context) => const SortDialogView(),
  );
}

Future<void> showDateTimeDisplayPickerDialog(
    BuildContext context, String? selectedDateTimeDisplay) async {
  await showDialog(
    context: context,
    builder: (context) => const DateTimeDisplayDialogView(),
  );
}
