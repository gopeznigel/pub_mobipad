import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/home/model.dart';

import 'widget/note_list_tile.dart';

class HomeSearchView extends StatelessWidget {
  const HomeSearchView(
      {Key key,
      @required this.scaffoldKey,
      @required this.onChangedSearchTextField,
      @required this.searchTextController,
      @required this.onPressedCloseSearch,
      @required this.searchedNotes,
      @required this.dateTimeDisplay,
      @required this.onTapSearchedNoteListTile,
      @required this.hideFabAnimation,
      @required this.speedDialFab,
      @required this.loadingScreen,
      @required this.isLoading,
      @required this.drawer,})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function onChangedSearchTextField;
  final TextEditingController searchTextController;
  final Function onPressedCloseSearch;
  final List<Note> searchedNotes;
  final String dateTimeDisplay;
  final Function onTapSearchedNoteListTile;
  final AnimationController hideFabAnimation;
  final Widget speedDialFab;
  final Widget loadingScreen;
  final bool isLoading;
  final Widget drawer;

  @override
  Widget build(BuildContext context) {
    final searchAppBar = AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        onChanged: onChangedSearchTextField,
        autofocus: true,
        controller: searchTextController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(40.w),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 55.sp,
        ),
      ),
      leading: IconButton(
        onPressed: onPressedCloseSearch,
        icon: Icon(Icons.close),
        color: Colors.black,
      ),
    );

    final searchedNotesView = Center(
      child: searchTextController.text.isNotEmpty
          ? ListView.builder(
              itemCount: searchedNotes.length,
              itemBuilder: (context, index) => NoteListTile(
                isSelected: false,
                note: searchedNotes[index],
                dateTimeDisplay: dateTimeDisplay,
                onTap: () {
                  onTapSearchedNoteListTile(index);
                },
                onLongPress: () {},
              ),
            )
          : Icon(
              Icons.search,
              size: 500.w,
              color: Colors.black12,
            ),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: searchAppBar,
      drawer: drawer,
      floatingActionButton: ScaleTransition(
        scale: hideFabAnimation,
        alignment: Alignment.bottomRight,
        child: speedDialFab,
      ),
      body: isLoading ? loadingScreen : searchedNotesView,
    );
  }
}
