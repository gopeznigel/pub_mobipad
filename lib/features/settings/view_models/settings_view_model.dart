import 'package:mobipad/state.dart';

class SettingsViewModel {
  final AppState _state;

  SettingsViewModel(this._state);

  int get selectedFontSize => _state.settingsState.selectedFontSize;

  String get selectedDateTimeDisplay =>
      _state.settingsState.selectedDateTimeDisplay;

  String get selectedSorting => _state.settingsState.selectedSorting;

  List<String> get fontSizeNameList => <String>[
        'Gigantic',
        'Huge',
        'Large',
        'Medium',
        'Small',
        'Tiny',
        'Microscopic'
      ];

  List<int> get fontSizeList => <int>[
        100,
        50,
        30,
        20, // Default
        18,
        15,
        12,
      ];

  List<String> get sortingTitle => <String>[
        'A-Z',
        'Date Created',
        'Date Modified',
      ];

  List<Map<String, String>> get dateTimeDisplayList => <Map<String, String>>[
        {'title': 'Simple', 'sample': '2 weeks ago'}, // default
        {'title': 'Date/Time', 'sample': '10:00 pm'},
        {'title': 'Date & Time', 'sample': '25/12/2019\n10:00 pm'},
        {'title': 'Date Only', 'sample': 'Dec 25'},
      ];
}
