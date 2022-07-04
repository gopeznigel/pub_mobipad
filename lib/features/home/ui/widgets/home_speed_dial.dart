import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mobipad/features/note/ui/note_page.dart';
import 'package:mobipad/styles/text_styles.dart';
import 'package:mobipad/core/actions.dart';
import 'package:mobipad/core/dtos.dart';
import 'package:mobipad/state.dart';
import 'package:redux/redux.dart';

class HomeSpeedDial extends StatelessWidget {
  const HomeSpeedDial({
    Key? key,
    required this.fabAnimation,
  }) : super(key: key);

  final AnimationController fabAnimation;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return ScaleTransition(
      scale: fabAnimation,
      alignment: Alignment.bottomRight,
      child: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.format_list_numbered),
              label: 'New Todo',
              labelStyle: OhNotesTextStyles.notePreviewBody.copyWith(
                color: Colors.black,
              ),
              onTap: () {
                _createNewNote(context, store, NoteModeEnum.todo);
              }),
          SpeedDialChild(
            child: const Icon(Icons.note),
            label: 'New Note',
            labelStyle: OhNotesTextStyles.notePreviewBody.copyWith(
              color: Colors.black,
            ),
            onTap: () {
              _createNewNote(context, store, NoteModeEnum.note);
            },
          ),
        ],
      ),
    );
  }

  void _createNewNote(
      BuildContext context, Store<AppState> store, NoteModeEnum mode) {
    store
      ..dispatch(SetNoteMode(mode: mode))
      ..dispatch(CreateNote());

    Navigator.pushNamed(context, NotePage.route);
  }
}
