import 'package:flutter_cahoi_barbershop/core/models/facility.dart';

/// id : 1
/// total_revenue_month : 58448
/// is_paid : 0
/// facility_id : 1
/// created_at : "2022-06-19T10:24:12.000000Z"
/// updated_at : "2022-06-19T10:24:52.000000Z"
/// facility : {"id":1,"address":"382 Nguyễn Trãi, Thanh Xuân Trung, Thanh Xuân, Hà Nội","description":"Cạnh hầm chui Thanh Xuân, bên tay phải đi theo hướng về Hà Đông","longitude":105.805761,"latitude":20.993949,"image":"/upload/facilities/382_Nguyễn_Trãi,_Thanh_Xuân_Trung,_Thanh_Xuân,_Hà_Nội.png"}

class Revenue {
  Revenue({
    this.id,
    this.totalRevenueMonth,
    this.isPaid,
    this.facilityId,
    this.createdAt,
    this.updatedAt,
    this.facility,
  });

  Revenue.fromJson(dynamic json) {
    id = json['id'];
    totalRevenueMonth = json['total_revenue_month'];
    isPaid = json['is_paid'];
    facilityId = json['facility_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    facility =
        json['facility'] != null ? Facility.fromJson(json['facility']) : null;
  }

  int? id;
  dynamic totalRevenueMonth;
  int? isPaid;
  int? facilityId;
  String? createdAt;
  String? updatedAt;
  Facility? facility;

  Revenue copyWith({
    int? id,
    dynamic totalRevenueMonth,
    int? isPaid,
    int? facilityId,
    String? createdAt,
    String? updatedAt,
    Facility? facility,
  }) =>
      Revenue(
        id: id ?? this.id,
        totalRevenueMonth: totalRevenueMonth ?? this.totalRevenueMonth,
        isPaid: isPaid ?? this.isPaid,
        facilityId: facilityId ?? this.facilityId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        facility: facility ?? this.facility,
      );
}
