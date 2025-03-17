// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spare_part.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SparePart _$SparePartFromJson(Map<String, dynamic> json) => SparePart(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$SparePartToJson(SparePart instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand': instance.brand,
      'description': instance.description,
      'price': instance.price,
    };
