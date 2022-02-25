import 'package:mobipad/features/home/model.dart';

import '../../exception/action_exception.dart';

class ReminderState {
  ActionException exception;
  Note item;
  int remId;
  String type;

  ReminderState({this.exception, this.item, this.type, this.remId});

  ReminderState.initial()
      : item = null,
        type = null,
        remId = null,
        exception = null;
}
