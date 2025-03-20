// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_sheet_header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairSheetHeader _$RepairSheetHeaderFromJson(
        Map<String, dynamic> json, String docId) =>
    RepairSheetHeader(
      id: json['id'] as String,
      name: json['name'] as String,
      failure: json['failure'] as String,
      solution: json['solution'] as String,
      client: Client.fromJson(json['client'] as Map<String, dynamic>, ""),
      workShop: json['workShop'] == null
          ? null
          : Workshop.fromJson(json['workShop'] as Map<String, dynamic>, ""),
      mechanic: json['mechanic'] == null
          ? null
          : Mechanic.fromJson(json['mechanic'] as Map<String, dynamic>, ""),
      entryDate: (json['entryDate'] as Timestamp).toDate(),
      status: (json['status'] as num).toInt(),
      docId: docId,
    );

Map<String, dynamic> _$RepairSheetHeaderToJson(RepairSheetHeader instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'failure': instance.failure,
      'solution': instance.solution,
      'client': instance.client,
      'workShop': instance.workShop,
      'mechanic': instance.mechanic,
      'entryDate': instance.entryDate.toIso8601String(),
      'status': instance.status,
      'docId': instance.docId,
    };
