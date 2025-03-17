import 'package:json_annotation/json_annotation.dart';

part 'workshop.g.dart';

@JsonSerializable()
class Workshop {
  final String id;
  final String name;
  final String? direction;

  Workshop({required this.id, required this.name, this.direction});

  factory Workshop.fromJson(Map<String, dynamic> json) =>
      _$WorkshopFromJson(json);
  Map<String, dynamic> toJson() => _$WorkshopToJson(this);
}
