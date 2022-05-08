import 'package:admin/core/apis/base_api.dart';
import 'package:admin/core/apis/response.dart' as apiRes;

/// The service responsible for networking requests
class Api extends ApiBase {
  Api() {
    super.baseAPI();
  }

  //Auth
  Future<apiRes.Response?> loginWithAccount(
      {required String email, required String password}) async {
    try {
      var res =
          await dio.post('/#', data: {"email": email, "password": password});
      return castRes(res);
    } catch (e) {
      return null;
    }
  }
}
