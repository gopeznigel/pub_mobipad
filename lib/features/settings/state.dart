import 'package:built_value/built_value.dart';
import 'package:mobipad/exception/action_exception.dart';

part 'state.g.dart';

abstract class SettingsState
    implements Built<SettingsState, SettingsStateBuilder> {
  factory SettingsState([void Function(SettingsStateBuilder b) updates]) =
      _$SettingsState;

  factory SettingsState.initial() => _$SettingsState._(
        isBusy: false,
        selectedSorting: 'modified',
        selectedDateTimeDisplay: 'Simple',
        selectedFontSize: 50,
      );

  SettingsState._();

  bool get isBusy;
  String get selectedSorting;
  String get selectedDateTimeDisplay;
  int get selectedFontSize;

  ActionException? get exception;
}
