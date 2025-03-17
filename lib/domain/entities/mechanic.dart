import 'package:json_annotation/json_annotation.dart';

part 'mechanic.g.dart';

@JsonSerializable()
class Mechanic {
  final String id;
  final String name;
  final String? phone;

  Mechanic({
    required this.id,
    required this.name,
    this.phone,
  });

  factory Mechanic.fromJson(Map<String, dynamic> json) =>
      _$MechanicFromJson(json);
  Map<String, dynamic> toJson() => _$MechanicToJson(this);
}
