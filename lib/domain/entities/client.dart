import 'package:json_annotation/json_annotation.dart';

part 'client.g.dart';

@JsonSerializable()
class Client {
  final String id;
  final String name;
  final String? phone;
  final String? email;
  final String? direction;

  Client(
      {required this.id,
      required this.name,
      this.phone,
      this.email,
      this.direction});

  factory Client.fromJson(Map<String, dynamic> json) => _$ClientFromJson(json);
  Map<String, dynamic> toJson() => _$ClientToJson(this);
}
