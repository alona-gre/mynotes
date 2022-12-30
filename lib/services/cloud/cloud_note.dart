import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_notes_app/services/cloud/cloud_storage_contants.dart';
import 'package:flutter/material.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;

  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });

  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserFieldName],
        text = snapshot.data()[textFieldName] as String;
}
