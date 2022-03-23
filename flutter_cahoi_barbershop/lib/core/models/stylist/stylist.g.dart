// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stylist _$StylistFromJson(Map<String, dynamic> json) => Stylist(
      id: json['id'] as int,
      name: json['name'] as String,
      birthday: json['birthday'] as String,
      skill: (json['skill_rate'] as num).toDouble(),
      communication: (json['communication_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$StylistToJson(Stylist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'birthday': instance.birthday,
      'skill_rate': instance.skill,
      'communicate_rate': instance.communication,
    };
