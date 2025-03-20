import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/client.dart';

class FirestoreClientsService {
  final CollectionReference _clientsCollection =
      FirebaseFirestore.instance.collection('clients');

  Stream<List<Client>> getClients() {
    return _clientsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Client.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<void> deleteClient(String id) {
    return _clientsCollection.doc(id).delete();
  }

  Future<void> addClient(Client client) {
    return _clientsCollection.add({
      'id': client.id,
      'name': client.name,
      'phone': client.phone,
      'email': client.email,
      'direction': client.direction,
    }).then((_) {
      debugPrint('success');
    }).catchError((_) {
      debugPrint('error');
    });
  }
}
