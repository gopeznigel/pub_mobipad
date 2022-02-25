import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobipad/features/settings/actions.dart';
import 'package:mobipad/features/settings/ui/privacy_page.dart';
import 'package:mobipad/features/settings/ui/widgets/settings_group.dart';
import 'package:mobipad/features/settings/ui/widgets/settings_item.dart';
import 'package:mobipad/features/settings/view_model.dart/settings_page_view_model.dart';
import 'package:mobipad/utils/dialogs/date_time_display_dialog.dart';
import 'package:mobipad/utils/dialogs/font_size_dialog.dart';
import 'package:mobipad/utils/dialogs/sort_dialog.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';

class SettingsPage extends StatefulWidget {
  static const String route = '/settingsPage';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Store<AppState> get store => StoreProvider.of(context);

  /* ########################## APP VERSION ########################## */
  final String appVersion = '1.1.3';

  final List<String> fontSizeNameList = <String>[
    'Gigantic',
    'Huge',
    'Large',
    'Medium',
    'Small',
    'Tiny',
    'Microscopic'
  ];

  final List<int> fontSizeList = <int>[
    200,
    100,
    75,
    50,
    40,
    30,
    20,
  ];

  final List<String> sortingTitle = <String>[
    'A-Z',
    'Date Created',
    'Date Modified',
  ];

  final List<Map<String, String>> dateTimeDisplayList = <Map<String, String>>[
    {'title': 'Simple', 'sample': '2 weeks ago'}, // default
    {'title': 'Date/Time', 'sample': '10:00 pm'},
    {'title': 'Date & Time', 'sample': '25/12/2019\n10:00 pm'},
    {'title': 'Date Only', 'sample': 'Dec 25'},
  ];

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) =>
            SettingsPageViewModel(store.state),
        onInit: (store) => store.dispatch(GetFontSize()),
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, SettingsPageViewModel viewModel) {
    var email = viewModel.email;
    var fontSize = viewModel?.fontSize ?? 50;
    var sorting = viewModel.sorting;
    var dateTimeDisplay = viewModel.dateTimeDisplay;

    final _account = SettingsGroup(
      title: 'Account',
      items: [
        SettingsItem(
          title: 'Email',
          subTitle: email,
        ),
      ],
    );

    final _general = SettingsGroup(
      title: 'General',
      items: [
        SettingsItem(
          title: 'Font Size',
          subTitle: fontSizeNameList[fontSizeList.indexOf(fontSize)],
          onTap: () {
            showFontSizePickerDialog(context, fontSize);
          },
        ),
        SettingsItem(
          title: 'Sorting',
          subTitle: sorting == 'alpha'
              ? sortingTitle[0]
              : sorting == 'created'
                  ? sortingTitle[1]
                  : sortingTitle[2],
          onTap: () {
            showSortingPickerDialog(context, sorting);
          },
        ),
        SettingsItem(
          title: 'Date/Time Display',
          subTitle: dateTimeDisplay,
          onTap: () {
            showDateTimeDisplayPickerDialog(context, dateTimeDisplay);
          },
        ),
      ],
    );

    final _about = SettingsGroup(
      title: 'Help',
      items: [
        SettingsItem(
          title: 'About Oh Notes!',
          subTitle: 'App information',
          trail: Icon(
            Icons.info,
            color: Color(0xFF606060),
            size: 20,
          ),
          onTap: () async {
            final _logo = Image.asset(
              'assets/icons/oh-notes_logo.png',
              height: MediaQuery.of(context).size.height * 0.1,
            );

            showAboutDialog(
                context: context,
                applicationIcon: _logo,
                applicationName: 'Oh Notes!',
                applicationVersion: appVersion,
                applicationLegalese: '©2020 Tap Console');
          },
        ),
        SettingsItem(
          title: 'Official Site',
          subTitle: 'Visit our page',
          trail: Icon(
            Icons.public,
            color: Color(0xFF606060),
            size: 20,
          ),
          onTap: () {
            Navigator.pushNamed(context, PrivacyPage.route,
                arguments: 'https://oh-notes.flycricket.io/');
          },
        ),
        SettingsItem(
          title: 'Privacy Policy',
          subTitle: 'See app privacy policy',
          trail: Icon(
            Icons.public,
            color: Color(0xFF606060),
            size: 20,
          ),
          onTap: () {
            Navigator.pushNamed(context, PrivacyPage.route,
                arguments: 'https://oh-notes.flycricket.io/privacy.html');
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _account,
            _general,
            _about,
          ],
        ),
      ),
    );
  }

  Future<void> showFontSizePickerDialog(BuildContext context, int fontSize) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 0,
        child: FontSizeDialog(
          onChanged: (value) {
            store.dispatch(SetFontSize(value));
            Navigator.pop(context);
          },
          fontSize: fontSize,
          fontSizeList: fontSizeList,
          fontSizeNameList: fontSizeNameList,
        ),
      ),
    );
  }

  Future<void> showSortingPickerDialog(BuildContext context, String sorting) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 0,
        child: SortDialog(
          onTap: (value) {
            store.dispatch(SortNotes(value));
          },
          sorting: sorting,
        ),
      ),
    );
  }

  Future<void> showDateTimeDisplayPickerDialog(
      BuildContext context, String dateTimeDisplay) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 0,
        child: DateTimeDisplayDialog(
          onChanged: (value) {
            store.dispatch(SetDateTimeDisplay(value));
            Navigator.pop(context);
          },
          dateTimeDisplay: dateTimeDisplay,
          dateTimeDisplayList: dateTimeDisplayList,
        ),
      ),
    );
  }
}
