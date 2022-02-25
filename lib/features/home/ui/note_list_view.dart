import 'package:flutter/material.dart';

import '../model.dart';
import 'widget/note_list_tile.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({
    Key key,
    @required this.onTapNoteListTile,
    @required this.onLongPressNoteListTile,
    @required this.isTileSelected,
    @required this.noteList,
    @required this.dateTimeDisplay,
    @required this.ads,
  }) : super(key: key);

  final Function onTapNoteListTile;
  final Function onLongPressNoteListTile;
  final Function isTileSelected;
  final List<Note> noteList;
  final String dateTimeDisplay;
  final Widget ads;

  @override
  Widget build(BuildContext context) {
    final tileList = List<Widget>.generate(noteList.length, (index) {
      if (index == 3) {
        return Column(
          children: [
            NoteListTile(
              note: noteList[index],
              dateTimeDisplay: dateTimeDisplay,
              onTap: () {
                onTapNoteListTile(index);
              },
              onLongPress: () {
                onLongPressNoteListTile(index);
              },
              isSelected: isTileSelected(index),
            ),
            ads,
          ],
        );
      } else {
        return NoteListTile(
          note: noteList[index],
          dateTimeDisplay: dateTimeDisplay,
          onTap: () {
            onTapNoteListTile(index);
          },
          onLongPress: () {
            onLongPressNoteListTile(index);
          },
          isSelected: isTileSelected(index),
        );
      }
    });

    final noteListView = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tileList,
      ),
    );

    return noteListView;
  }
}
