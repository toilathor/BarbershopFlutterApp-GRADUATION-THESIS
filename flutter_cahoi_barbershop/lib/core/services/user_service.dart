import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class UserService {
  final Api _api = locator<Api>();

  Future<List<MUser>> searchUser(String? searchString, {required int page}) async {
    Map<String, dynamic> data = {
      "page" : page
    };
    if(searchString != null){
      data["search_string"] = searchString;
    }

    var res = await _api.searchUser(data);

    if (res != null) {
      return List<MUser>.from(res.data.map((i) => MUser.fromJson(i)).toList());
    }

    return [];
  }
}
