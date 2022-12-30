import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes_app/services/cloud/cloud_note.dart';
import 'package:my_notes_app/services/cloud/cloud_storage_contants.dart';
import 'package:my_notes_app/services/cloud/cloud_storage_exceptions.dart';

class FirestoreCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Future<void> updateNotes({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map(
            (event) => event.docs
                .map((doc) => CloudNote.fromSnapshot(doc))
                .where((note) => note.ownerUserId == ownerUserId),
          );

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes.where(ownerUserFieldName == ownerUserId).get().then(
        (value) {
          return value.docs.map(
            (doc) {
              return CloudNote(
                documentId: doc.id,
                ownerUserId: doc.data()[ownerUserFieldName] as String,
                text: doc.data()[textFieldName] as String,
              );
            },
          );
        },
      );
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  void createNewNote({required String ownerUserId}) async {
    await notes.add({
      ownerUserFieldName: ownerUserId,
      textFieldName: '',
    });
  }

  static final FirestoreCloudStorage _shared =
      FirestoreCloudStorage._sharedInstance();
  FirestoreCloudStorage._sharedInstance();

  factory FirestoreCloudStorage() => _shared;
}
