import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class MUser {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'birthday')
  final String birthday;
  @JsonKey(name: 'home_address')
  final String? homeAddress;
  @JsonKey(name: 'work_address')
  final String? workAddress;
  MUser({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.email,
    required this.birthday,
    this.homeAddress,
    this.workAddress,
  });

  factory MUser.defaultUser() => MUser(
        id: '',
        name: '',
        phoneNumber: '',
        email: '',
        birthday: '',
        homeAddress: '',
        workAddress: '',
      );

  factory MUser.fromJson(Map<String, dynamic> json) => _$MUserFromJson(json);

  Map<String, dynamic> toJson() => _$MUserToJson(this);
}
