import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'spare_part.dart';
import 'workshop.dart';

part 'inventory.g.dart';

@JsonSerializable()
class Inventory {
  final String id;
  final SparePart sparePart;
  final int quantity;
  final DateTime date;
  final String reason;
  final Workshop workShop;
  final String type;
  final String? docId;

  Inventory(
      {required this.id,
      required this.sparePart,
      required this.date,
      required this.reason,
      required this.workShop,
      required this.quantity,
      required this.type,
      this.docId});

  factory Inventory.fromJson(Map<String, dynamic> json, String docId) =>
      _$InventoryFromJson(json, docId);
  Map<String, dynamic> toJson() => _$InventoryToJson(this);
}
