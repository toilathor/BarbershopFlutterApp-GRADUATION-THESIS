import 'package:json_annotation/json_annotation.dart';

part 'workplace.g.dart';

@JsonSerializable()
class Workplace {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'address')
  final String name;
  @JsonKey(name: 'latitude')
  final double latitude;

  @JsonKey(name: 'longitude')
  final double longitude;

  Workplace({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Workplace.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceFromJson(json);

  @override
  String toString() {
    return 'Workplace{id: $id, name: $name, latitude: $latitude, longitude: $longitude}';
  }

  Map<String, dynamic> toJson() => _$WorkplaceToJson(this);
}
