import 'package:built_value/built_value.dart';
import 'package:flutter/material.dart' as material;
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/exception/action_exception.dart';

part 'state.g.dart';

abstract class ReminderState
    implements Built<ReminderState, ReminderStateBuilder> {
  factory ReminderState([void Function(ReminderStateBuilder b) updates]) =
      _$ReminderState;

  factory ReminderState.initial() => _$ReminderState._(
        onRepeat: false,
        isBusy: false,
      );

  ReminderState._();

  bool get onRepeat;
  DateTime? get selectedDate;
  material.TimeOfDay? get selectedTime;
  ReminderDto? get reminder;
  bool get isBusy;
  ActionException? get exception;
}
