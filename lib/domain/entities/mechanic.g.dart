// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mechanic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mechanic _$MechanicFromJson(Map<String, dynamic> json, String docId) =>
    Mechanic(
        id: json['id'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String?,
        docId: docId);

Map<String, dynamic> _$MechanicToJson(Mechanic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };
