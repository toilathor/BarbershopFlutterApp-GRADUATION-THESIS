// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategorySevice _$CategorySeviceFromJson(Map<String, dynamic> json) =>
    CategorySevice(
      id: json['id'] as String,
      name: json['name'] as String,
      serviceCuts: (json['serviceCuts'] as List<dynamic>?)
          ?.map((e) => ServiceCut.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategorySeviceToJson(CategorySevice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'serviceCuts': instance.serviceCuts,
    };
