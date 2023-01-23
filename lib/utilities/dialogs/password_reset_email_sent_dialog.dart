import 'package:flutter/material.dart';
import 'package:my_notes_app/utilities/dialogs/generic_dialog.dart';
import 'package:my_notes_app/extensions/buildcontext/loc.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.password_reset,
    content: context.loc.password_reset_dialog_prompt,
    optionsBuilder: () => {context.loc.ok: null},
  );
}
