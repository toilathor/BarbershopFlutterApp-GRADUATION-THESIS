class MUser {
  final String id;
  final String name;
  final String phoneNumber;
  final String? email;
  final String birthday;
  final String? homeAddress;
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

MUser _$MUserFromJson(Map<String, dynamic> json) => MUser(
  id: json['id'] as String,
  name: json['name'] as String,
  phoneNumber: json['phone_number'] as String,
  email: json['email'] as String?,
  birthday: json['birthday'] as String,
  homeAddress: json['home_address'] as String?,
  workAddress: json['work_address'] as String?,
);

Map<String, dynamic> _$MUserToJson(MUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone_number': instance.phoneNumber,
  'email': instance.email,
  'birthday': instance.birthday,
  'home_address': instance.homeAddress,
  'work_address': instance.workAddress,
};