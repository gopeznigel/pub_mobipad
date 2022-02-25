import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mobipad/features/home/ui/home_normal_view.dart';
import 'package:mobipad/features/home/ui/home_search_view.dart';
import 'package:mobipad/features/home/ui/home_select_view.dart';
import 'package:mobipad/features/home/ui/note_list_view.dart';
import 'package:mobipad/features/home/ui/widget/ads_list_tile.dart';
import 'package:mobipad/features/login/actions.dart';
import 'package:mobipad/features/note/ui/note_page.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/features/settings/actions.dart';
import 'package:mobipad/features/settings/ui/settings_page.dart';
import 'package:mobipad/features/todo/actions.dart';
import 'package:mobipad/features/todo/ui/todo_page.dart';
import 'package:mobipad/utils/dialogs/delete_dialog.dart';
import 'package:mobipad/utils/dialogs/exit_app_dialog.dart';
import 'package:mobipad/utils/dialogs/logout_dialog.dart';
import 'package:mobipad/utils/dialogs/sort_dialog.dart';
import 'package:mobipad/utils/note_util.dart';
import 'package:mobipad/utils/oh_notes_icons.dart';
import 'package:mobipad/vars/colors.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';
import '../../note/actions.dart';
import '../actions.dart';
import '../model.dart';
import '../view_model/home_page_view_model.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin<HomePage> {
  /// AdMob Integration
  static const String _adTestUnitID = 'ca-app-pub-XXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  static const String _adProdUnitID = 'ca-app-pub-XXXXXXXXXXXXXXXXXXXXXXXXXXXX';
  final NativeAdmobController _nativeAdController = NativeAdmobController();
  final NativeAdmobController _nativeAdExitController = NativeAdmobController();
  bool _showAds = false;
  StreamSubscription _subscription;

  Store<AppState> get store => StoreProvider.of(context);
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  AnimationController _hideFabAnimation;
  int pageIndex = 0;
  TextEditingController searchTextController = TextEditingController();
  List<int> selectedList = [];

  @override
  void initState() {
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    super.initState();
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    _hideFabAnimation.forward();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _showAds = false;
        });
        break;
      case AdLoadState.loadCompleted:
        setState(() {
          _showAds = true;
        });
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    _nativeAdController.dispose();
    _hideFabAnimation.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => HomePageViewModel(store.state),
        onInit: (store) {
          store.dispatch(NotificationClickListener());
          store.dispatch(GetDateTimeDisplay());
          store.dispatch(FetchNotes());
        },
        onInitialBuild: (HomePageViewModel viewModel) {
          debugPrint('Check persistent data.');
          store.dispatch(GetNoteList(viewModel.sorting));
        },
        onDidChange: (_, viewModel) {
          if (viewModel.noteList.isNotEmpty && viewModel.newLogin) {
            _reschedExpiredReminder(viewModel);
            store.dispatch(AccountInitDone());
            debugPrint('resched');
          }
          _hideFabAnimation.forward();
        },
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, HomePageViewModel viewModel) {
    final searchedNotes = viewModel.search(searchTextController.text);
    final isLoading = viewModel.isLoading;
    final isSearching = viewModel.isSearching;
    final dateTimeDisplay = viewModel.dateTimeDisplay;
    final multipleSelectionMode = viewModel.multipleSelectionMode;
    final archiveMode = viewModel.archiveMode;
    final trashMode = viewModel.trashMode;
    final noteList = filterNotes(
        noteList: viewModel.noteList,
        archiveMode: archiveMode,
        trashMode: trashMode);

    final adsTile = AdsListTile(
        show: _showAds,
        adUnitId: kDebugMode ? _adTestUnitID : _adProdUnitID,
        nativeAdController: _nativeAdController);

    final noteListView = NoteListView(
        ads: adsTile,
        noteList: noteList,
        dateTimeDisplay: dateTimeDisplay,
        isTileSelected: isSelected,
        onTapNoteListTile: (index) {
          if (multipleSelectionMode) {
            setState(() {
              var found = selectedList.indexOf(index);

              if (found > -1) {
                selectedList.removeAt(found);
              } else {
                selectedList.add(index);
              }
            });
          } else {
            if (noteList[index].description != null) {
              store.dispatch(OpenExistingNote(noteList[index]));
              Navigator.pushNamed(context, NotePage.route)
                  .then((value) async => _hideFabAnimation.forward());
            } else {
              store.dispatch(OpenExistingTodo(noteList[index]));
              Navigator.pushNamed(context, TodoPage.route)
                  .then((value) async => _hideFabAnimation.forward());
            }
          }
        },
        onLongPressNoteListTile: (index) {
          if (!multipleSelectionMode) {
            // remove ads
            setState(() {
              _showAds = false;
            });
            startMultipleSelectionMode(index);
          }
        });

    final loadingScreen = Center(
      child: CircularProgressIndicator(),
    );

    final speedDialFab = Visibility(
      visible:
          !isSearching && !multipleSelectionMode && !archiveMode && !trashMode,
      child: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.format_list_numbered),
              label: 'New Todo List',
              onTap: () {
                store.dispatch(OpenNewTodo());
                Navigator.pushNamed(context, TodoPage.route)
                    .then((value) => _hideFabAnimation.forward());
              }),
          SpeedDialChild(
            child: Icon(Icons.note),
            label: 'New Note',
            onTap: () {
              store.dispatch(OpenNewNote());
              Navigator.pushNamed(context, NotePage.route).then(
                (value) => _hideFabAnimation.forward(),
              );
            },
          ),
        ],
      ),
    );

    final drawer = Theme(
      data: Theme.of(context).copyWith(canvasColor: OhNotesColor.scaffold),
      child: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(
                        color: !viewModel.archiveMode && !viewModel.trashMode
                            ? Colors.cyan
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    leading: Icon(Icons.home,
                        color: !viewModel.archiveMode && !viewModel.trashMode
                            ? Colors.cyan
                            : Color(0xFF888888)),
                    onTap: () {
                      _nativeAdController.reloadAd(forceRefresh: true);
                      store.dispatch(ViewDefault());
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Archive',
                      style: TextStyle(
                        color:
                            viewModel.archiveMode ? Colors.cyan : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    leading: Icon(Icons.archive,
                        color: viewModel.archiveMode
                            ? Colors.cyan
                            : Color(0xFF888888)),
                    onTap: () {
                      _nativeAdController.reloadAd(forceRefresh: true);
                      store.dispatch(ViewArchive());
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Trash',
                      style: TextStyle(
                        color: viewModel.trashMode ? Colors.cyan : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    leading: Icon(Icons.delete,
                        color: viewModel.trashMode
                            ? Colors.cyan
                            : Color(0xFF888888)),
                    onTap: () {
                      _nativeAdController.reloadAd(forceRefresh: true);
                      store.dispatch(ViewTrash());
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    leading: Icon(Icons.settings, color: Color(0xFF888888)),
                    onTap: () {
                      Navigator.pop(context);
                      _goToSettings();
                    },
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.5),
                  ),
                ),
                child: ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  leading: Icon(Icons.exit_to_app, color: Color(0xFF888888)),
                  onTap: () async {
                    Navigator.pop(context);
                    await _logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final normalView = HomeNormalView(
      scaffoldKey: _globalKey,
      archiveMode: archiveMode,
      trashMode: trashMode,
      onPressedSearh: () {
        searchTextController.clear();
        store.dispatch(OpenSearch());
      },
      onSelectedPopupMenu: (choice) async {
        await handleClick(choice, viewModel);
      },
      hideFabAnimation: _hideFabAnimation,
      isLoading: isLoading,
      loadingScreen: loadingScreen,
      speedDialFab: speedDialFab,
      drawer: drawer,
      noteListView: noteListView,
    );

    final searchView = HomeSearchView(
      scaffoldKey: _globalKey,
      searchTextController: searchTextController,
      onChangedSearchTextField: (value) {
        setState(() {});
      },
      onPressedCloseSearch: () {
        searchTextController.clear();
        store.dispatch(CloseSearch());
      },
      dateTimeDisplay: dateTimeDisplay,
      onTapSearchedNoteListTile: (index) {
        if (searchedNotes[index].description != null) {
          store.dispatch(OpenExistingNote(searchedNotes[index]));
          Navigator.pushNamed(context, NotePage.route)
              .then((value) async => _hideFabAnimation.forward());
        } else {
          store.dispatch(OpenExistingTodo(searchedNotes[index]));
          Navigator.pushNamed(context, TodoPage.route)
              .then((value) async => _hideFabAnimation.forward());
        }
      },
      hideFabAnimation: _hideFabAnimation,
      isLoading: isLoading,
      loadingScreen: loadingScreen,
      speedDialFab: speedDialFab,
      drawer: drawer,
      searchedNotes: searchedNotes,
    );

    final selectView = HomeSelectView(
      scaffoldKey: _globalKey,
      noteList: noteList,
      onPressedStopSelect: stopMultipleSelectionMode,
      onToggleSelect: selectedList.length == noteList.length
          ? unselectAll
          : () {
              selectAll(noteList.length);
            },
      selectedList: selectedList,
      onPressedMoveToTrash: selectedList.isNotEmpty
          ? () async {
              var delete = await _showDeleteConfirmation(context) ?? false;
              if (delete) {
                deleteAll(viewModel, noteList);
              }
            }
          : null,
      onPressedMoveToArchive: selectedList.isNotEmpty
          ? () async {
              var arch = await _showArchiveConfirmation(context) ?? false;
              if (arch) {
                archiveAll(viewModel, noteList);
              }
            }
          : null,
      onPressedPermanentDelete: selectedList.isNotEmpty
          ? () async {
              var perm = await _showPermaDeleteConfirmation(context) ?? false;
              if (perm) {
                permaDeleteAll(viewModel, noteList);
              }
            }
          : null,
      onPressedRestore: selectedList.isNotEmpty
          ? () async {
              var unarch = await _showRestoreConfirmation(context) ?? false;
              if (unarch) {
                restoreAll(viewModel, noteList);
              }
            }
          : null,
      onPressedUnarchive: selectedList.isNotEmpty
          ? () async {
              var restore = await _showUnarchiveConfirmation(context) ?? false;
              if (restore) {
                unarchiveAll(viewModel, noteList);
              }
            }
          : null,
      onTogglePin: allSelectedUnpinned(selectedList, noteList)
          ? () {
              pinAll(viewModel, noteList);
            }
          : allSelectedPinned(selectedList, noteList)
              ? () {
                  unpinAll(viewModel, noteList);
                }
              : null,
      pinIcon: Icon(
        allSelectedUnpinned(selectedList, noteList)
            ? OhNotes.pin
            : allSelectedPinned(selectedList, noteList)
                ? OhNotes.pin_border
                : OhNotes.pin,
        color: allSelectedUnpinned(selectedList, noteList) ||
                allSelectedPinned(selectedList, noteList)
            ? Colors.black
            : Colors.black26,
      ),
      hideFabAnimation: _hideFabAnimation,
      isLoading: isLoading,
      loadingScreen: loadingScreen,
      speedDialFab: speedDialFab,
      drawer: drawer,
      noteListView: noteListView,
      archiveView: archiveMode,
      trashView: trashMode,
    );

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: WillPopScope(
        onWillPop: () async {
          return await willPop(
              isSearching, multipleSelectionMode, archiveMode, trashMode);
        },
        child: Builder(
          builder: (context) {
            if (isSearching) {
              return searchView;
            } else if (multipleSelectionMode) {
              return selectView;
            } else {
              return normalView;
            }
          },
        ),
      ),
    );
  }

  Future<bool> willPop(
      bool isSearching, bool multi, bool archiveView, bool trashView) async {
    if (_globalKey.currentState.isDrawerOpen) {
      Navigator.pop(context);
      return false;
    } else if (isSearching) {
      store.dispatch(CloseSearch());
      return false;
    } else if (multi) {
      stopMultipleSelectionMode();
      return false;
    } else if (archiveView || trashView) {
      _nativeAdController.reloadAd(forceRefresh: true);
      store.dispatch(ViewDefault());
      return false;
    } else {
      return await _showExitAppDialog(context);
    }
  }

  List<Note> filterNotes(
      {List<Note> noteList, bool archiveMode, bool trashMode}) {
    var filtered = <Note>[];

    for (var note in noteList) {
      var dateArchived = note.dateArchived ?? 0;
      var dateDeleted = note.dateDeleted ?? 0;
      if (archiveMode) {
        if (dateArchived > 0) {
          filtered.add(note);
        }
      } else if (trashMode) {
        if (dateDeleted > 0) {
          filtered.add(note);
        }
      } else {
        if (dateDeleted == 0 && dateArchived == 0) {
          filtered.add(note);
        }
      }
    }

    return filtered;
  }

  bool isSelected(int index) {
    var selected = false;

    for (var selectedIndex in selectedList) {
      if (selectedIndex == index) {
        selected = true;
        break;
      }
    }

    return selected;
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  bool allSelectedPinned(List selectedList, List<Note> noteList) {
    var pinned = selectedList.isNotEmpty;
    for (var i in selectedList) {
      var pinnedStatus = noteList[i].pinned;
      if (pinnedStatus == false) {
        pinned = false;
        break;
      }
    }

    return pinned;
  }

  bool allSelectedUnpinned(List selectedList, List<Note> noteList) {
    var unpinned = selectedList.isNotEmpty;
    for (var i in selectedList) {
      var unpinnedStatus = !noteList[i].pinned;
      if (unpinnedStatus == false) {
        unpinned = false;
        break;
      }
    }

    return unpinned;
  }

  Future<void> showSortDialog(
      BuildContext context, HomePageViewModel viewModel) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        elevation: 0,
        backgroundColor: Colors.white,
        child: SortDialog(
          onTap: (value) => sortNotes(value),
          sorting: viewModel.sorting,
        ),
      ),
    );
  }

  Future<bool> _showExitAppDialog(BuildContext context) {
    _nativeAdExitController.reloadAd(forceRefresh: true);

    final thankyou = Container(
      child: Center(
        child: Text(
          'Thank you for using\nOh Notes!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );

    return showDialog(
      context: context,
      builder: (context) => ExitAppDialog(
        ads: NativeAdmob(
          controller: _nativeAdExitController,
          adUnitID: kDebugMode ? _adTestUnitID : _adProdUnitID,
          loading: thankyou,
          error: thankyou,
          numberAds: 3,
          type: NativeAdmobType.full,
          options: NativeAdmobOptions(
              advertiserTextStyle: NativeTextStyle(color: Color(0xAA448aff)),
              headlineTextStyle: NativeTextStyle(color: Colors.blueAccent),
              bodyTextStyle: NativeTextStyle(isVisible: false)),
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Delete selected items?',
        redLabel: 'Delete',
      ),
    );
  }

  Future<bool> _showRestoreConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Restore selected items?',
        redLabel: 'Restore',
      ),
    );
  }

  Future<bool> _showArchiveConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Archive selected items?',
        redLabel: 'Archive',
      ),
    );
  }

  Future<bool> _showUnarchiveConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Unarchive selected items?',
        redLabel: 'Unarchive',
      ),
    );
  }

  Future<bool> _showPermaDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Permanent delete selected items?',
        redLabel: 'Delete Forever',
      ),
    );
  }

  Future<bool> _showLogoutConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => LogoutDialog(),
    );
  }

  void stopMultipleSelectionMode() {
    store.dispatch(StopMultipleSelectionMode());
    _hideFabAnimation.forward();
    setState(() {
      _showAds = true;
      selectedList.clear();
    });
  }

  void startMultipleSelectionMode(int index) {
    store.dispatch(StartMultipleSelectionMode());
    _hideFabAnimation.reverse();
    setState(() {
      selectedList.add(index);
    });
  }

  void pinAll(HomePageViewModel viewModel, List<Note> noteList) {
    store.dispatch(UpdatePinnedStatusMultiple(noteList, selectedList, true));
    stopMultipleSelectionMode();
  }

  void unpinAll(HomePageViewModel viewModel, List<Note> noteList) {
    store.dispatch(UpdatePinnedStatusMultiple(noteList, selectedList, false));
    stopMultipleSelectionMode();
  }

  void permaDeleteAll(HomePageViewModel viewModel, List<Note> noteList) async {
    store.dispatch(DeleteMultiple(noteList, selectedList));
    stopMultipleSelectionMode();
  }

  void deleteAll(HomePageViewModel viewModel, List<Note> noteList) async {
    store.dispatch(MoveToTrashMultiple(noteList, selectedList));
    stopMultipleSelectionMode();
  }

  void archiveAll(HomePageViewModel viewModel, List<Note> noteList) async {
    store.dispatch(MoveToArchiveMultiple(noteList, selectedList));
    stopMultipleSelectionMode();
  }

  void restoreAll(HomePageViewModel viewModel, List<Note> noteList) async {
    store.dispatch(RestoreMultiple(noteList, selectedList));
    stopMultipleSelectionMode();
  }

  void unarchiveAll(HomePageViewModel viewModel, List<Note> noteList) async {
    store.dispatch(UnarchiveMultiple(noteList, selectedList));
    stopMultipleSelectionMode();
  }

  void selectAll(int count) {
    setState(() {
      // clear all first
      selectedList.clear();
      for (var i = 0; i < count; i++) {
        selectedList.add(i);
      }
    });
  }

  void unselectAll() {
    // clear all
    setState(() {
      selectedList.clear();
    });
  }

  void sortNotes(String sortType) {
    store.dispatch(SortNotes(sortType));
  }

  Future<void> handleClick(String value, HomePageViewModel viewModel) async {
    switch (value) {
      case 'Settings':
        await _goToSettings();
        break;
      case 'Sort':
        await showSortDialog(context, viewModel);
        break;
    }
  }

  Future _logout() async {
    var logout = await _showLogoutConfirmation(context) ?? false;
    if (logout) {
      store.dispatch(Logout());
    }
  }

  Future _goToSettings() async {
    await Navigator.pushNamed(context, SettingsPage.route);
  }

  void _reschedExpiredReminder(HomePageViewModel viewModel) {
    if (viewModel.noteList != null) {
      for (var note in viewModel.noteList) {
        var remId = note.reminder?.remId;
        var selectedRepeat = note.reminder?.selectedRepeat ?? 0;
        var newStartList = <int>[];
        if (remId != null) {
          // if remId is not null, means that either reminder is pending or expired
          for (var sched in note.reminder.reminderStart) {
            var next = getNextReminderSchedule(sched, selectedRepeat);
            if (next != 0) {
              newStartList.add(next);
            }
          }

          // update database of new startList
          if (newStartList.isNotEmpty) {
            store.dispatch(
              UpdateNote(
                Note(
                  id: note.id,
                  title: note.title,
                  description: note.description,
                  dateCreated: note.dateCreated,
                  dateModified: note.dateModified,
                  dateDeleted: note.dateDeleted,
                  dateArchived: note.dateArchived,
                  todoList: note.todoList,
                  pinned: note.pinned,
                  reminder: Reminder(
                    days: note.reminder.days,
                    remId: note.reminder.remId,
                    selectedRepeat: note.reminder.selectedRepeat,
                    reminderStart: newStartList,
                  ),
                ),
              ),
            );

            // update local reminder
            var message = note.description ?? todoListToString(note.todoList);
            var type = note.description != null ? 'note' : 'todo';
            store.dispatch(RescheduleReminder(
                note.id, type, note.title, message, newStartList, remId));
          } else {
            // if no new sched, set reminder to null
            store.dispatch(UpdateTodo(
              Note(
                id: note.id,
                title: note.title,
                description: note.description,
                dateCreated: note.dateCreated,
                dateModified: note.dateModified,
                dateArchived: note.dateArchived,
                dateDeleted: note.dateDeleted,
                todoList: note.todoList,
                pinned: note.pinned,
                reminder: Reminder(),
              ),
            ));
          }
        }
      }
    }
  }
}
