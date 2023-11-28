import 'package:first_app_lelkov/utilites/dialogs/generic_dialog.dart';
import 'package:flutter/widgets.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password reset',
    content: 'We have now sent you a password reaset link.',
    optionBuilder: () => {
      "OK": null,
    },
  );
}
