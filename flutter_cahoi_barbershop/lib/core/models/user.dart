/// id : 1
/// name : "admin"
/// email : null
/// phone_number : "0973271208"
/// status : 1
/// points : 0
/// avatar : "https://bit.ly/3kGo0rS"
/// roles : [{"id":3,"name":"super-admin"}]
/// rank : {"id":1,"rank_name":"None","threshold":0}

class MUser {
  MUser({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.status,
    this.points,
    this.avatar,
    this.roles,
    this.rank,
  });

  MUser.initial()
      : id = 1,
        name = "",
        email = 1,
        phoneNumber = "",
        status = 1,
        points = 1,
        avatar = "",
        roles = [];

  MUser.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    status = json['status'];
    points = json['points'];
    avatar = json['avatar'];
    if (json['roles'] != null) {
      roles = [];
      json['roles'].forEach((v) {
        roles?.add(Roles.fromJson(v));
      });
    }
    rank = json['rank'] != null ? Rank.fromJson(json['rank']) : null;
  }

  int? id;
  String? name;
  dynamic email;
  String? phoneNumber;
  int? status;
  int? points;
  String? avatar;
  List<Roles>? roles;
  Rank? rank;

  MUser copyWith({
    int? id,
    String? name,
    dynamic email,
    String? phoneNumber,
    int? status,
    int? points,
    String? avatar,
    List<Roles>? roles,
    Rank? rank,
  }) =>
      MUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        status: status ?? this.status,
        points: points ?? this.points,
        avatar: avatar ?? this.avatar,
        roles: roles ?? this.roles,
        rank: rank ?? this.rank,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['status'] = status;
    map['points'] = points;
    map['avatar'] = avatar;
    if (roles != null) {
      map['roles'] = roles?.map((v) => v.toJson()).toList();
    }
    if (rank != null) {
      map['rank'] = rank?.toJson();
    }
    return map;
  }
}

/// id : 1
/// rank_name : "None"
/// threshold : 0

class Rank {
  Rank({
    this.id,
    this.rankName,
    this.threshold,
  });

  Rank.fromJson(dynamic json) {
    id = json['id'];
    rankName = json['rank_name'];
    threshold = json['threshold'];
  }

  int? id;
  String? rankName;
  int? threshold;

  Rank copyWith({
    int? id,
    String? rankName,
    int? threshold,
  }) =>
      Rank(
        id: id ?? this.id,
        rankName: rankName ?? this.rankName,
        threshold: threshold ?? this.threshold,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['rank_name'] = rankName;
    map['threshold'] = threshold;
    return map;
  }
}

/// id : 3
/// name : "super-admin"

class Roles {
  Roles({
    this.id,
    this.name,
  });

  Roles.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Roles copyWith({
    int? id,
    String? name,
  }) =>
      Roles(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
