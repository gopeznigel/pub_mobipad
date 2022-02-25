import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget trail;
  final Function onTap;

  const SettingsItem(
      {Key key, this.title, this.subTitle, this.trail, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  Visibility(
                    visible: subTitle != null,
                    child: Text(
                      subTitle ?? '',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: trail != null,
                child: trail ?? SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
