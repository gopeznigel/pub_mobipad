import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/features/settings/ui/widgets/settings_item.dart';

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsGroup({Key key, this.title, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Column(
            children: List.generate(items.length, (i) {
              return Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  items[i],
                ],
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1),
            child: Divider(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
