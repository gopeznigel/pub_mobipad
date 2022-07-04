import 'package:flutter/material.dart';
import 'package:mobipad/styles/text_styles.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.message,
    required this.redLabel,
  }) : super(key: key);

  final String message;
  final String redLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(),
            Text(
              message,
              textAlign: TextAlign.center,
              style: OhNotesTextStyles.dialogLabel.copyWith(
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          redLabel,
                          style: OhNotesTextStyles.dialogLabel.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: OhNotesTextStyles.dialogLabel.copyWith(
                            color: Colors.black,
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
