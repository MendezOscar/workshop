// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workshop _$WorkshopFromJson(Map<String, dynamic> json) => Workshop(
      id: json['id'] as String,
      name: json['name'] as String,
      direction: json['direction'] as String?,
    );

Map<String, dynamic> _$WorkshopToJson(Workshop instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'direction': instance.direction,
    };
