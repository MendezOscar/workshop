// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Inventory _$InventoryFromJson(Map<String, dynamic> json, String docId) =>
    Inventory(
      id: json['id'] as String,
      sparePart:
          SparePart.fromJson(json['sparePart'] as Map<String, dynamic>, ""),
      quantity: (json['quantity'] as num).toInt(),
      date: (json['date'] as Timestamp).toDate(),
      reason: json['reason'] as String,
      workShop: Workshop.fromJson(json['workShop'] as Map<String, dynamic>, ""),
      type: json['type'] as String,
      docId: docId,
    );

Map<String, dynamic> _$InventoryToJson(Inventory instance) => <String, dynamic>{
      'id': instance.id,
      'sparePart': instance.sparePart,
      'quantity': instance.quantity,
      'date': instance.date,
      'reason': instance.reason,
      'workShop': instance.workShop,
      'type': instance.type,
    };
