import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/note_api.dart';
import 'model.dart';

class HomeApi {
  HomeApi(this._api) : assert(_api != null);

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

  Stream<QuerySnapshot> fetchNotesAsStream() {
    return _api.getStream();
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

  void initCollection(String userId) {
    _api.initCollection(userId);
  }

  Future deleteMultiple(List<Note> notes, List<int> selectedIndex) async {
    for (var index in selectedIndex) {
      await _api.removeDocument(notes[index].id);
    }
    return;
  }

  Future moveToTrashMultiple(List<Note> notes, List<int> selectedIndex) async {
    void iter(index) {
      var note = Note(
          id: notes[index].id,
          title: notes[index].title,
          dateCreated: notes[index].dateCreated,
          dateDeleted: DateTime.now().millisecondsSinceEpoch,
          dateModified: notes[index].dateModified,
          dateArchived: 0,
          description: notes[index].description,
          pinned: notes[index].pinned,
          todoList: notes[index].todoList,
          reminder: notes[index].reminder);
      _api.updateNote(note.toJson(), notes[index].id);
    }

    selectedIndex.forEach(iter);
    return;
  }

  Future moveToArchiveMultiple(
      List<Note> notes, List<int> selectedIndex) async {
    void iter(index) {
      var note = Note(
          id: notes[index].id,
          title: notes[index].title,
          dateCreated: notes[index].dateCreated,
          dateDeleted: 0,
          dateModified: notes[index].dateModified,
          dateArchived: DateTime.now().millisecondsSinceEpoch,
          description: notes[index].description,
          pinned: false,
          todoList: notes[index].todoList,
          reminder: notes[index].reminder);
      _api.updateNote(note.toJson(), notes[index].id);
    }

    selectedIndex.forEach(iter);
    return;
  }

  Future unarchiveMultiple(List<Note> notes, List<int> selectedIndex) async {
    void iter(index) {
      var note = Note(
          id: notes[index].id,
          title: notes[index].title,
          dateCreated: notes[index].dateCreated,
          dateDeleted: notes[index].dateDeleted,
          dateModified: notes[index].dateModified,
          dateArchived: 0,
          description: notes[index].description,
          pinned: notes[index].pinned,
          todoList: notes[index].todoList,
          reminder: notes[index].reminder);
      _api.updateNote(note.toJson(), notes[index].id);
    }

    selectedIndex.forEach(iter);
    return;
  }

  Future restoreMultiple(List<Note> notes, List<int> selectedIndex) async {
    void iter(index) {
      var note = Note(
          id: notes[index].id,
          title: notes[index].title,
          dateCreated: notes[index].dateCreated,
          dateDeleted: 0,
          dateModified: notes[index].dateModified,
          dateArchived: 0,
          description: notes[index].description,
          pinned: notes[index].pinned,
          todoList: notes[index].todoList,
          reminder: notes[index].reminder);
      _api.updateNote(note.toJson(), notes[index].id);
    }

    selectedIndex.forEach(iter);
    return;
  }

  Future updatePinnedStatusMultiple(
      List<Note> notes, List<int> selectedIndex, bool pinned) async {
    void iter(index) {
      var note = Note(
          id: notes[index].id,
          title: notes[index].title,
          dateCreated: notes[index].dateCreated,
          dateDeleted: notes[index].dateDeleted,
          dateModified: notes[index].dateModified,
          dateArchived: notes[index].dateArchived,
          description: notes[index].description,
          pinned: pinned,
          todoList: notes[index].todoList,
          reminder: notes[index].reminder);
      _api.updateNote(note.toJson(), notes[index].id);
    }

    selectedIndex.forEach(iter);
    return;
  }
}
