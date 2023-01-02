import 'package:flutter/material.dart';
import 'package:my_notes_app/utilities/dialogs/generic_dialog.dart';

Future<void> showcannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: "Cannot share an empty note",
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
