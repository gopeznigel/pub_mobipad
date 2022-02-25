import '../../exception/action_exception.dart';
import '../home/model.dart';

class NoteState {
  bool isLoading;
  bool isEditing;
  Note note;
  ActionException exception;

  NoteState({this.isLoading, this.isEditing, this.note, this.exception});

  NoteState.initial()
      : isLoading = false,
        isEditing = false,
        note = null,
        exception = null;
}
