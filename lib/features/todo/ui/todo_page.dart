import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/features/reminder/ui/reminder_page.dart';
import 'package:mobipad/features/todo/actions.dart';
import 'package:mobipad/features/todo/ui/add_todo_dialog.dart';
import 'package:mobipad/features/todo/ui/edit_todo_dialog.dart';
import 'package:mobipad/features/todo/ui/widget/todo_list_item.dart';
import 'package:mobipad/utils/dialogs/delete_dialog.dart';
import 'package:mobipad/utils/note_date_info_container.dart';
import 'package:mobipad/utils/note_util.dart';
import 'package:mobipad/utils/oh_notes_icons.dart';
import 'package:mobipad/vars/colors.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';
import '../../home/model.dart';
import '../view_model/todo_page_view_model.dart';

class TodoPage extends StatefulWidget {
  static const String route = '/todoPage';

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _todoTextController = TextEditingController();
  List<ToDoItem> todos = <ToDoItem>[];

  bool _pinned = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Store<AppState> get store => StoreProvider.of(context);

  @override
  void dispose() {
    _titleTextController.dispose();
    _todoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => TodoPageViewModel(store.state),
        onInitialBuild: (viewModel) {
          _setTodo(viewModel);
          _reschedExpiredReminder(viewModel);
        },
        onDidChange: (_, viewModel) {
          _setTodo(viewModel);
        },
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, TodoPageViewModel viewModel) {
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

    final _todoImage = SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tap button \nbelow to add a \nTodo item',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black38),
                ),
                Icon(Icons.arrow_downward, color: Colors.grey),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Image.asset(
                'assets/img/todo_art.png',
                alignment: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );

