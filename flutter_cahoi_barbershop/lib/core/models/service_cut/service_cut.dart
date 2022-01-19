import 'package:json_annotation/json_annotation.dart';

part 'service_cut.g.dart';

@JsonSerializable()
class ServiceCut {
  String id;
  String name;
  String price;
  String duration;
  String sortDescription;
  String fullDescription;
  String imagesDemo;
  String idCategory;

  ServiceCut({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.sortDescription,
    required this.fullDescription,
    required this.imagesDemo,
    required this.idCategory,
  });

  factory ServiceCut.fromJson(Map<String, dynamic> json) =>
      _$ServiceCutFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCutToJson(this);
}
