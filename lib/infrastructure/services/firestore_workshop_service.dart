import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/workshop.dart';

class FirestoreWorkShopService {
  final CollectionReference _workShopCollection =
      FirebaseFirestore.instance.collection('workshop');

  Stream<List<Workshop>> getWorkShop() {
    return _workShopCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Workshop.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<void> deleteWorkshop(String id) {
    return _workShopCollection.doc(id).delete();
  }

  Future<void> addWorkshop(Workshop workshop) {
    return _workShopCollection.add({
      'id': workshop.id,
      'name': workshop.name,
      'direction': workshop.direction,
      'email': workshop.email,
      'phone': workshop.phone,
    }).then((_) {
      debugPrint('success');
    }).catchError((_) {
      debugPrint('error');
    });
  }
}
