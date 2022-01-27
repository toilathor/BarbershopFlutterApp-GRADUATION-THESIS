// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_cut.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCut _$ServiceCutFromJson(Map<String, dynamic> json) => ServiceCut(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      duration: json['duration'] as int,
      shortDescription: json['short_description'] as String,
      fullDescription: json['full_description'] as String,
      categoryServiceId: json['category_service_id'] as int,
    );

Map<String, dynamic> _$ServiceCutToJson(ServiceCut instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'duration': instance.duration,
      'short_description': instance.shortDescription,
      'full_description': instance.fullDescription,
      'category_service_id': instance.categoryServiceId,
    };
