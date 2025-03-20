import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/inventory.dart';

class FirestoreInventoryService {
  final CollectionReference _inventoryCollection =
      FirebaseFirestore.instance.collection('inventory');

  Stream<List<Inventory>> getInventory() {
    return _inventoryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Inventory.fromJson(data, doc.id);
      }).toList();
    });
  }

  Stream<List<Inventory>> getInventoryByType(String type) {
    return _inventoryCollection
        .where("type", isEqualTo: type)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Inventory.fromJson(data, doc.id);
      }).toList();
    });
  }

  Stream<List<Inventory>> getInventoryWith(String type) {
    return _inventoryCollection
        .where("type", isEqualTo: type)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Inventory.fromJson(data, doc.id);
      }).toList();
    });
  }

  Stream<List<Inventory>> getInventoryByTypeAndSparePart(
      String type, String sparePartId, String workShopId) {
    return _inventoryCollection
        .where("type", isNotEqualTo: type)
        .where("sparePart.id", isEqualTo: sparePartId)
        .where("workShop.id", isEqualTo: workShopId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Inventory.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<void> deleteInventory(String id) {
    return _inventoryCollection.doc(id).delete();
  }

  Future<void> updateInventoryService(String id, int quantity) {
    return _inventoryCollection.doc(id).update({"quantity": quantity}).then(
        (value) => debugPrint("DocumentSnapshot successfully updated!"),
        onError: (e) => debugPrint("Error updating document $e"));
  }

  Future<void> addInventory(Inventory inventory) {
    return _inventoryCollection.add({
      'id': inventory.id,
      'sparePart': {
        "id": inventory.sparePart.id,
        "name": inventory.sparePart.name,
        "price": inventory.sparePart.price
      },
      'quantity': inventory.quantity,
      'date': inventory.date,
      'reason': inventory.reason,
      'workShop': {
        "id": inventory.workShop.id,
        "name": inventory.workShop.name,
        "direction": inventory.workShop.direction
      },
      'type': inventory.type,
    }).then((_) {
      debugPrint('success');
    }).catchError((_) {
      debugPrint('error');
    });
  }
}
