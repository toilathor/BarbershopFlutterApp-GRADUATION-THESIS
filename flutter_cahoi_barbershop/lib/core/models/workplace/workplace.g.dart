// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workplace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workplace _$WorkplaceFromJson(Map<String, dynamic> json) => Workplace(
      id: json['id'] as int,
      name: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$WorkplaceToJson(Workplace instance) => <String, dynamic>{
      'id': instance.id,
      'address': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