    final _reorderableList = ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          _updateMyItems(oldIndex, newIndex);
        });
        // save when reordered
        _saveTodo(viewModel);
      },
      children: List.generate(
        todos.length,
        (i) => TodoListItem(
          key: UniqueKey(),
          editing: viewModel.isEditing,
          todoItem: todos[i].todo,
          todoDone: todos[i].done,
          fontSize: fontSize,
          deleteItem: () {
            setState(() {
              todos.removeAt(i);
            });
          },
          toggleItem: () {
            var done = !todos[i].done;
            setState(() {
              var item = ToDoItem(
                todo: todos[i].todo,
                done: done,
              );
              todos.removeAt(i);
              todos.insert(i, item);

              // save when a todo is done or reverted back
              _saveTodo(viewModel);
            });
          },
          editItem: () async {
            _todoTextController.text = todos[i].todo;
            final isDone = todos[i].done;
            var update = await showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      EditTodoDialog(contoller: _todoTextController),
                ) ??
                false;

            if (update) {
              todos.removeAt(i);
              todos.insert(
                i,
                ToDoItem(
                  todo: _todoTextController.text,
                  done: isDone,
                ),
              );
            }

            _todoTextController.clear();
          },
        ),
      ),
    );

    final _dates = NoteDateInfoContainer(
      isEditing: viewModel.isEditing,
      display: viewModel.dateTimeDisplay,
      note: viewModel.todo,
    );

    final _addItemButton = Visibility(
      visible: viewModel.isEditing,
      child: InkWell(
        onTap: () async {
          dynamic addTodo = true;

          while (addTodo) {
            _todoTextController.clear();

            addTodo = await _addTodoDialog(context);

            if (addTodo != null && _todoTextController.text.isNotEmpty) {
              // new todo, set [done] to 'false'
              setState(() {
                todos.add(
                  ToDoItem(
                    todo: _todoTextController.text,
                    done: false,
                  ),
                );
              });
            } else {
              addTodo = false;
            }
          }
        },
        child: Ink(
          width: MediaQuery.of(context).size.width,
          height: 120.h,
          // color: Colors.blueGrey[50],
          color: Theme.of(context).colorScheme.secondary,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                'Add',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 45.sp,
                    color: Colors.white),
              ),
            ],
          )),
        ),
      ),
    );

    final _body = Column(
      children: <Widget>[
        _title,
        _dates,
        Expanded(
          child: todos.isEmpty ? _todoImage : _reorderableList,
        ),
        _addItemButton,
      ],
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
          var saved = _saveTodo(viewModel);
          if (saved) {
            _showToast(_pinned ? 'Pinned!' : 'Unpinned!');
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
              : store.dispatch(EditTodo());
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
                if (viewModel.todo?.id != null) {
                  var delete = await _showDeleteConfirmation(context) ?? false;

                  if (delete) {
                    store.dispatch(MoveToTrash(viewModel.todo));
                    Navigator.pop(context);
                  }
                }
              }
            : () async {
                if (viewModel.todo?.id != null) {
                  var delete =
                      await _showPermaDeleteConfirmation(context) ?? false;

                  if (delete) {
                    store.dispatch(DeleteTodo(viewModel.todo.id));
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
                  if (!trashMode) {
                    store.dispatch(InitReminder(viewModel.todo, 'todo',
                        viewModel.todo.reminder?.remId));
                    await Navigator.pushNamed(context, ReminderPage.route).then(
                        (value) => store.dispatch(FindTodo(viewModel.todo.id)));
                  }
                  break;
                case 'Archive':
                  var archive =
                      await _showArchiveConfirmation(context) ?? false;

                  if (archive) {
                    store.dispatch(MoveToArchive(viewModel.todo));
                    Navigator.pop(context);
                  }

                  break;
                case 'Unarchive':
                  var unarchive =
                      await _showUnarchiveConfirmation(context) ?? false;

                  if (unarchive) {
                    store.dispatch(Unarchive(viewModel.todo));
                    Navigator.pop(context);
                  }
                  break;
                case 'Restore':
                  var restore =
                      await _showRestoreConfirmation(context) ?? false;
                  if (restore) {
                    store.dispatch(Restore(viewModel.todo));
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

    final scaffold = Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: barColor,
        elevation: 0,
        leading: GestureDetector(
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
        ),
        actions: <Widget>[
          _pinnedButton,
          _editButton,
          _deleteButton,
          _popupMenu,
        ],
      ),
      body: _body,
    );

    final willPopScope = WillPopScope(
      onWillPop: () async => _canExit(viewModel),
      child: scaffold,
    );

    return willPopScope;
  }

  Future<bool> _canExit(TodoPageViewModel viewModel) {
    if (_titleTextController.text.isEmpty && todos.isEmpty) {
      return Future.value(true);
    }

    if (viewModel.isEditing) {
      if (_titleChanged(viewModel) || _todoChanged()) {
        var saved = _saveTodo(viewModel);
        if (saved) {
          _showToast('Saved!');
        }
      }
      store.dispatch(CancelEditTodo());
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  bool _titleChanged(TodoPageViewModel viewModel) {
    return viewModel.todo?.title != _titleTextController.text;
  }

  bool _todoChanged() {
    return todos.isNotEmpty;
  }

  bool _saveTodo(TodoPageViewModel viewModel) {
    if (_titleTextController.text.isEmpty && todos.isEmpty) {
      return false;
    }

    if (viewModel.todo?.id == null) {
      store.dispatch(
        SaveTodo(
          Note(
            title: _titleTextController.text,
            dateCreated: viewModel.todo?.dateCreated ?? 0 == 0
                ? DateTime.now().millisecondsSinceEpoch
                : viewModel.todo.dateCreated,
            dateModified: DateTime.now().millisecondsSinceEpoch,
            dateDeleted: 0,
            dateArchived: 0,
            pinned: _pinned,
            todoList: todos,
            reminder: Reminder(),
          ),
        ),
      );
    } else {
      store.dispatch(
        UpdateTodo(
          Note(
            id: viewModel.todo.id,
            title: _titleTextController.text,
            dateCreated: viewModel.todo.dateCreated == 0
                ? DateTime.now().millisecondsSinceEpoch
                : viewModel.todo.dateCreated,
            dateModified: DateTime.now().millisecondsSinceEpoch,
            dateDeleted: viewModel.todo.dateDeleted,
            dateArchived: viewModel.todo.dateArchived,
            pinned: _pinned,
            todoList: todos,
            reminder: viewModel.todo.reminder ?? Reminder(),
          ),
        ),
      );
    }

    return true;
  }

  void _showToast(String message) {
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

  void _updateMyItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final todo = todos.removeAt(oldIndex);
    todos.insert(newIndex, todo);
  }

  Future<bool> _showDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Delete Todo?',
        redLabel: 'Delete',
      ),
    );
  }

  Future<bool> _showArchiveConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Archive Todo?',
        redLabel: 'Archive',
      ),
    );
  }

  Future<bool> _showUnarchiveConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Unarchive Todo?',
        redLabel: 'Unarchive',
      ),
    );
  }

  Future<bool> _showRestoreConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Restore Todo?',
        redLabel: 'Restore',
      ),
    );
  }

  Future<bool> _showPermaDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => DeleteDialog(
        message: 'Pemanent delete Todo?',
        redLabel: 'Delete Forever',
      ),
    );
  }

  Future<dynamic> _addTodoDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddTodoDialog(
        contoller: _todoTextController,
      ),
    );
  }

  void _setTodo(TodoPageViewModel viewModel) {
    setState(() {
      todos = viewModel.todo?.todoList ?? todos;
      _titleTextController.text = viewModel.todo?.title;
      _titleTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: _titleTextController.text.length));
      _pinned = viewModel.todo?.pinned ?? false;
    });
  }

  void _reschedExpiredReminder(TodoPageViewModel viewModel) {
    if (viewModel.todo != null) {
      var remId = viewModel.todo.reminder?.remId;
      var selectedRepeat = viewModel.todo.reminder?.selectedRepeat ?? 0;
      var newStartList = <int>[];
      if (remId != null) {
        // if remId is not null, means that either reminder is pending or expired
        for (var sched in viewModel.todo.reminder.reminderStart) {
          var next = getNextReminderSchedule(sched, selectedRepeat);
          if (next != 0) {
            newStartList.add(next);
          }
        }

        if (newStartList.isNotEmpty) {
          // update database of new startList
          store.dispatch(UpdateTodo(
            Note(
              id: viewModel.todo.id,
              title: viewModel.todo.title,
              description: viewModel.todo.description,
              dateCreated: viewModel.todo.dateCreated,
              dateModified: viewModel.todo.dateModified,
              dateDeleted: viewModel.todo.dateDeleted,
              dateArchived: viewModel.todo.dateArchived,
              todoList: viewModel.todo.todoList,
              pinned: viewModel.todo.pinned,
              reminder: Reminder(
                days: viewModel.todo.reminder.days,
                remId: viewModel.todo.reminder.remId,
                selectedRepeat: viewModel.todo.reminder.selectedRepeat,
                reminderStart: newStartList,
              ),
            ),
          ));

          // update local reminder
          var message = viewModel.todo.description ??
              todoListToString(viewModel.todo.todoList);
          var type = viewModel.todo.description != null ? 'note' : 'todo';
          store.dispatch(RescheduleReminder(viewModel.todo.id, type,
              viewModel.todo.title, message, newStartList, remId));
        } else {
          // if no new sched, set reminder to null
          store.dispatch(UpdateTodo(
            Note(
              id: viewModel.todo.id,
              title: viewModel.todo.title,
              description: viewModel.todo.description,
              dateCreated: viewModel.todo.dateCreated,
              dateModified: viewModel.todo.dateModified,
              dateDeleted: viewModel.todo.dateDeleted,
              dateArchived: viewModel.todo.dateArchived,
              todoList: viewModel.todo.todoList,
              pinned: viewModel.todo.pinned,
              reminder: Reminder(),
            ),
          ));
        }
      }
    }
  }
}
