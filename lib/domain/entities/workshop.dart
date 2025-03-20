import 'package:json_annotation/json_annotation.dart';

part 'workshop.g.dart';

@JsonSerializable()
class Workshop {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? direction;
  final String? docId;

  Workshop(
      {required this.id,
      required this.name,
      this.direction,
      this.email,
      this.phone,
      this.docId});

  factory Workshop.fromJson(Map<String, dynamic> json, String docId) =>
      _$WorkshopFromJson(json, docId);
  Map<String, dynamic> toJson() => _$WorkshopToJson(this);
}
