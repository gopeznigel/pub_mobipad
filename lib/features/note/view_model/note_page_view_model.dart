import 'package:mobipad/state.dart';

import '../../../exception/action_exception.dart';
import '../../home/model.dart';

class NotePageViewModel {
  final AppState _state;

  NotePageViewModel(this._state);

  String get userId => _state.loginState.user.userId;
  String get email => _state.loginState.user.email;
  Note get note => _state.noteState.note;
  bool get isEditing => _state.noteState.isEditing;
  bool get isLoading => _state.noteState.isLoading;
  int get fontSize => _state.settingsState.fontSize;
  String get dateTimeDisplay => _state.settingsState.dateTimeDisplay;

  int get dateArchived => note?.dateArchived ?? 0;
  int get dateDeleted => note?.dateDeleted ?? 0;
  bool get archiveMode => dateArchived > 0;
  bool get trashMode => dateDeleted > 0;

  ActionException get exception => _state.noteState.exception;
}
