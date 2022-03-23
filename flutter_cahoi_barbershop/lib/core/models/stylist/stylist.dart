import 'package:json_annotation/json_annotation.dart';

part 'stylist.g.dart';

@JsonSerializable()
class Stylist {
  int id;
  String name;
  String birthday;
  @JsonKey(name: 'skill_rate')
  double skill;
  @JsonKey(name: 'communication_rate')
  double communication;

  Stylist(
      {required this.id,
      required this.name,
      required this.birthday,
      required this.skill,
      required this.communication});

  factory Stylist.fromJson(Map<String, dynamic> json) =>
      _$StylistFromJson(json);

  Map<String, dynamic> toJson() => _$StylistToJson(this);
}
