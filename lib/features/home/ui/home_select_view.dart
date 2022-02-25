import 'package:flutter/material.dart';
import 'package:mobipad/vars/colors.dart';

import '../model.dart';

class HomeSelectView extends StatelessWidget {
  const HomeSelectView({
    Key key,
    @required this.scaffoldKey,
    @required this.onPressedStopSelect,
    @required this.selectedList,
    @required this.noteList,
    @required this.onToggleSelect,
    @required this.onTogglePin,
    @required this.pinIcon,
    @required this.onPressedMoveToTrash,
    @required this.onPressedMoveToArchive,
    @required this.noteListView,
    @required this.hideFabAnimation,
    @required this.speedDialFab,
    @required this.loadingScreen,
    @required this.isLoading,
    @required this.drawer,
    @required this.archiveView,
    @required this.trashView,
    @required this.onPressedPermanentDelete,
    @required this.onPressedRestore,
    @required this.onPressedUnarchive,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function onPressedStopSelect;
  final List<int> selectedList;
  final List<Note> noteList;
  final Function onToggleSelect;
  final Function onTogglePin;
  final Icon pinIcon;
  final Function onPressedMoveToTrash;
  final Function onPressedRestore;
  final Function onPressedMoveToArchive;
  final Function onPressedUnarchive;
  final Function onPressedPermanentDelete;
  final Widget noteListView;
  final AnimationController hideFabAnimation;
  final Widget speedDialFab;
  final Widget loadingScreen;
  final bool isLoading;
  final bool archiveView;
  final bool trashView;
  final Widget drawer;

  @override
  Widget build(BuildContext context) {
    final multipleSelectionAppBar = AppBar(
      backgroundColor: OhNotesColor.multiple_selection_app_bar,
      leading: IconButton(
        onPressed: onPressedStopSelect,
        icon: Icon(Icons.close),
        color: Colors.black,
      ),
      title: Text(
        '${selectedList.length}/${noteList.length}',
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: onToggleSelect,
          icon: Icon(
            selectedList.length == noteList.length
                ? Icons.clear_all
                : Icons.select_all,
            color: Colors.black,
          ),
        ),
        Visibility(
          visible: !archiveView && !trashView,
          child: IconButton(
            onPressed: onTogglePin,
            icon: pinIcon,
          ),
        ),
        Visibility(
          visible: !archiveView && !trashView,
          child: IconButton(
            onPressed: onPressedMoveToArchive,
            icon: Icon(
              Icons.archive,
              color: selectedList.isNotEmpty ? Colors.black : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: archiveView,
          child: IconButton(
            onPressed: onPressedUnarchive,
            icon: Icon(
              Icons.unarchive,
              color: selectedList.isNotEmpty ? Colors.black : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: !trashView,
          child: IconButton(
            onPressed: onPressedMoveToTrash,
            icon: Icon(
              Icons.delete,
              color: selectedList.isNotEmpty ? Colors.black : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: trashView,
          child: IconButton(
            onPressed: onPressedRestore,
            icon: Icon(
              Icons.settings_backup_restore,
              color: selectedList.isNotEmpty ? Colors.black : Colors.black26,
            ),
          ),
        ),
        Visibility(
          visible: trashView,
          child: IconButton(
            onPressed: onPressedPermanentDelete,
            icon: Icon(
              Icons.delete_forever,
              color: selectedList.isNotEmpty ? Colors.black : Colors.black26,
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: multipleSelectionAppBar,
      drawer: drawer,
      floatingActionButton: ScaleTransition(
        scale: hideFabAnimation,
        alignment: Alignment.bottomRight,
        child: speedDialFab,
      ),
      body: isLoading ? loadingScreen : noteListView,
    );
  }
}
