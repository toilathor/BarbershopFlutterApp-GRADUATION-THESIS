/// user_id : 4
/// facility_id : 3
/// stylist_id : 3
/// user : {"name":"Dr. Hardy Reinger","avatar":"https://bit.ly/3kGo0rS"}

class Stylist {
  Stylist({
    this.userId,
    this.facilityId,
    this.stylistId,
    this.user,
  });

  Stylist.fromJson(dynamic json) {
    userId = json['user_id'];
    facilityId = json['facility_id'];
    stylistId = json['stylist_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  int? userId;
  int? facilityId;
  int? stylistId;
  User? user;

  Stylist copyWith({
    int? userId,
    int? facilityId,
    int? stylistId,
    User? user,
  }) =>
      Stylist(
        userId: userId ?? this.userId,
        facilityId: facilityId ?? this.facilityId,
        stylistId: stylistId ?? this.stylistId,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['facility_id'] = facilityId;
    map['stylist_id'] = stylistId;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

/// name : "Dr. Hardy Reinger"
/// avatar : "https://bit.ly/3kGo0rS"

class User {
  User({
    this.name,
    this.avatar,
  });

  User.fromJson(dynamic json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  String? name;
  String? avatar;

  User copyWith({
    String? name,
    String? avatar,
  }) =>
      User(
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['avatar'] = avatar;
    return map;
  }
}
