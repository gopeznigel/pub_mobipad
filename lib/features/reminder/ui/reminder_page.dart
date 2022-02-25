import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:mobipad/features/home/model.dart';
import 'package:mobipad/features/note/actions.dart';
import 'package:mobipad/features/reminder/actions.dart';
import 'package:mobipad/features/reminder/ui/reminder_repeat_view.dart';
import 'package:mobipad/features/reminder/view_model/reminder_view_model.dart';
import 'package:mobipad/utils/dialogs/quick_reminder_setup_dialog.dart';
import 'package:redux/redux.dart';

import '../../../state.dart';

class ReminderPage extends StatefulWidget {
  static const String route = '/reminderPage';

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  ///
  /// The store. This contains the state of the app.
  ///
  Store<AppState> get store => StoreProvider.of(context);

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _quickSelection;
  bool _onRepeat = false;
  int _selectedRepeat = 0;
  bool _disabled = false;

  final List<Map<String, dynamic>> _quickMins = <Map<String, dynamic>>[
    {'name': '1 minute', 'value': Duration(minutes: 1)},
    {'name': '5 minutes', 'value': Duration(minutes: 5)},
    {'name': '10 minutes', 'value': Duration(minutes: 10)},
    {'name': '15 minutes', 'value': Duration(minutes: 15)},
    {'name': '20 minutes', 'value': Duration(minutes: 20)},
    {'name': '25 minutes', 'value': Duration(minutes: 25)},
    {'name': '30 minutes', 'value': Duration(minutes: 30)},
    {'name': '35 minutes', 'value': Duration(minutes: 35)},
    {'name': '40 minutes', 'value': Duration(minutes: 40)},
    {'name': '45 minutes', 'value': Duration(minutes: 45)},
    {'name': '50 minutes', 'value': Duration(minutes: 50)},
    {'name': '55 minutes', 'value': Duration(minutes: 55)},
    {'name': '1 hour', 'value': Duration(hours: 1)},
    {'name': '2 hours', 'value': Duration(hours: 2)},
    {'name': '5 hours', 'value': Duration(hours: 5)},
    {'name': '12 hours', 'value': Duration(hours: 12)},
    {'name': '1 day', 'value': Duration(days: 1)},
    {'name': '2 day', 'value': Duration(days: 2)},
  ];

  List<Map<String, dynamic>> _days = <Map<String, dynamic>>[
    {'name': 'Sun', 'value': false},
    {'name': 'Mon', 'value': false},
    {'name': 'Tue', 'value': false},
    {'name': 'Wed', 'value': false},
    {'name': 'Thu', 'value': false},
    {'name': 'Fri', 'value': false},
    {'name': 'Sat', 'value': false},
  ];

  final List<Map<String, dynamic>> _repeat = <Map<String, dynamic>>[
    {'name': 'Once', 'desc': 'Once'},
    {'name': 'Daily', 'desc': 'Every day'},
    {'name': 'Weekly', 'desc': 'Every'},
    {'name': 'Bi-Weekly', 'desc': 'Every other'},
    {'name': 'Monthly', 'desc': 'Every month'},
    {'name': 'Yearly', 'desc': 'Every year'},
  ];

  @override
  Widget build(BuildContext context) => StoreConnector(
        converter: (Store<AppState> store) => ReminderViewModel(store.state),
        onInitialBuild: (ReminderViewModel viewModel) {
          if (viewModel.remId != null) {
            setState(() {
              _selectedRepeat = viewModel.item.reminder.selectedRepeat;
              _days = viewModel.item.reminder.days;
              var date = DateTime.fromMillisecondsSinceEpoch(
                  viewModel.item.reminder.reminderStart[0]);
              _selectedTime = TimeOfDay(hour: date.hour, minute: date.minute);
              _disabled = true;
            });
          }
        },
        builder: _buildPage,
      );

