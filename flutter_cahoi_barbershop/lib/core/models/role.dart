/// id : 1
/// name : "super-admin"

class Role {
  Role({
    this.id,
    this.name,
  });

  Role.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Role copyWith({
    int? id,
    String? name,
  }) =>
      Role(
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
