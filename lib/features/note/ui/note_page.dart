import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/features/reminder/ui/reminder_page.dart';
import 'package:mobipad/utils/dialogs/delete_dialog.dart';
import 'package:mobipad/utils/note_date_info_container.dart';
import 'package:mobipad/utils/note_util.dart';
import 'package:mobipad/utils/oh_notes_icons.dart';
import 'package:mobipad/vars/colors.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';
import '../../home/model.dart';
import '../actions.dart';
import '../view_model/note_page_view_model.dart';

class NotePage extends StatefulWidget {
  static const String route = '/notePage';

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  bool _showArtWork = true;

  bool _pinned = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _titleTextController.dispose();
    _descriptionTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => NotePageViewModel(store.state),
        onInitialBuild: (viewModel) {
          _setNote(viewModel);
          _reschedExpiredReminder(viewModel);
        },
        onDidChange: (_, viewModel) {
          _setNote(viewModel);
        },
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, NotePageViewModel viewModel) {
    var fontSize = viewModel.fontSize;
    var archiveMode = viewModel.archiveMode;
    var trashMode = viewModel.trashMode;
    var barColor = OhNotesColor.primary;
    var choices = <Map<String, dynamic>>[
      {'name': 'Archive', 'icon': Icons.archive},
      {'name': 'Reminder', 'icon': Icons.notifications},
    ];

    if (archiveMode) {
      barColor = OhNotesColor.archive;
      choices.removeAt(0);
      choices.insert(
        0,
        {'name': 'Unarchive', 'icon': Icons.unarchive},
      );
    } else if (trashMode) {
      barColor = OhNotesColor.trash;
      choices.clear();
      choices.add(
        {'name': 'Restore', 'icon': Icons.settings_backup_restore},
      );
    }

    final _title = Container(
      decoration: BoxDecoration(
        color: barColor,
        boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset(0, 1), blurRadius: 2.0),
        ],
      ),
      child: TextFormField(
        autofocus: false,
        readOnly: !viewModel.isEditing,
        controller: _titleTextController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(40.w),
          hintText: 'Add Title',
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 55.sp,
        ),
      ),
    );

    final _descriptionImage = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Image.asset(
              'assets/img/note_art.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Create a \nNote here',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black38),
          ),
        ),
      ],
    );

    final _description = TextFormField(
      autofocus: true,
      readOnly: !viewModel.isEditing,
      controller: _descriptionTextController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(40.w),
        hintText: 'Type Something',
        border: InputBorder.none,
      ),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            _showArtWork = true;
          } else {
            _showArtWork = false;
          }
        });
      },
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: fontSize.sp,
      ),
    );

    final _dates = NoteDateInfoContainer(
      isEditing: viewModel.isEditing,
      display: viewModel.dateTimeDisplay,
      note: viewModel.note,
    );

    final _body = Column(
      children: <Widget>[
        _title,
        _dates,
        Expanded(
          child: GestureDetector(
            onDoubleTap: () {
              if (!viewModel.isEditing && !viewModel.trashMode) {
                store.dispatch(EditNote());
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _description,
                  _descriptionTextController.text.isEmpty && _showArtWork
                      ? _descriptionImage
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    final _backArrow = GestureDetector(
      onTap: () async {
        var canPop = await _canExit(viewModel);
        if (canPop) {
          Navigator.pop(context);
        }
      },
      child: Icon(
        Icons.arrow_back,
        size: 26.0,
        color: Colors.white,
      ),
    );

    final _pinnedButton = Visibility(
      visible: !viewModel.isEditing &&
          !viewModel.archiveMode &&
          !viewModel.trashMode,
      child: IconButton(
        color: Colors.white,
        onPressed: () {
          setState(() {
            _pinned = !_pinned;
          });
          var saved = _saveNote(viewModel);
          if (saved) {
            _showScaffold(_pinned ? 'Pinned!' : 'Unpinned!');
          }
        },
        icon: Icon(_pinned ? OhNotes.pin : OhNotes.pin_border),
      ),
    );

    final _editButton = Visibility(
      visible: !trashMode,
      child: IconButton(
        color: Colors.white,
        onPressed: () {
          viewModel.isEditing
              ? _canExit(viewModel)
              : store.dispatch(EditNote());
        },
        icon: viewModel.isEditing ? Icon(Icons.save) : Icon(Icons.edit),
      ),
    );

    final _deleteButton = Visibility(
      visible: !viewModel.isEditing,
      child: IconButton(
        color: Colors.white,
        onPressed: !trashMode
            ? () async {
                if (viewModel.note?.id != null) {
                  var delete = await _showDeleteConfirmation(context) ?? false;

                  if (delete) {
                    store.dispatch(MoveToTrash(viewModel.note));
                    Navigator.pop(context);
                  }
                }
              }
            : () async {
                if (viewModel.note?.id != null) {
                  var delete =
                      await _showPermaDeleteConfirmation(context) ?? false;

                  if (delete) {
                    store.dispatch(DeleteNote(viewModel.note.id));
                    Navigator.pop(context);
                  }
                }
              },
        icon: Icon(!trashMode ? Icons.delete : Icons.delete_forever),
      ),
    );

    final _popupMenu = PopupMenuButton<String>(
      offset: Offset(0, 50),
      onSelected: viewModel.isEditing
          ? null
          : (value) async {
              switch (value) {
                case 'Reminder':
                  store.dispatch(InitReminder(
                      viewModel.note, 'note', viewModel.note.reminder?.remId));
                  await Navigator.pushNamed(context, ReminderPage.route).then(
                      (value) => store.dispatch(FindNote(viewModel.note.id)));
                  break;
                case 'Archive':
                  var archive =
                      await _showArchiveConfirmation(context) ?? false;
                  if (archive) {
                    store.dispatch(MoveToArchive(viewModel.note));
                    Navigator.pop(context);
                  }
                  break;
                case 'Unarchive':
                  var unarchive =
                      await _showUnarchiveConfirmation(context) ?? false;
                  if (unarchive) {
                    store.dispatch(Unarchive(viewModel.note));
                    Navigator.pop(context);
                  }
                  break;
                case 'Restore':
                  var restore =
                      await _showRestoreConfirmation(context) ?? false;
                  if (restore) {
                    store.dispatch(Restore(viewModel.note));
                    Navigator.pop(context);
                  }
                  break;
                default:
              }
            },
      itemBuilder: (BuildContext context) {
        return choices.map((Map<String, dynamic> choice) {
          return PopupMenuItem<String>(
            value: choice['name'],
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  choice['icon'],
                  color: viewModel.isEditing ? Colors.grey : Colors.black87,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  choice['name'],
                  style: TextStyle(
                      color: viewModel.isEditing ? Colors.grey : Colors.black),
                ),
              ],
            ),
          );
        }).toList();
      },
    );

    final _appBar = AppBar(
      backgroundColor: barColor,
      elevation: 0,
      leading: _backArrow,
      actions: <Widget>[
        _pinnedButton,
        _editButton,
        _deleteButton,
        _popupMenu,
      ],
    );

    final scaffold = Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: _appBar,
      body: _body,
    );

    final willPopScope = WillPopScope(
      onWillPop: () async => _canExit(viewModel),
      child: scaffold,
    );

    return willPopScope;
  }

  Future<bool> _canExit(NotePageViewModel viewModel) {
    if (_titleTextController.text.isEmpty &&
        _descriptionTextController.text.isEmpty) {
      return Future.value(true);
    }

    if (viewModel.isEditing) {
      if (_titleChanged(viewModel) || _descriptionChanged(viewModel)) {
        _saveNote(viewModel);
        _showScaffold('Saved!');
      }
      store.dispatch(CancelEditNote());
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  bool _titleChanged(NotePageViewModel viewModel) {
    return viewModel.note?.title != _titleTextController.text;
  }

  bool _descriptionChanged(NotePageViewModel viewModel) {
    return viewModel.note?.description != _descriptionTextController.text;
  }

  bool _saveNote(NotePageViewModel viewModel) {
    if (_titleTextController.text.isEmpty &&
        _descriptionTextController.text.isEmpty) {
      return false;
    }

    if (viewModel.note?.id == null) {
      store.dispatch(
        SaveNote(
          Note(
            title: _titleTextController.text,
            description: _descriptionTextController.text,
            dateCreated: viewModel.note?.dateCreated ?? 0 == 0
                ? DateTime.now().millisecondsSinceEpoch
                : viewModel.note.dateCreated,
            dateModified: DateTime.now().millisecondsSinceEpoch,
            dateDeleted: 0,
            dateArchived: 0,
            pinned: _pinned,
            reminder: Reminder(),
          ),
        ),
      );
    } else {
      store.dispatch(
        UpdateNote(
          Note(
            id: viewModel.note.id,
            title: _titleTextController.text,
            description: _descriptionTextController.text,
            dateCreated: viewModel.note.dateCreated == 0
                ? DateTime.now().millisecondsSinceEpoch
                : viewModel.note.dateCreated,
            dateModified: DateTime.now().millisecondsSinceEpoch,
            dateDeleted: viewModel.note.dateDeleted,
            dateArchived: viewModel.note.dateArchived,
            pinned: _pinned,
            reminder: viewModel.note.reminder ?? Reminder(),
          ),
        ),
      );
    }

    return true;
  }

  void _showScaffold(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  Future<bool> _showArchiveConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Archive note?',
        redLabel: 'Archive',
      ),
    );
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Delete note?',
        redLabel: 'Delete',
      ),
    );
  }

  Future<bool> _showUnarchiveConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Unarchive note?',
        redLabel: 'Unarchive',
      ),
    );
  }

  Future<bool> _showRestoreConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Restore note?',
        redLabel: 'Restore',
      ),
    );
  }

  Future<bool> _showPermaDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Pemanent delete note?',
        redLabel: 'Delete Forever',
      ),
    );
  }

  void _setNote(NotePageViewModel viewModel) {
    setState(() {
      _titleTextController.text = viewModel.note?.title;
      _titleTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: _titleTextController.text.length));
      _descriptionTextController.text = viewModel.note?.description;
      _descriptionTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: _descriptionTextController.text.length));
      _showArtWork = _descriptionTextController.text.isEmpty;
      _pinned = viewModel.note?.pinned ?? false;
    });
  }

  void _reschedExpiredReminder(NotePageViewModel viewModel) {
    if (viewModel.note != null) {
      var remId = viewModel.note.reminder?.remId;
      var selectedRepeat = viewModel.note.reminder?.selectedRepeat ?? 0;
      var newStartList = <int>[];
      if (remId != null) {
        // if remId is not null, means that either reminder is pending or expired
        for (var sched in viewModel.note.reminder.reminderStart) {
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
                id: viewModel.note.id,
                title: viewModel.note.title,
                description: viewModel.note.description,
                dateCreated: viewModel.note.dateCreated,
                dateModified: viewModel.note.dateModified,
                dateDeleted: viewModel.note.dateDeleted,
                dateArchived: viewModel.note.dateArchived,
                todoList: viewModel.note.todoList,
                pinned: viewModel.note.pinned,
                reminder: Reminder(
                  days: viewModel.note.reminder.days,
                  remId: viewModel.note.reminder.remId,
                  selectedRepeat: viewModel.note.reminder.selectedRepeat,
                  reminderStart: newStartList,
                ),
              ),
            ),
          );

          // update local reminder
          var message = viewModel.note.description ??
              todoListToString(viewModel.note.todoList);
          var type = viewModel.note.description != null ? 'note' : 'todo';
          store.dispatch(RescheduleReminder(viewModel.note.id, type,
              viewModel.note.title, message, newStartList, remId));
        } else {
          // if no new sched, set reminder to null
          store.dispatch(UpdateNote(
            Note(
              id: viewModel.note.id,
              title: viewModel.note.title,
              description: viewModel.note.description,
              dateCreated: viewModel.note.dateCreated,
              dateModified: viewModel.note.dateModified,
              dateDeleted: viewModel.note.dateDeleted,
              dateArchived: viewModel.note.dateArchived,
              todoList: viewModel.note.todoList,
              pinned: viewModel.note.pinned,
              reminder: Reminder(),
            ),
          ));
        }
      }
    }
  }
}
