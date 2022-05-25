import 'package:flutter_cahoi_barbershop/core/models/image_db.dart';

/// id : 1
/// status : 1
/// notes : ""
/// captions : "thự là tiệt zời"
/// like_count : 0
/// public_at : "2022-05-24 16:23:33"
/// image : [{"id":1,"link":"/upload/task/Task-011652800761.jpg","task_id":1},{"id":2,"link":"/upload/task/Task-111652800761.jpg","task_id":1},{"id":3,"link":"/upload/task/Task-211652800761.jpg","task_id":1},{"id":4,"link":"/upload/task/Task-311652800761.jpg","task_id":1}]
/// stylist : {"id":12,"user":{"id":13,"name":"Garrison Hackett","avatar":"https://bit.ly/3kGo0rS"}}
/// customer : {"id":50,"name":"Thọ Lê Quang","avatar":"https://bit.ly/3kGo0rS"}

class Post {
  Post({
    this.id,
    this.status,
    this.notes,
    this.captions,
    this.likeCount,
    this.publicAt,
    this.image,
    this.stylist,
    this.customer,
  });

  Post.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    notes = json['notes'];
    captions = json['captions'];
    likeCount = json['like_count'];
    publicAt = json['public_at'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageDB.fromJson(v));
      });
    }
    stylist = Stylist.fromJson(json['stylist']);
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  int? id;
  int? status;
  String? notes;
  String? captions;
  int? likeCount;
  String? publicAt;
  List<ImageDB>? image;
  Stylist? stylist;
  Customer? customer;

  Post copyWith({
    int? id,
    int? status,
    String? notes,
    String? captions,
    int? likeCount,
    String? publicAt,
    List<ImageDB>? image,
    Stylist? stylist,
    Customer? customer,
  }) =>
      Post(
        id: id ?? this.id,
        status: status ?? this.status,
        notes: notes ?? this.notes,
        captions: captions ?? this.captions,
        likeCount: likeCount ?? this.likeCount,
        publicAt: publicAt ?? this.publicAt,
        image: image ?? this.image,
        stylist: stylist ?? this.stylist,
        customer: customer ?? this.customer,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['status'] = status;
    map['notes'] = notes;
    map['captions'] = captions;
    map['like_count'] = likeCount;
    map['public_at'] = publicAt;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    map['stylist'] = stylist;
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    return map;
  }
}

/// id : 50
/// name : "Thọ Lê Quang"
/// avatar : "https://bit.ly/3kGo0rS"

class Customer {
  Customer({
    this.id,
    this.name,
    this.avatar,
  });

  Customer.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  int? id;
  String? name;
  String? avatar;

  Customer copyWith({
    int? id,
    String? name,
    String? avatar,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    return map;
  }
}

/// id : 12
/// user : {"id":13,"name":"Garrison Hackett","avatar":"https://bit.ly/3kGo0rS"}

class Stylist {
  Stylist({
    this.id,
    this.user,
  });

  Stylist.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  int? id;
  User? user;

  Stylist copyWith({
    int? id,
    User? user,
  }) =>
      Stylist(
        id: id ?? this.id,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

/// id : 13
/// name : "Garrison Hackett"
/// avatar : "https://bit.ly/3kGo0rS"

class User {
  User({
    this.id,
    this.name,
    this.avatar,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  int? id;
  String? name;
  String? avatar;

  User copyWith({
    int? id,
    String? name,
    String? avatar,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    return map;
  }
}
