// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workshop _$WorkshopFromJson(Map<String, dynamic> json, String docId) =>
    Workshop(
        id: json['id'] as String,
        name: json['name'] as String,
        direction: json['direction'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        docId: docId);

Map<String, dynamic> _$WorkshopToJson(Workshop instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'direction': instance.direction,
      'email': instance.email,
      'phone': instance.phone,
    };
