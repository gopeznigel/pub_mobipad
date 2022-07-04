import 'package:flutter/material.dart';
import 'package:mobipad/common_widgets/dialogs/delete_dialog.dart';
import 'package:mobipad/common_widgets/dialogs/loading_dialog.dart';

Future<bool> showConfirmationDialog(
    BuildContext context, String message, String redLabel) async {
  return (await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => ConfirmationDialog(
          message: message,
          redLabel: redLabel,
        ),
      )) ??
      false;
}

Future<void> showLoadingDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) => const LoadingDialog(),
  );
}
