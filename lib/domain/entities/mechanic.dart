import 'package:json_annotation/json_annotation.dart';

part 'mechanic.g.dart';

@JsonSerializable()
class Mechanic {
  final String id;
  final String name;
  final String? phone;
  final String? docId;

  Mechanic({required this.id, required this.name, this.phone, this.docId});

  factory Mechanic.fromJson(Map<String, dynamic> json, String docId) =>
      _$MechanicFromJson(json, docId);
  Map<String, dynamic> toJson() => _$MechanicToJson(this);
}
