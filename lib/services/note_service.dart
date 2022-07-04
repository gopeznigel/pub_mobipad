import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobipad/services/auth_service.dart';

class NoteService {
  static final NoteService _noteServiceService = NoteService._internal();

  factory NoteService() => _noteServiceService;

  NoteService._internal() {
    _db = FirebaseFirestore.instance;
  }

  late final FirebaseFirestore _db;

  Stream<QuerySnapshot> getStream(String field) {
    return _getNotesCollection()
        .orderBy(field, descending: field.contains('date'))
        .snapshots();
  }

  Future<QuerySnapshot> getDataCollection(String field) {
    return _getNotesCollection()
        .orderBy(field, descending: field.contains('date'))
        .get();
  }

  Future<DocumentReference<Map<String, dynamic>>> addNote(
      Map<String, dynamic> data) {
    try {
      return _getNotesCollection().add(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void saveNote(Map<String, dynamic> data, String id) {
    try {
      _getNotesCollection().doc(id).update(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return _getNotesCollection().doc(id).get();
  }

  Future<void> removeDocument(String id) {
    try {
      return _getNotesCollection().doc(id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  CollectionReference<Map<String, dynamic>> _getUserCollection() =>
      _db.collection('users');

  CollectionReference<Map<String, dynamic>> _getNotesCollection() {
    return _getUserCollection()
        .doc(AuthService().getCurrentUser()!.uid)
        .collection('notes');
  }
}
