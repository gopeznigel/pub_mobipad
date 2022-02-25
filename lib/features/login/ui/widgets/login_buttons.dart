import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobipad/vars/colors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {Key key,
      this.label = 'Login',
      this.width,
      this.height,
      this.loading,
      @required this.onTap})
      : super(key: key);

  final String label;
  final double width;
  final double height;
  final Function onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.0,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: !loading
              ? OhNotesColor.active_icons
              : OhNotesColor.inactive_icons,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp)),
        ),
        onPressed: () {
          onTap();
        },
        child: !loading
            ? Text(
                label,
                style: TextStyle(
                  fontSize: 45.sp,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    @required this.onTap,
    this.width,
    this.height,
    this.isLoading = false,
    Key key,
  }) : super(key: key);

  final double width;
  final double height;
  final bool isLoading;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.0,
      width: width ?? 700.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: OhNotesColor.google_button,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp)),
        ),
        onPressed: () {
          onTap();
        },
        child: !isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Login with Google',
                    style: TextStyle(
                      fontSize: 45.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
