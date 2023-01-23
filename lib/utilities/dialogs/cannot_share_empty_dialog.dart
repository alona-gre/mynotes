import 'package:flutter/material.dart';
import 'package:my_notes_app/extensions/buildcontext/loc.dart';
import 'package:my_notes_app/utilities/dialogs/generic_dialog.dart';

Future<void> showcannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: context.loc.sharing,
    content: context.loc.cannot_share_empty_note_prompt,
    optionsBuilder: () => {
      context.loc.ok: null,
    },
  );
}
