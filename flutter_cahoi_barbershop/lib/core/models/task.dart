import 'package:flutter_cahoi_barbershop/core/models/bill.dart';
import 'package:flutter_cahoi_barbershop/core/models/image_db.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/models/time_slot.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';

/// id : 80
/// status : 1
/// notes : "cắt đẹp cho anh"
/// date : "2022-05-14"
/// customer_id : 102
/// stylist_id : 53
/// time_slot_id : 2
/// image : [{"id":39,"link":"/upload/task/Task-0801652541209.jpg","task_id":80}]
/// products : [{"id":23,"name":"Vel consequuntur velit ratione doloribus.","duration":170,"price":9,"sort_description":"Ex est mollitia porro tenetur voluptate qui sit.","description":"Ab qui sint qui ratione est. Ut voluptas vitae non ratione occaecati. Eum autem pariatur aut sit iste ea est voluptatum.","type_product_id":4,"pivot":{"task_id":80,"product_id":23}}]
/// time : {"id":2,"time":"08:30:00"}
/// stylist : {"id":53,"user_id":103,"facility_id":5,"facility":{"id":5,"address":"1062 Kovacek Rest","description":null,"longitude":105.469448,"latitude":20.384227,"image":null}}
/// bill : {"id":1,"total":7.11,"task_id":80,"discount_id":null}

class Task {
  Task({
    this.id,
    this.status,
    this.notes,
    this.date,
    this.customerId,
    this.stylistId,
    this.timeSlotId,
    this.image,
    this.products,
    this.time,
    this.stylist,
    this.bill,
    this.customer,
  });

  Task.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    notes = json['notes'];
    date = json['date'];
    customerId = json['customer_id'];
    stylistId = json['stylist_id'];
    timeSlotId = json['time_slot_id'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageDB.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
    time = json['time'] != null ? TimeSlot.fromJson(json['time']) : null;
    stylist = json['stylist']!= null ? Stylist.fromJson(json['stylist']) : null;
    bill = json['bill'] != null ? Bill.fromJson(json['bill']) : null;
    customer =
        json['customer'] != null ? MUser.fromJson(json['customer']) : null;
  }

  int? id;
  int? status;
  String? notes;
  String? date;
  int? customerId;
  int? stylistId;
  int? timeSlotId;
  List<ImageDB>? image;
  List<Product>? products;
  TimeSlot? time;
  Stylist? stylist;
  Bill? bill;
  MUser? customer;

  Task copyWith({
    int? id,
    int? status,
    String? notes,
    String? date,
    int? customerId,
    int? stylistId,
    int? timeSlotId,
    List<ImageDB>? image,
    List<Product>? products,
    TimeSlot? time,
    Stylist? stylist,
    Bill? bill,
    MUser? customer,
  }) =>
      Task(
        id: id ?? this.id,
        status: status ?? this.status,
        notes: notes ?? this.notes,
        date: date ?? this.date,
        customerId: customerId ?? this.customerId,
        stylistId: stylistId ?? this.stylistId,
        timeSlotId: timeSlotId ?? this.timeSlotId,
        image: image ?? this.image,
        products: products ?? this.products,
        time: time ?? this.time,
        stylist: stylist ?? this.stylist,
        bill: bill ?? this.bill,
        customer: customer ?? this.customer,
      );
}
