import '../../exception/action_exception.dart';

class SettingsState {
  ActionException exception;
  int fontSize;
  String sorting;
  String dateTimeDisplay;

  SettingsState(
      {this.fontSize, this.sorting, this.dateTimeDisplay, this.exception});

  SettingsState.initial()
      : fontSize = 50,
        dateTimeDisplay = 'Simple',
        sorting = 'modified',
        exception = null;
}
