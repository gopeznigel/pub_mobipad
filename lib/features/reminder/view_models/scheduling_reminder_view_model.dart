import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/features/reminder/state.dart';

class SchedulingReminderViewModel {
  final ReminderState _state;

  SchedulingReminderViewModel(this._state);

  bool get isBusy => _state.isBusy;

  ActionException? get exception => _state.exception;
}
