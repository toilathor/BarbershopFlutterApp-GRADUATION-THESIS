import 'package:json_annotation/json_annotation.dart';

part 'service_cut.g.dart';

@JsonSerializable()
class ServiceCut {
  @JsonKey(name: 'id')
  int id;
  String name;
  int price;
  int duration;
  @JsonKey(name: 'short_description')
  String shortDescription;
  @JsonKey(name: 'full_description')
  String fullDescription;
  @JsonKey(name: 'category_service_id')
  int categoryServiceId;

  ServiceCut({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.shortDescription,
    required this.fullDescription,
    required this.categoryServiceId,
  });

  factory ServiceCut.fromJson(Map<String, dynamic> json) =>
      _$ServiceCutFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCutToJson(this);
}
