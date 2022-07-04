import 'package:built_collection/built_collection.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/core/serializers.dart';
import 'package:mobipad/services/note_service.dart';
import 'package:mobipad/utils/data_map_util.dart';

class NoteApi {
  NoteApi(this._api);

  final NoteService _api;

  Future<NoteDto> selectANote(String noteId) async {
    try {
      var doc = await _api.getDocumentById(noteId);

      var note = (serializers.deserializeWith(NoteDto.serializer, doc.data()))!
          .rebuild((b) => b..id = doc.id);

      return note;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<NoteDto> createNote(NoteDto newNote) async {
    try {
      var obj = serializers.serializeWith(NoteDto.serializer, newNote);

      var docRef = await _api.addNote(DataMapUtil.cleanMapFormat(obj!));

      var doc = (await docRef.get());
      var createdNote =
          (serializers.deserializeWith(NoteDto.serializer, doc.data()))!
              .rebuild((b) => b..id = doc.id);

      return createdNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  NoteDto updateNote(NoteDto note) {
    try {
      var updatedNote = note.rebuild(
          (b) => b..dateModified = DateTime.now().millisecondsSinceEpoch);

      _saveNote(updatedNote);

      return updatedNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  NoteDto updateNoteReminder(NoteDto note, ReminderDto reminder) {
    try {
      var updatedNote = note.rebuild((b) => b
        ..dateModified = DateTime.now().millisecondsSinceEpoch
        ..reminder.replace(reminder));

      _saveNote(updatedNote);

      return updatedNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  NoteDto clearNoteReminder(NoteDto note) {
    try {
      var updatedNote = note.rebuild((b) => b
        ..dateModified = DateTime.now().millisecondsSinceEpoch
        ..reminder = null);

      _saveNote(updatedNote);

      return updatedNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  NoteDto pinNote(NoteDto note, bool pin) {
    try {
      var updatedNote = note.rebuild((b) => b..pinned = pin);

      _saveNote(updatedNote);

      return updatedNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void deleteNote(NoteDto note) {
    try {
      var updatedNote = note.rebuild((b) => b
        ..dateDeleted = DateTime.now().millisecondsSinceEpoch
        ..dateArchived = 0);

      _saveNote(updatedNote);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  NoteDto archiveNote(NoteDto note, bool archive) {
    try {
      var updatedNote = note.rebuild((b) => b
        ..dateArchived = archive ? DateTime.now().millisecondsSinceEpoch : 0
        ..dateDeleted = 0);

      _saveNote(updatedNote);

      return updatedNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  NoteDto restoreNote(NoteDto note) {
    try {
      var updatedNote = note.rebuild((b) => b
        ..dateDeleted = 0
        ..dateArchived = 0);

      _saveNote(updatedNote);

      return updatedNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  NoteDto toggleTodo(NoteDto note, TodoDto todo) {
    try {
      var toggledTodo = (todo.toBuilder()..done = !todo.done!).build();
      var todoIndexToReplace = note.todoList!.indexOf(todo);
      var newTodoList = note.todoList?.toList();
      newTodoList?.replaceRange(
          todoIndexToReplace, todoIndexToReplace + 1, [toggledTodo]);
      var updatedNote =
          note.rebuild((b) => b..todoList = ListBuilder([...?newTodoList]));

      _saveNote(updatedNote);

      return updatedNote;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> permanentDeleteNote(NoteDto note) async {
    try {
      await _api.removeDocument(note.id!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _saveNote(NoteDto note) {
    try {
      var obj = serializers.serializeWith(NoteDto.serializer, note);

      _api.saveNote(DataMapUtil.cleanMapFormat(obj!), note.id!);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