  Widget _buildPage(BuildContext context, ReminderViewModel viewModel) {
    final _setupReminder = Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Specify date and time',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: _disabled
                    ? null
                    : () async {
                        var val = await _quickReminderDialog(context);

                        if (val != null) {
                          setState(() {
                            _selectedDate = DateTime.now().add(val);
                            _selectedTime =
                                TimeOfDay.fromDateTime(_selectedDate);
                          });
                        }
                      },
                child: Text(
                  'Quick setup',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select date',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.cyan,
              ),
            ),
          ),
          TextButton(
            onPressed: _disabled
                ? null
                : () async {
                    var date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365 * 100)),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                        _autoSelectWeekday();
                      });
                    }
                  },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                DateFormat('MM/dd/yyyy').format(_selectedDate),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select time',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.cyan,
              ),
            ),
          ),
          TextButton(
            onPressed: _disabled
                ? null
                : () async {
                    var time = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );

                    if (time != null) {
                      setState(() {
                        _selectedTime = time;
                      });
                    }
                  },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _selectedTime.format(context),
              ),
            ),
          ),
        ],
      ),
    );

    final _setupChoices = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _setupReminder,
        Divider(
          color: Colors.grey,
          thickness: 0.75,
          height: 0,
        ),
        ReminderRepeatView(
          disabled: _disabled,
          days: _days,
          repeat: _repeat,
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          autoSelectWeekday: _autoSelectWeekday,
          resetSelectedWeekday: _resetSelectedWeekday,
          onRepeat: _onRepeat,
          onRepeatChanged: _onRepeatChanged,
          onSelectedRepeatChanged: _onSelectedRepeatChanged,
          selectedRepeat: _selectedRepeat,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Reminder'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white54,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              onPressed: () {
                if (viewModel.remId == null) {
                  _saveReminder(viewModel);
                } else {
                  _clearReminder(viewModel);
                }
              },
              child: Text(
                viewModel.remId == null ? 'Done' : 'Clear',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: _setupChoices,
      ),
    );
  }

  Future<dynamic> _quickReminderDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: QuickReminderSetupDialog(
          choice: _quickSelection,
          list: _quickMins,
          onChanged: (value) {
            Navigator.pop(context, _quickMins[value]['value']);
          },
        ),
      ),
    );
  }

  void _onRepeatChanged(var value) {
    setState(() {
      _onRepeat = value;
    });
  }

  void _onSelectedRepeatChanged(var value) {
    setState(() {
      _selectedRepeat = value;
    });
  }

  void _autoSelectWeekday() {
    _resetSelectedWeekday();

    var weekday = _selectedDate.weekday == 7 ? 0 : _selectedDate.weekday;

    setState(() {
      _days[weekday]['value'] = true;
    });
  }

  void _resetSelectedWeekday() {
    for (var element in _days) {
      element['value'] = false;
    }
  }

  String _todoListToString(List<ToDoItem> todoList) {
    var message = '';

    for (var todo in todoList) {
      message += '• ${todo.todo} ';
    }

    message = message.trim();

    return message;
  }

  void _saveReminder(ReminderViewModel viewModel) {
    if (isSelectedDateValid()) {
      var reminderStart = _getStartingPoints();

      // schedule the reminder on device
      var message = viewModel.item.description ??
          _todoListToString(viewModel.item.todoList);
      store.dispatch(ScheduleReminder(
          viewModel.item,
          _days,
          _selectedRepeat,
          viewModel.item.id,
          viewModel.type,
          viewModel.item.title,
          message,
          reminderStart));

      setState(() {
        _disabled = true;
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Reminder'),
          content: Text('Please select a time somewhere in the future.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  bool isSelectedDateValid() {
    var dateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    ).millisecondsSinceEpoch;

    var now = DateTime.now();
    var today = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
    ).millisecondsSinceEpoch;

    return (dateTime > today);
  }

  List<int> _getStartingPoints() {
    var dateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    ).millisecondsSinceEpoch;
    var startingPoints = <int>[];

    var weekDaysValue = <String, int>{
      'Mon': 1,
      'Tue': 2,
      'Wed': 3,
      'Thu': 4,
      'Fri': 5,
      'Sat': 6,
      'Sun': 7,
    };

    for (var day in _days) {
      // check if weekday is set to true
      if (day['value']) {
        // check current current weekday
        var currWeekDay = DateTime.fromMillisecondsSinceEpoch(dateTime).weekday;
        // check list week day value
        var weekDayValue = weekDaysValue[day['name']];

        var daysBetween = weekDayValue - currWeekDay;

        if (daysBetween > -1) {
          // means you can just add daysBetween to current dateTime
          startingPoints.add(DateTime.fromMillisecondsSinceEpoch(dateTime)
              .add(Duration(days: daysBetween))
              .millisecondsSinceEpoch);
        } else {
          // means week day has pass, set to earlier week day
          var daysToAdd = (7 - currWeekDay) + weekDayValue;
          startingPoints.add(DateTime.fromMillisecondsSinceEpoch(dateTime)
              .add(Duration(days: daysToAdd))
              .millisecondsSinceEpoch);
        }
      }
    }

    if (startingPoints.isEmpty) {
      return <int>[dateTime];
    } else {
      return startingPoints;
    }
  }

  void _clearReminder(ReminderViewModel viewModel) {
    store.dispatch(ClearReminder(viewModel.remId));
    store.dispatch(UpdateNote(
      Note(
        id: viewModel.item.id,
        title: viewModel.item.title,
        todoList: viewModel.item.todoList,
        description: viewModel.item.description,
        dateCreated: viewModel.item.dateCreated,
        dateModified: viewModel.item.dateModified,
        dateDeleted: viewModel.item.dateDeleted,
        dateArchived: viewModel.item.dateArchived,
        pinned: viewModel.item.pinned,
        reminder: Reminder(),
      ),
    ));

    setState(() {
      _selectedRepeat = 0;
      _resetSelectedWeekday();
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
      _disabled = false;
    });
  }
}
