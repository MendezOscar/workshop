import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/spare_part.dart';

class FirestoreSparePartService {
  final CollectionReference _sparePartCollection =
      FirebaseFirestore.instance.collection('sparepart');

  Stream<List<SparePart>> getSparePart() {
    return _sparePartCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return SparePart.fromJson(data);
      }).toList();
    });
  }

  Future<void> deleteSparePart(String id) {
    return _sparePartCollection.doc(id).delete();
  }

  Future<void> addSparePart(SparePart sparePart) {
    return _sparePartCollection.add({
      'id': sparePart.id,
      'name': sparePart.name,
      'brand': sparePart.brand,
      'description': sparePart.description,
      'price': sparePart.price,
    }).then((_) {
      debugPrint('success');
    }).catchError((_) {
      debugPrint('error');
    });
  }
}
