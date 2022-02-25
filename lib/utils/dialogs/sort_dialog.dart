import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SortDialog extends StatelessWidget {
  final String sorting;
  final Function onTap;

  const SortDialog({Key key, this.sorting, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final options = <Map<String, dynamic>>[
      {
        'title': 'A-Z',
        'value': 'alpha',
        'icon': Icons.sort_by_alpha,
      },
      {
        'title': 'Date Created',
        'value': 'created',
        'icon': Icons.schedule,
      },
      {
        'title': 'Date Modified',
        'value': 'modified',
        'icon': Icons.slow_motion_video,
      },
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sort',
                  style: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Column(
                  children: List.generate(
                options.length,
                (i) => ListTile(
                  onTap: () {
                    onTap(options[i]['value']);
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    options[i]['icon'],
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    options[i]['title'],
                    style: TextStyle(
                        color: sorting.contains(options[i]['value'])
                            ? Colors.lightBlueAccent
                            : Colors.black),
                  ),
                ),
              )),
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
