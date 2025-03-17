// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_sheet_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairSheetDetails _$RepairSheetDetailsFromJson(Map<String, dynamic> json) =>
    RepairSheetDetails(
      departureDate: json['departureDate'] == null
          ? null
          : (json['departureDate'] as Timestamp).toDate(),
      serviceDescription: json['serviceDescription'] as String?,
      servicePrice: (json['servicePrice'] as num?)?.toInt(),
      spareParts: (json['spareParts'] as List<dynamic>?)
          ?.map((e) => SparePart.fromJson(e as Map<String, dynamic>))
          .toList(),
      sparePartsPrice: (json['sparePartsPrice'] as num?)?.toInt(),
      discount: (json['discount'] as num?)?.toInt(),
      totalRepairCost: (json['totalRepairCost'] as num?)?.toInt(),
      id: json['id'] as String,
      repairSheetHeaderId: json['repairSheetHeaderId'] as String,
    );

Map<String, dynamic> _$RepairSheetDetailsToJson(RepairSheetDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'departureDate': instance.departureDate?.toIso8601String(),
      'serviceDescription': instance.serviceDescription,
      'servicePrice': instance.servicePrice,
      'spareParts': instance.spareParts,
      'sparePartsPrice': instance.sparePartsPrice,
      'discount': instance.discount,
      'totalRepairCost': instance.totalRepairCost,
      'repairSheetHeaderId': instance.repairSheetHeaderId,
    };
