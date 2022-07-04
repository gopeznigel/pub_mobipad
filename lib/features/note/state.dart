import 'package:built_value/built_value.dart';
import 'package:mobipad/exception/action_exception.dart';
import 'package:mobipad/core/dtos.dart';

import 'dtos.dart';

part 'state.g.dart';

abstract class NoteState implements Built<NoteState, NoteStateBuilder> {
  factory NoteState([void Function(NoteStateBuilder b) updates]) = _$NoteState;

  factory NoteState.initial() => _$NoteState._(
        noteMode: NoteModeEnum.note,
        status: NoteStatusEnum.none,
      );

  NoteState._();

  NoteModeEnum get noteMode;
  NoteStatusEnum get status;
  NoteDto? get note;
  ActionException? get exception;
}
