import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickReminderSetupDialog extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final int choice;
  final Function onChanged;

  const QuickReminderSetupDialog({
    Key key,
    this.list,
    this.choice,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Quick reminder',
              style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  list.length,
                  (i) => RadioListTile(
                    groupValue: choice,
                    onChanged: onChanged,
                    value: i,
                    title: Text('${list[i]['name']}'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 30.w),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
