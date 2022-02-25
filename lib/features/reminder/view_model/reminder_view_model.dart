import '../../../exception/action_exception.dart';
import '../../../state.dart';
import '../../home/model.dart';

class ReminderViewModel {
  final AppState _state;

  ReminderViewModel(this._state);

  Note get item => _state.reminderState.item;
  String get type => _state.reminderState.type;
  ActionException get exception => _state.reminderState.exception;
  int get remId => _state.reminderState.remId;
}
