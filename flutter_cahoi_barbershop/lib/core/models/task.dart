import 'package:flutter_cahoi_barbershop/core/models/discount.dart';
import 'package:flutter_cahoi_barbershop/core/models/image_db.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/core/models/stylist.dart';
import 'package:flutter_cahoi_barbershop/core/models/time_slot.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';

/// id : 192
/// status : 1
/// notes : ""
/// date : "2022-06-19"
/// customer_id : 31
/// stylist_id : 2
/// time_slot_id : 1
/// customer : {"id":31,"name":"Mr. Timmy Terry","email":null,"phone_number":"+84973271230","provider_id":null,"type_provider":null,"email_verified_at":null,"status":1,"points":0,"remember_token":null,"avatar":null,"rank_id":1}
/// products : [{"id":1,"name":"ShineCombo cắt gội 10 bước","duration":45,"price":120,"sort_description":"Đặc sắc nổi tiếng","description":"Combo “đặc sản” của 30Shine, bạn sẽ cùng chúng tôi trải nghiệm chuyến hành trình tỏa sáng đầy thú vị - nơi mỗi người đàn ông không chỉ cắt tóc mà còn tìm thấy nhiều hơn như thế","image":"/upload/products/Cắt_gội_massage/ShineCombo_cắt_gội_10_bước.jpg","status":1}]
/// image : [{"id":759,"link":"/upload/task/Task-01921655552310.jpg","task_id":192},{"id":760,"link":"/upload/task/Task-11921655552310.jpg","task_id":192}]
/// discount : [{"id":1,"code":"0","name":"Autem aut sed non.","description":"Eligendi expedita itaque ullam dicta. Tempore doloribus labore voluptates suscipit. Reprehenderit beatae dolor eum.","is_public":1,"reduction":0.1,"pivot":{"task_id":192,"discount_id":1}}]
/// time : {"id":1,"time":"08:00:00"}

class Task {
  Task({
    this.id,
    this.status,
    this.notes,
    this.date,
    this.customerId,
    this.stylistId,
    this.timeSlotId,
    this.customer,
    this.products,
    this.image,
    this.discount,
    this.time,
    this.stylist,
  });

  Task.fromJson(dynamic json) {
    id = json['id'];
    status = json['status'];
    notes = json['notes'];
    date = json['date'];
    customerId = json['customer_id'];
    stylistId = json['stylist_id'];
    timeSlotId = json['time_slot_id'];
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
        image?.add(ImageDB.fromJson(v));
      });
    }
    if (json['discount'] != null) {
      discount = [];
      json['discount'].forEach((v) {
        discount?.add(Discount.fromJson(v));
      });
    }
    time = json['time'] != null ? TimeSlot.fromJson(json['time']) : null;
    stylist =
        json['stylist'] != null ? Stylist.fromJson(json['stylist']) : null;
  }

  int? id;
  int? status;
  String? notes;
  String? date;
  int? customerId;
  int? stylistId;
  int? timeSlotId;
  MUser? customer;
  List<Product>? products;
  List<ImageDB>? image;
  List<Discount>? discount;
  TimeSlot? time;
  Stylist? stylist;

  Task copyWith({
    int? id,
    int? status,
    String? notes,
    String? date,
    int? customerId,
    int? stylistId,
    int? timeSlotId,
    MUser? customer,
    List<Product>? products,
    List<ImageDB>? image,
    List<Discount>? discount,
    TimeSlot? time,
    Stylist? stylist,
  }) =>
      Task(
        id: id ?? this.id,
        status: status ?? this.status,
        notes: notes ?? this.notes,
        date: date ?? this.date,
        customerId: customerId ?? this.customerId,
        stylistId: stylistId ?? this.stylistId,
        timeSlotId: timeSlotId ?? this.timeSlotId,
        customer: customer ?? this.customer,
        products: products ?? this.products,
        image: image ?? this.image,
        discount: discount ?? this.discount,
        time: time ?? this.time,
        stylist: stylist ?? this.stylist,
      );
}
