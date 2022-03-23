// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryService _$CategoryServiceFromJson(Map<String, dynamic> json) =>
    CategoryService(
      id: json['id'] as int,
      name: json['name'] as String,
      serviceCuts: (json['serviceCuts'] as List<dynamic>?)
          ?.map((e) => ServiceCut.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryServiceToJson(CategoryService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'serviceCuts': instance.serviceCuts,
    };
