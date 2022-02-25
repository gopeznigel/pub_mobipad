import '../../services/note_api.dart';
import '../home/model.dart';

class NoteApi {
  NoteApi(this._api) : assert(_api != null);

  final Api _api;

  Future<List<Note>> fetchNotes(String sort) async {
    var pinnedResult = await _api.getDataCollectionPinned(sort);
    var pinnedNotes = pinnedResult.docs
        .map((doc) => Note.fromJson(doc.data(), doc.id))
        .toList();

    var result = await _api.getDataCollection(sort);
    var notes =
        result.docs.map((doc) => Note.fromJson(doc.data(), doc.id)).toList();

    return pinnedNotes + notes;
  }

  Future<Note> getNoteById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Note.fromJson(doc.data(), doc.id);
  }

  Future removeNote(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateNote(Note note) async {
    _api.updateNote(note.toJson(), note.id);
    return;
  }

  Future unarchive(Note note) async {
    final newNote = Note(
      id: note.id,
      title: note.title,
      description: note.description,
      todoList: note.todoList,
      pinned: false,
      reminder: note.reminder,
      dateCreated: note.dateCreated,
      dateModified: note.dateModified,
      dateDeleted: 0,
      dateArchived: 0,
    );

    _api.updateNote(newNote.toJson(), newNote.id);
    return;
  }

  Future restore(Note note) async {
    final newNote = Note(
      id: note.id,
      title: note.title,
      description: note.description,
      todoList: note.todoList,
      pinned: false,
      reminder: note.reminder,
      dateCreated: note.dateCreated,
      dateModified: note.dateModified,
      dateDeleted: 0,
      dateArchived: 0,
    );

    _api.updateNote(newNote.toJson(), newNote.id);
    return;
  }

  Future moveToTrash(Note note) async {
    final newNote = Note(
      id: note.id,
      title: note.title,
      description: note.description,
      todoList: note.todoList,
      pinned: false,
      reminder: Reminder(),
      dateCreated: note.dateCreated,
      dateModified: note.dateModified,
      dateDeleted: DateTime.now().millisecondsSinceEpoch,
      dateArchived: 0,
    );

    _api.updateNote(newNote.toJson(), newNote.id);
    return;
  }

  Future moveToArchive(Note note) async {
    final newNote = Note(
      id: note.id,
      title: note.title,
      description: note.description,
      todoList: note.todoList,
      pinned: false,
      reminder: note.reminder,
      dateCreated: note.dateCreated,
      dateModified: note.dateModified,
      dateDeleted: 0,
      dateArchived: DateTime.now().millisecondsSinceEpoch,
    );

    _api.updateNote(newNote.toJson(), newNote.id);
    return;
  }

  Future<Note> addNote(Note note, List<Note> notes) async {
    _api.addNote(note.toJson());

    var currentIdList = [];
    var newIdList = [];

    for (var n in notes) {
      currentIdList.add(n.id);
    }

    var newNoteList = [];

    while (newNoteList.length < notes.length) {
      newNoteList = await fetchNotes(null);
    }

    for (var n in newNoteList) {
      newIdList.add(n.id);
    }

    // remove all current ids from the new ids. The remaining one is the newly created note/document id
    for (var id in currentIdList) {
      newIdList.remove(id);
    }

    return await getNoteById(newIdList[0]);
  }
}
