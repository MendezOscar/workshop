import 'package:json_annotation/json_annotation.dart';

part 'spare_part.g.dart';

@JsonSerializable()
class SparePart {
  final String id;
  final String name;
  final String? brand;
  final String? description;
  final int price;
  final String? docId;

  SparePart(
      {required this.id,
      required this.name,
      this.brand,
      this.description,
      required this.price,
      this.docId});

  factory SparePart.fromJson(Map<String, dynamic> json, String docId) =>
      _$SparePartFromJson(json, docId);
  Map<String, dynamic> toJson() => _$SparePartToJson(this);
}
