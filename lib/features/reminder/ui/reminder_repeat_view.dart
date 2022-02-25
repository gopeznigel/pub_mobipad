import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobipad/features/reminder/ui/widget/day_check_box.dart';
import 'package:mobipad/features/reminder/ui/widget/repeat_radio_tile.dart';

class ReminderRepeatView extends StatefulWidget {
  final bool onRepeat;
  final bool disabled;
  final int selectedRepeat;
  final List<Map<String, dynamic>> days;
  final List<Map<String, dynamic>> repeat;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function autoSelectWeekday;
  final Function resetSelectedWeekday;
  final Function onRepeatChanged;
  final Function onSelectedRepeatChanged;

  const ReminderRepeatView({
    Key key,
    @required this.disabled,
    @required this.days,
    @required this.repeat,
    @required this.selectedDate,
    @required this.selectedTime,
    @required this.autoSelectWeekday,
    @required this.resetSelectedWeekday,
    @required this.onRepeatChanged,
    @required this.onRepeat,
    @required this.selectedRepeat,
    @required this.onSelectedRepeatChanged,
  }) : super(key: key);

  @override
  _ReminderRepeatViewState createState() => _ReminderRepeatViewState();
}

class _ReminderRepeatViewState extends State<ReminderRepeatView> {
  @override
  Widget build(BuildContext context) {
    final _repeatSelection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Select repetition',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.cyan,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(widget.repeat.length, (i) {
              return RepeatRadioTile(
                groupValue: widget.selectedRepeat,
                value: i,
                onChanged: widget.disabled
                    ? null
                    : (value) {
                        widget.onSelectedRepeatChanged(value);

                        if (i == 5) {
                          widget.resetSelectedWeekday();
                        } else {
                          widget.autoSelectWeekday();
                        }
                      },
                title: widget.repeat[i]['name'],
              );
            }),
          ),
        ),
      ],
    );

    final _daysSelection = Visibility(
      visible: widget.selectedRepeat > 1 && widget.selectedRepeat < 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select day/s',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.cyan,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(widget.days.length, (i) {
                return DayCheckBox(
                  count: _getNumberOfWeekDaySelected(),
                  repetition: widget.selectedRepeat,
                  value: widget.days[i]['value'],
                  onChanged: widget.disabled
                      ? null
                      : (value) {
                          setState(() {
                            widget.days[i]['value'] = value;
                          });
                        },
                  title: widget.days[i]['name'],
                );
              }),
            ),
          ),
        ],
      ),
    );

    final _repeatSetup = Column(
      children: [
        CheckboxListTile(
          value: widget.onRepeat,
          title: Text(
            'Repeat reminder',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          subtitle: _getRepeatDescription(),
          onChanged: widget.disabled ? null : widget.onRepeatChanged,
        ),
        Visibility(
          visible: widget.onRepeat,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _repeatSelection,
                _daysSelection,
              ],
            ),
          ),
        ),
      ],
    );

    return _repeatSetup;
  }

  Widget _getRepeatDescription() {
    var text = ' ';
    text = widget.repeat[widget.selectedRepeat]['desc'];

    // Show reminder date when once is selected
    if (widget.selectedRepeat == 0) {
      var day = DateFormat('MMM dd').format(widget.selectedDate);
      text += ' on $day';
    }

    // if no week day is selected, repeat every selected calendar day
    if (widget.selectedRepeat > 1) {
      if (_getNumberOfWeekDaySelected() == 0) {
        if (widget.selectedRepeat > 3) {
          var day = DateFormat('dd').format(widget.selectedDate);
          text += ' on day $day';
        }
      } else {
        if (widget.selectedRepeat == 4) {
          // get week number of week day
          var weekCount = _getWeekOfMonth();
          text = text.replaceFirst('month', '');
          text += weekCount;
        }
        // there is a selected week day
        for (var e in widget.days) {
          if (e['value']) {
            text += ' ${e['name']},';
          }
        }

        // remove last comma
        text = text.substring(0, text.length - 1);
      }
    }

    text += ' at ${widget.selectedTime.format(context)}';

    return Text(text);
  }

  int _getNumberOfWeekDaySelected() {
    var count = 0;
    for (var e in widget.days) {
      if (e['value']) {
        count++;
      }
    }

    return count;
  }

  String _getWeekOfMonth() {
    String week = 'first';

    var weekCount = 0;
    var currMonth = widget.selectedDate.month;
    var month = widget.selectedDate.month;
    var selectedDate = widget.selectedDate;

    while (currMonth == month) {
      weekCount++;
      selectedDate = selectedDate.subtract(Duration(days: 7));
      month = selectedDate.month;
    }

    switch (weekCount) {
      case 1:
        week = 'first';
        break;
      case 2:
        week = 'second';
        break;
      case 3:
        week = 'third';
        break;
      case 4:
        week = 'fourth';
        break;
      case 5:
        week = 'fifth';
        break;
      default:
    }

    return week;
  }
}
