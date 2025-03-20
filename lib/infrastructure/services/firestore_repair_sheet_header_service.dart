import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/repair_sheet_header.dart';

class FirestoreRepairSheetHeaderService {
  final CollectionReference _repairSheetHeaderCollection =
      FirebaseFirestore.instance.collection('repairsheetheader');

  Stream<List<RepairSheetHeader>> getRepairSheetHeader() {
    return _repairSheetHeaderCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return RepairSheetHeader.fromJson(data, doc.id);
      }).toList();
    });
  }

  Stream<List<RepairSheetHeader>> getRepairSheetHeaderByStatusAndDate(
      int status, DateTime date) {
    return _repairSheetHeaderCollection
        .where("status", isEqualTo: status)
        .where("entryDate",
            isGreaterThan:
                DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0))
        .where("entryDate",
            isLessThan:
                DateTime(date.year, date.month, date.day, 23, 59, 59, 59, 59))
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return RepairSheetHeader.fromJson(data, doc.id);
      }).toList();
    });
  }

  Stream<List<RepairSheetHeader>> getRepairSheetHeaderByStatus(int status) {
    return _repairSheetHeaderCollection
        .where("status", isEqualTo: status)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return RepairSheetHeader.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<void> deleteRepairSheetHeader(String id) {
    return _repairSheetHeaderCollection.doc(id).delete();
  }

  Future<void> updateStatusRepairSheetHeaderService(String id, int status) {
    return _repairSheetHeaderCollection.doc(id).update({"status": status}).then(
        (value) => debugPrint("DocumentSnapshot successfully updated!"),
        onError: (e) => debugPrint("Error updating document $e"));
  }

  Future<void> addRepairSheetHeaderService(
      RepairSheetHeader repairSheetHeader) {
    return _repairSheetHeaderCollection.add({
      'id': repairSheetHeader.id,
      'name': repairSheetHeader.name,
      'failure': repairSheetHeader.failure,
      'solution': repairSheetHeader.solution,
      'client': {
        "id": repairSheetHeader.client.id,
        "name": repairSheetHeader.client.name,
        "phone": repairSheetHeader.client.phone,
      },
      'workShop': {
        "id": repairSheetHeader.workShop!.id,
        "name": repairSheetHeader.workShop!.name,
        "direction": repairSheetHeader.workShop?.direction ?? ""
      },
      'mechanic': {
        "id": repairSheetHeader.mechanic!.id,
        "name": repairSheetHeader.mechanic!.name,
        "phone": repairSheetHeader.mechanic!.phone,
      },
      'entryDate': repairSheetHeader.entryDate,
      'status': repairSheetHeader.status,
    }).then((_) {
      debugPrint('success');
    }).catchError((_) {
      debugPrint('error');
    });
  }
}
