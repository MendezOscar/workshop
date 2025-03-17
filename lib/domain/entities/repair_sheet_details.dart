import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'spare_part.dart';

part 'repair_sheet_details.g.dart';

@JsonSerializable()
class RepairSheetDetails {
  final String id;
  final DateTime? departureDate;
  final String? serviceDescription;
  final int? servicePrice;
  final List<SparePart>? spareParts;
  final int? sparePartsPrice;
  final int? discount;
  final int? totalRepairCost;
  final String repairSheetHeaderId;

  RepairSheetDetails(
      {this.departureDate,
      this.serviceDescription,
      this.servicePrice,
      this.spareParts,
      this.sparePartsPrice,
      this.discount,
      this.totalRepairCost,
      required this.id,
      required this.repairSheetHeaderId});

  factory RepairSheetDetails.fromJson(Map<String, dynamic> json) =>
      _$RepairSheetDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$RepairSheetDetailsToJson(this);
}


// (json['departureDate'] as Timestamp).toDate(),