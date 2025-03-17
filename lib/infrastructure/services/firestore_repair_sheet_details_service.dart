import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/repair_sheet_details.dart';

class FirestoreRepairSheetDetailsService {
  final CollectionReference _repairSheetDetailsCollection =
      FirebaseFirestore.instance.collection('repairsheetdetails');

  Stream<List<RepairSheetDetails>> getRepairSheetDetails() {
    return _repairSheetDetailsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return RepairSheetDetails.fromJson(data);
      }).toList();
    });
  }

  Stream<RepairSheetDetails?> getRepairSheetDetailsByHeaderId(
      String repairSheetHeaderId) {
    return _repairSheetDetailsCollection
        .where("repairSheetHeaderId", isEqualTo: repairSheetHeaderId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return RepairSheetDetails.fromJson(data);
      }).firstOrNull;
    });
  }

  Future<void> addRepairSheetDetailsService(
      RepairSheetDetails repairSheetDetails) {
    return _repairSheetDetailsCollection.add({
      'id': repairSheetDetails.id,
      'departureDate': repairSheetDetails.departureDate,
      'serviceDescription': repairSheetDetails.serviceDescription,
      'servicePrice': repairSheetDetails.servicePrice,
      'spareParts':
          repairSheetDetails.spareParts!.map((e) => e.toJson()).toList(),
      'sparePartsPrice': repairSheetDetails.sparePartsPrice,
      'discount': repairSheetDetails.discount,
      'totalRepairCost': repairSheetDetails.totalRepairCost,
      'repairSheetHeaderId': repairSheetDetails.repairSheetHeaderId
    }).then((_) {
      debugPrint('success');
    }).catchError((_) {
      debugPrint('error');
    });
  }
}
