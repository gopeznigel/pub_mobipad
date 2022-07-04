import 'package:flutter/material.dart';
import 'package:mobipad/styles/colors.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                color: OhNotesColor.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
