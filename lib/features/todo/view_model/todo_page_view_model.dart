import '../../../exception/action_exception.dart';
import '../../../state.dart';
import '../../home/model.dart';

class TodoPageViewModel {
  final AppState _state;

  TodoPageViewModel(this._state);

  String get userId => _state.loginState.user.userId;
  String get email => _state.loginState.user.email;
  Note get todo => _state.todoState.todo;
  bool get isEditing => _state.todoState.isEditing;
  bool get isLoading => _state.todoState.isLoading;
  int get fontSize => _state.settingsState.fontSize;
  String get dateTimeDisplay => _state.settingsState.dateTimeDisplay;

  int get dateArchived => todo?.dateArchived ?? 0;
  int get dateDeleted => todo?.dateDeleted ?? 0;
  bool get archiveMode => dateArchived > 0;
  bool get trashMode => dateDeleted > 0;

  ActionException get exception => _state.todoState.exception;
}
