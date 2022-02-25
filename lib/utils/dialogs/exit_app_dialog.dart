import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobipad/vars/colors.dart';

class ExitAppDialog extends StatelessWidget {
  const ExitAppDialog({
    @required this.ads,
    Key key,
  }) : super(key: key);

  final Widget ads;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 800.h,
                  padding: const EdgeInsets.all(5),
                  child: ads,
                ),
                Divider(
                  height: 0,
                  thickness: 0.75,
                  color: Colors.black54,
                ),
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Are you sure you want to exit?',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 130.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                height: 130.h,
                                decoration: BoxDecoration(
                                  color: OhNotesColor.primary,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    'Exit',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, false);
                              },
                              child: Container(
                                height: 130.h,
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(color: Colors.grey))),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
