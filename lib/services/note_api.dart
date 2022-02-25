import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  static final Api _apiService = Api._internal();

  factory Api() => _apiService;

  Api._internal();

  CollectionReference collection;

  void initCollection(String uid) {
    collection = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('notes');
  }

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Future<QuerySnapshot> getDataCollection(sort) {
    if (sort == 'alpha') {
      return collection
          .orderBy('title')
          .where('pinned', isEqualTo: false)
          .get();
    } else if (sort == 'created') {
      return collection
          .orderBy('dateCreated', descending: true)
          .where('pinned', isEqualTo: false)
          .get();
    } else {
      // default modified
      return collection
          .orderBy('dateModified', descending: true)
          .where('pinned', isEqualTo: false)
          .get();
    }
  }

  Future<QuerySnapshot> getDataCollectionPinned(sort) {
    if (sort == 'alpha') {
      return collection.orderBy('title').where('pinned', isEqualTo: true).get();
    } else if (sort == 'created') {
      return collection
          .orderBy('dateCreated', descending: true)
          .where('pinned', isEqualTo: true)
          .get();
    } else {
      // default modified
      return collection
          .orderBy('dateModified', descending: true)
          .where('pinned', isEqualTo: true)
          .get();
    }
  }

  void addNote(Map data) {
    collection.add(data);
  }

  void updateNote(Map data, String id) {
    collection.doc(id).update(data);
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return collection.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return collection.doc(id).delete();
  }
}
