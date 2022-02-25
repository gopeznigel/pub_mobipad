import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimeDisplayDialog extends StatelessWidget {
  final List<Map<String, String>> dateTimeDisplayList;
  final String dateTimeDisplay;
  final Function onChanged;

  const DateTimeDisplayDialog(
      {Key key, this.dateTimeDisplayList, this.dateTimeDisplay, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Select date & time display',
                  style:
                      TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w600),
                ),
              ),
              Column(
                children: List.generate(
                  dateTimeDisplayList.length,
                  (i) => RadioListTile(
                    groupValue: dateTimeDisplay,
                    onChanged: onChanged,
                    value: dateTimeDisplayList[i]['title'],
                    title: Text(dateTimeDisplayList[i]['title']),
                    secondary: Text(
                      '(${dateTimeDisplayList[i]['sample']})',
                      style: TextStyle(color: Colors.grey),
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
                        Navigator.pop(context);
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
        ),
      ],
    );
  }
}
