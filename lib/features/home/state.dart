import '../../exception/action_exception.dart';
import 'model.dart';

class HomeState {
  bool isLoading;
  bool isSearching;
  bool multipleSelectionMode;
  bool archiveMode;
  bool trashMode;
  List<Note> noteList;
  ActionException exception;
  String sorting;

  HomeState(
      {this.isSearching,
      this.isLoading,
      this.multipleSelectionMode,
      this.archiveMode,
      this.trashMode,
      this.noteList,
      this.exception});

  HomeState.initial()
      : isLoading = false,
        isSearching = false,
        multipleSelectionMode = false,
        archiveMode = false,
        trashMode = false,
        noteList = List.unmodifiable(<Note>[]),
        exception = null;
}
