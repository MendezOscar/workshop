import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'workshop.dart';

import 'client.dart';
import 'mechanic.dart';

part 'repair_sheet_header.g.dart';

@JsonSerializable()
class RepairSheetHeader {
  final String id;
  final String name;
  final String failure;
  final String solution;
  final Client client;
  final Mechanic? mechanic;
  final DateTime entryDate;
  final int status;
  final String? docId;
  final Workshop? workShop;

  RepairSheetHeader(
      {required this.id,
      required this.name,
      required this.failure,
      required this.solution,
      required this.client,
      this.mechanic,
      required this.entryDate,
      required this.status,
      this.docId,
      this.workShop});

  factory RepairSheetHeader.fromJson(Map<String, dynamic> json, String docId) =>
      _$RepairSheetHeaderFromJson(json, docId);
  Map<String, dynamic> toJson() => _$RepairSheetHeaderToJson(this);
}


//(json['entryDate'] as Timestamp).toDate(),