import 'package:flutter_cahoi_barbershop/core/models/service_cut/service_cut.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_service.g.dart';

@JsonSerializable()
class CategoryService {
  @JsonKey(name: 'id')
  int id;
  String name;
  List<ServiceCut>? serviceCuts;

  CategoryService({
    required this.id,
    required this.name,
    this.serviceCuts,
  });

  factory CategoryService.fromJson(Map<String, dynamic> json) =>
      _$CategoryServiceFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryServiceToJson(this);

  @override
  String toString() =>
      'CategoryService(id: $id, name: $name, serviceCuts: $serviceCuts)';
}
