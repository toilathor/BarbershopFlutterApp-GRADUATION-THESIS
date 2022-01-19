import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category_service.g.dart';

@JsonSerializable()
class CategorySevice {
  String id;
  String name;
  List<ServiceCut>? serviceCuts;

  CategorySevice({
    required this.id,
    required this.name,
    this.serviceCuts,
  });

  factory CategorySevice.fromJson(Map<String, dynamic> json) =>
      _$CategorySeviceFromJson(json);

  Map<String, dynamic> toJson() => _$CategorySeviceToJson(this);
}
