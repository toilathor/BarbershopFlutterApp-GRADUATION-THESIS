import 'package:flutter_cahoi_barbershop/core/models/facility.dart';
import 'package:flutter_cahoi_barbershop/core/models/user.dart';
import 'package:flutter_cahoi_barbershop/core/services/booking_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/role_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/user_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HRModel extends BaseModel {
  final _userService = locator<UserService>();
  final _roleService = locator<RoleService>();
  final _facilityService = locator<BookingService>();

  List<MUser> users = [];
  List<Roles> roles = [];
  List<Facility> facilities = [];
  Facility? currentFacility;
  bool isLoading = false;
  int currentPage = 1;

  Future changeUsers(String? searchString) async {
    if (currentPage == 0) {
      return;
    }

    isLoading = true;
    notifyListeners();

    var res = await _userService.searchUser(searchString, page: currentPage);

    users += res;

    currentPage++;

    if (res.isEmpty) {
      currentPage = 0;
    }

    isLoading = false;
    notifyListeners();
  }

  Future changeRoles() async {
    var res = await _roleService.getRoles();

    if (res.isNotEmpty) {
      roles = res;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Error!');
    }
  }

  Future changeFacilities() async {
    var res = await _facilityService.getFacility();

    if (res.isNotEmpty) {
      facilities = res;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: 'Error!');
    }
  }

  void resetData() {
    isLoading = false;
    currentPage = 1;
    users.clear();
    notifyListeners();
  }

  void changeIsLoading() {
    isLoading = true;
    notifyListeners();
  }

  Future<bool> syncRoleForUser(
      {required MUser user, required Roles role, Facility? facility}) async {
    if (user.id == null || role.name == null) {
      return false;
    }
    var res = await _roleService.syncRole(
        userId: user.id!, roleName: role.name!, facilityId: facility?.id);

    return res;
  }

  Future findFacility({required MUser user}) async {
    currentFacility = await _facilityService.findFacility(userId: user.id ?? 0);
    if (currentFacility != null) {
      currentFacility = facilities.firstWhere(
        (element) => element.id == currentFacility!.id,
      );
    }else{
      currentFacility = facilities.first;
    }
    notifyListeners();
  }
}
