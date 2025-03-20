import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/mechanic.dart';

class FirestoreMechanicsService {
  final CollectionReference _mechanicsCollection =
      FirebaseFirestore.instance.collection('mechanics');

  Stream<List<Mechanic>> getMechanics() {
    return _mechanicsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Mechanic.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<void> deleteMechanic(String id) {
    return _mechanicsCollection.doc(id).delete();
  }

  Future<void> addMechanic(Mechanic mechanic) {
    return _mechanicsCollection.add({
      'id': mechanic.id,
      'name': mechanic.name,
      'phone': mechanic.phone
    }).then((_) {
      debugPrint('success');
    }).catchError((_) {
      debugPrint('error');
    });
  }
}
