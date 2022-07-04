import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobipad/styles/colors.dart';
import 'package:mobipad/styles/text_styles.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.loading,
    required this.onTap,
    this.label = 'Login',
    this.width,
    this.height,
  }) : super(key: key);

  final String label;
  final double? width;
  final double? height;
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
          primary:
              !loading ? OhNotesColor.activeIcons : OhNotesColor.inactiveIcons,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: () {
          onTap();
        },
        child: !loading
            ? Text(
                label,
                style: OhNotesTextStyles.button.copyWith(
                  color: OhNotesColor.primary,
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key? key,
    required this.onTap,
    this.width,
    this.height,
    this.isLoading = false,
  }) : super(key: key);

  final double? width;
  final double? height;
  final bool isLoading;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.0,
      width: width ?? 700,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 3,
          primary: OhNotesColor.googleButton,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                    style: OhNotesTextStyles.button.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
