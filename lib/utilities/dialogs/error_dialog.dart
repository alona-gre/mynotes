import 'package:flutter/material.dart';
import 'package:my_notes_app/utilities/dialogs/generic_dialog.dart';
import 'package:my_notes_app/extensions/buildcontext/loc.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.generic_error_prompt,
    content: text,
    optionsBuilder: () => {context.loc.ok: null},
  );
}
