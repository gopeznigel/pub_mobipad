import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/core/serializers.dart';
import 'package:mobipad/services/note_service.dart';

class HomeApi {
  HomeApi(this._api);

  final NoteService _api;

  Stream<List<NoteDto>> getNotesAsStream(String sort) {
    return _api.getStream(_sortToFieldName(sort)).asyncMap(
      (noteDocuments) {
        return Future.wait(noteDocuments.docs.map(
          (document) {
            return Future.value(serializers
                .deserializeWith(NoteDto.serializer, document.data())
                ?.rebuild((b) => b..id = document.id));
          },
        ));
      },
    );
  }

  Future<List<NoteDto>> getSortedNotes(String sort) async {
    var query = await _api.getDataCollection(_sortToFieldName(sort));

    return query.docs
        .map((doc) =>
            serializers.deserializeWith(NoteDto.serializer, doc.data())!)
        .toList();
  }

  String _sortToFieldName(String sort) {
    if (sort == 'alpha') {
      return 'title';
    } else if (sort == 'created') {
      return 'dateCreated';
    } else {
      // default modified
      return 'dateModified';
    }
  }
}
