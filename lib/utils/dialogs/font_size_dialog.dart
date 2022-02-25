import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontSizeDialog extends StatelessWidget {
  final List<String> fontSizeNameList;
  final List<int> fontSizeList;
  final int fontSize;
  final Function onChanged;

  const FontSizeDialog({
    Key key,
    this.fontSizeNameList,
    this.fontSizeList,
    this.fontSize,
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
              'Select font size',
              style: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  fontSizeNameList.length,
                  (i) => RadioListTile(
                    groupValue: fontSize,
                    onChanged: onChanged,
                    value: fontSizeList[i],
                    title: Text(fontSizeNameList[i]),
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
    );
  }
}
