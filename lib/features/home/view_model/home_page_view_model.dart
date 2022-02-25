import '../../../state.dart';
import '../model.dart';

class HomePageViewModel {
  final AppState _store;

  HomePageViewModel(this._store);

  String get userId => _store.loginState.user?.userId;
  String get email => _store.loginState.user?.email;
  bool get newLogin => _store.loginState.newLogin ?? true;

  String get sorting => _store.settingsState.sorting;
  String get dateTimeDisplay => _store.settingsState.dateTimeDisplay;

  bool get isLoading => _store.homeState.isLoading;
  List<Note> get noteList => _store.homeState.noteList;
  bool get isSearching => _store.homeState.isSearching;
  bool get multipleSelectionMode => _store.homeState.multipleSelectionMode;
  bool get archiveMode => _store.homeState.archiveMode;
  bool get trashMode => _store.homeState.trashMode;

  List<Note> search(String searchKey) {
    var notes = <Note>[];

    for (var note in noteList) {
      var title = note.title?.toLowerCase() ?? '';
      var description = note.description?.toLowerCase() ?? '';
      var todos = '';

      for (var element in note.todoList ?? []) {
        todos += '• ' + element.todo?.toLowerCase() ?? '' ' ';
      }

      if (title.contains(searchKey.toLowerCase()) ||
          description.contains(searchKey.toLowerCase()) ||
          todos.contains(searchKey.toLowerCase())) {
        notes.add(note);
      }
    }

    return notes;
  }
}
