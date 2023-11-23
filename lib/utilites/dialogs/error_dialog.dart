import 'package:first_app_lelkov/utilites/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: "An error occurred",
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
