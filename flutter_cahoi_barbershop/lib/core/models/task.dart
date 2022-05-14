import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/core/models/time_slot.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';

/// id : 1
/// status : 1
/// notes : "Asperiores ut autem enim quis. Quae rem perferendis rem tempore error vero. Odio consequatur quisquam voluptate eum nihil natus. Quia doloremque esse dolorem nobis consectetur."
/// date : "2022-05-13"
/// customer : {"id":76,"name":"Shirley Halvorson","email":null,"phone_number":"(660) 318-3360","provider_id":null,"type_provider":null,"email_verified_at":null,"status":1,"points":0,"remember_token":null,"avatar":"https://bit.ly/3kGo0rS","rank_id":1}
/// products : [{"id":1,"name":"Aut harum modi rem et optio sed qui.","duration":138,"price":9,"sort_description":"Veniam enim dolorem culpa sunt.","description":"Neque quidem eaque atque culpa. Amet aut et quam. Aperiam harum quod et quas.","type_product_id":1,"pivot":{"task_id":1,"product_id":1}},{"id":8,"name":"Odio modi dolore ut temporibus est.","duration":138,"price":18,"sort_description":"Aperiam eius aliquam aut eum.","description":"Vel aperiam iusto delectus voluptate ab quod cumque qui. Facilis est autem rerum nulla consequuntur et. Laudantium eum neque est velit incidunt asperiores rem. Optio fuga saepe adipisci quod.","type_product_id":2,"pivot":{"task_id":1,"product_id":8}}]
/// image : [{"id":2,"link":"/upload/task/Task-011652442680.jpg","task_id":1},{"id":3,"link":"/upload/task/Task-011652443338.jpg","task_id":1},{"id":4,"link":"/upload/task/Task-111652443338.jpg","task_id":1}]
/// time : {"id":2,"time":"08:30:00"}

class Task {
  Task({
    this.id,
    this.status,
    this.notes,
    this.date,
    this.customer,
    this.products,
    this.image,
    this.time,
  });

  Task.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    notes = json['notes'];
    date = json['date'];
    customer =
        json['customer'] != null ? MUser.fromJson(json['customer']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageTask.fromJson(v));
      });
    }
    time = json['time'] != null ? TimeSlot.fromJson(json['time']) : null;
  }

  int? id;
  int? status;
  String? notes;
  String? date;
  MUser? customer;
  List<Product>? products;
  List<ImageTask>? image;
  TimeSlot? time;

  Task copyWith({
    int? id,
    int? status,
    String? notes,
    String? date,
    MUser? customer,
    List<Product>? products,
    List<ImageTask>? image,
    TimeSlot? time,
  }) =>
      Task(
        id: id ?? this.id,
        status: status ?? this.status,
        notes: notes ?? this.notes,
        date: date ?? this.date,
        customer: customer ?? this.customer,
        products: products ?? this.products,
        image: image ?? this.image,
        time: time ?? this.time,
      );
}

/// id : 2
/// link : "/upload/task/Task-011652442680.jpg"
/// task_id : 1

class ImageTask {
  ImageTask({
    this.id,
    this.link,
    this.taskId,
  });

  ImageTask.fromJson(dynamic json) {
    id = json['id'];
    link = json['link'];
    taskId = json['task_id'];
  }

  int? id;
  String? link;
  int? taskId;

  ImageTask copyWith({
    int? id,
    String? link,
    int? taskId,
  }) =>
      ImageTask(
        id: id ?? this.id,
        link: link ?? this.link,
        taskId: taskId ?? this.taskId,
      );
}
