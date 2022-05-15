import 'package:flutter_cahoi_barbershop/core/models/facility.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';

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
    this.facility,
  });

  Stylist.fromJson(dynamic json) {
    userId = json['user_id'];
    facilityId = json['facility_id'];
    stylistId = json['stylist_id'];
    user = json['user'] != null ? MUser.fromJson(json['user']) : null;
    facility = json['facility'] != null ? Facility.fromJson(json['facility']) : null;
  }

  int? userId;
  int? facilityId;
  int? stylistId;
  MUser? user;
  Facility? facility;

  Stylist copyWith({
    int? userId,
    int? facilityId,
    int? stylistId,
    MUser? user,
    Facility? facility,
  }) =>
      Stylist(
        userId: userId ?? this.userId,
        facilityId: facilityId ?? this.facilityId,
        stylistId: stylistId ?? this.stylistId,
        user: user ?? this.user,
        facility: facility ?? this.facility,
      );
}
