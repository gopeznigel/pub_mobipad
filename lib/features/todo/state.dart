import '../../exception/action_exception.dart';
import '../home/model.dart';

class TodoState {
  bool isLoading;
  bool isEditing;
  Note todo;
  ActionException exception;

  TodoState({this.isLoading, this.isEditing, this.todo, this.exception});

  TodoState.initial()
      : isLoading = false,
        isEditing = false,
        todo = null,
        exception = null;
}
