import 'package:flutter/material.dart';
import 'package:my_notes_app/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content:
        'We have just sent a link to reset password to your email address. Please check your inbox.',
    optionsBuilder: () => {'Ok': null},
  );
}
