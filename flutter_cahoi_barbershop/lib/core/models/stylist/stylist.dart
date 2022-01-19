import 'package:json_annotation/json_annotation.dart';

part 'stylist.g.dart';

@JsonSerializable()
class Stylist {
  String id;
  String name;
  String skill;
  String communicate;
  String avatar;
  Stylist({
    required this.id,
    required this.name,
    required this.skill,
    required this.communicate,
    required this.avatar,
  });

  factory Stylist.fromJson(Map<String, dynamic> json) =>
      _$StylistFromJson(json);

  Map<String, dynamic> toJson() => _$StylistToJson(this);
}
