import 'package:flutter_cahoi_barbershop/core/models/image_db.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';

/// id : 1
/// captions : "thự là tiệt zời"
/// like_count : 3
/// public_at : "2022-05-24 16:23:33"
/// task : {"id":190,"status":1,"customer":{"id":50,"name":"Thọ Lê Quang","email":"lequangtho2000lqtho3@gmail.com","phone_number":null,"avatar":"https://bit.ly/3kGo0rS","rank_id":1},"stylist":{"id":12,"user_id":13,"facility_id":4,"user":{"name":"Garrison Hackett","email":null,"phone_number":"+84973271212","avatar":"https://bit.ly/3kGo0rS"}},"image":[{"id":761,"link":"/upload/task/Task-01901653410301.jpg","task_id":190},{"id":762,"link":"/upload/task/Task-11901653410301.jpg","task_id":190},{"id":763,"link":"/upload/task/Task-21901653410301.jpg","task_id":190},{"id":764,"link":"/upload/task/Task-31901653410301.jpg","task_id":190}]}

class Post2 {
  Post2({
    this.id,
    this.captions,
    this.likeCount,
    this.publicAt,
    this.task,
    this.isAwarded,
  });

  Post2.fromJson(dynamic json) {
    id = json['id'];
    captions = json['captions'];
    likeCount = json['like_count'];
    publicAt = json['public_at'];
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    isAwarded = json['is_warded'];
  }

  int? id;
  String? captions;
  int? likeCount;
  int? isAwarded;
  String? publicAt;
  Task? task;

  Post2 copyWith({
    int? id,
    String? captions,
    int? likeCount,
    int? isAwarded,
    String? publicAt,
    Task? task,
  }) =>
      Post2(
        id: id ?? this.id,
        captions: captions ?? this.captions,
        likeCount: likeCount ?? this.likeCount,
        publicAt: publicAt ?? this.publicAt,
        isAwarded: isAwarded ?? this.isAwarded,
        task: task ?? this.task,
      );
}

/// id : 190
/// status : 1
/// customer : {"id":50,"name":"Thọ Lê Quang","email":"lequangtho2000lqtho3@gmail.com","phone_number":null,"avatar":"https://bit.ly/3kGo0rS","rank_id":1}
/// stylist : {"id":12,"user_id":13,"facility_id":4,"user":{"name":"Garrison Hackett","email":null,"phone_number":"+84973271212","avatar":"https://bit.ly/3kGo0rS"}}
/// image : [{"id":761,"link":"/upload/task/Task-01901653410301.jpg","task_id":190},{"id":762,"link":"/upload/task/Task-11901653410301.jpg","task_id":190},{"id":763,"link":"/upload/task/Task-21901653410301.jpg","task_id":190},{"id":764,"link":"/upload/task/Task-31901653410301.jpg","task_id":190}]

class Task {
  Task({
    this.id,
    this.status,
    this.customer,
    this.stylist,
    this.image,
  });

  Task.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    stylist = Stylist.fromJson(json['stylist']);
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageDB.fromJson(v));
      });
    }
  }

  int? id;
  int? status;
  Customer? customer;
  Stylist? stylist;
  List<ImageDB>? image;

  Task copyWith({
    int? id,
    int? status,
    Customer? customer,
    Stylist? stylist,
    List<ImageDB>? image,
  }) =>
      Task(
        id: id ?? this.id,
        status: status ?? this.status,
        customer: customer ?? this.customer,
        stylist: stylist ?? this.stylist,
        image: image ?? this.image,
      );
}

/// id : 12
/// user_id : 13
/// facility_id : 4
/// user : {"name":"Garrison Hackett","email":null,"phone_number":"+84973271212","avatar":"https://bit.ly/3kGo0rS"}

class Stylist {
  Stylist({
    this.id,
    this.userId,
    this.user,
  });

  Stylist.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? MUser.fromJson(json['user']) : null;
  }

  int? id;
  int? userId;
  MUser? user;

  Stylist copyWith({
    int? id,
    int? userId,
    int? facilityId,
    MUser? user,
  }) =>
      Stylist(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        user: user ?? this.user,
      );
}

/// id : 50
/// name : "Thọ Lê Quang"
/// email : "lequangtho2000lqtho3@gmail.com"
/// phone_number : null
/// avatar : "https://bit.ly/3kGo0rS"
/// rank_id : 1

class Customer {
  Customer({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.rankId,
  });

  Customer.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    avatar = json['avatar'];
    rankId = json['rank_id'];
  }

  int? id;
  String? name;
  String? email;
  dynamic phoneNumber;
  String? avatar;
  int? rankId;

  Customer copyWith({
    int? id,
    String? name,
    String? email,
    dynamic phoneNumber,
    String? avatar,
    int? rankId,
  }) =>
      Customer(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        avatar: avatar ?? this.avatar,
        rankId: rankId ?? this.rankId,
      );
}
