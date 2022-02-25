import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/vars/colors.dart';

class HomeNormalView extends StatelessWidget {
  const HomeNormalView({
    Key key,
    @required this.scaffoldKey,
    @required this.onPressedSearh,
    @required this.onSelectedPopupMenu,
    @required this.hideFabAnimation,
    @required this.speedDialFab,
    @required this.isLoading,
    @required this.loadingScreen,
    @required this.noteListView,
    @required this.drawer,
    @required this.archiveMode,
    @required this.trashMode,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function onPressedSearh;
  final Function onSelectedPopupMenu;
  final AnimationController hideFabAnimation;
  final Widget speedDialFab;
  final Widget loadingScreen;
  final bool isLoading;
  final Widget noteListView;
  final Widget drawer;
  final bool archiveMode;
  final bool trashMode;

  @override
  Widget build(BuildContext context) {
    var title = 'Your Notes';
    var barColor = OhNotesColor.primary;

    if (archiveMode) {
      title = 'Archived Notes';
      barColor = OhNotesColor.archive;
    } else if (trashMode) {
      title = 'Deleted Notes';
      barColor = OhNotesColor.trash;
    }

    final defaultAppBar = AppBar(
      title: Text(
        title,
      ),
      backgroundColor: barColor,
      elevation: 0,
      actions: <Widget>[
        Visibility(
          visible: !archiveMode && !trashMode,
          child: IconButton(
            onPressed: onPressedSearh,
            color: Colors.white,
            icon: Icon(
              Icons.search,
              size: 75.h,
            ),
          ),
        ),
        PopupMenuButton<String>(
          offset: Offset(0, 50),
          onSelected: onSelectedPopupMenu,
          itemBuilder: (BuildContext context) {
            return [
              {'name': 'Sort', 'icon': Icons.sort},
              {'name': 'Settings', 'icon': Icons.settings},
            ].map((Map<String, dynamic> choice) {
              return PopupMenuItem<String>(
                value: choice['name'],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(choice['icon'], color: Colors.black87),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(choice['name']),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ],
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: defaultAppBar,
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
