import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class RoleService {
  final Api _api = locator<Api>();

  Future<List<Roles>> getRoles() async {
    var res = await _api.getRoles();

    if (res != null) {
      return List<Roles>.from(
        res.data.map(
          (e) => Roles.fromJson(e),
        ),
      );
    }

    return [];
  }

  Future<bool> syncRole({required int userId, required String roleName, int? facilityId}) async {
    Map<String, dynamic> data =  {
      "user_id": userId,
      "role_name": roleName,
    };

    if(facilityId!= null){
      data['facility_id'] = facilityId;
    }

    var res = await _api.syncRole(data: data);
    if(res != null){
      return res.data;
    }
    return false;
  }
}
