import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({@required this.contoller, Key key}) : super(key: key);

  final TextEditingController contoller;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 500.w,
        height: 350.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 220.h,
              child: Center(
                child: TextFormField(
                  autofocus: true,
                  controller: contoller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(40.w),
                    hintText: 'Add todo item',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      height: 130.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
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
    );
  }
}
