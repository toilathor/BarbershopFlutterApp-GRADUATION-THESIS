// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stylist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stylist _$StylistFromJson(Map<String, dynamic> json) => Stylist(
      id: json['id'] as String,
      name: json['name'] as String,
      skill: json['skill'] as String,
      communicate: json['communicate'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$StylistToJson(Stylist instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'skill': instance.skill,
      'communicate': instance.communicate,
      'avatar': instance.avatar,
    };
