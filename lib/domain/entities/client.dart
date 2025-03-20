import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? direction;
  final String? docId;

  Client(
      {required this.id,
      required this.name,
      this.phone,
      this.email,
      this.direction,
      this.docId});

  factory Client.fromJson(Map<String, dynamic> json, String docId) =>
      _$ClientFromJson(json, docId);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
