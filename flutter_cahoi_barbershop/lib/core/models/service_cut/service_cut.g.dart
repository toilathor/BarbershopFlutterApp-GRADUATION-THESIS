// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_cut.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCut _$ServiceCutFromJson(Map<String, dynamic> json) => ServiceCut(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      duration: json['duration'] as String,
      sortDescription: json['sortDescription'] as String,
      fullDescription: json['fullDescription'] as String,
      imagesDemo: json['imagesDemo'] as String,
      idCategory: json['idCategory'] as String,
    );

Map<String, dynamic> _$ServiceCutToJson(ServiceCut instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'duration': instance.duration,
      'sortDescription': instance.sortDescription,
      'fullDescription': instance.fullDescription,
      'imagesDemo': instance.imagesDemo,
      'idCategory': instance.idCategory,
    };
