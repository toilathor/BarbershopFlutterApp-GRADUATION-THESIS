import 'package:dio/dio.dart';
import 'package:flutter_cahoi_barbershop/core/models/discount.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/services/task_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ReportTaskModel extends BaseModel {
  final _taskService = locator<TaskService>();

  Task? task;
  List<Task> tasks = [];
  List<Discount> discounts = [];

  bool isLoading = false;
  int currentPage = 1;

  changeTasks(String? searchString, {int addDay = 0, int type = 0}) async {
    if (currentPage == 0) {
      return;
    }

    isLoading = true;
    notifyListeners();

    var res = await _taskService.searchTask(
      searchString,
      page: currentPage,
      addDay: addDay,
      status: type == 0 ? null : (type == 1),
    );

    tasks += res;

    currentPage++;

    if (res.isEmpty) {
      currentPage = 0;
    }

    isLoading = false;
    notifyListeners();
  }

  changeDiscount(String? searchString) async {
    if (currentPage == 0) {
      return;
    }

    isLoading = true;
    notifyListeners();

    var res = await _taskService.getDiscounts(
      searchString,
      page: currentPage,
    );

    discounts += res;

    currentPage++;

    if (res.isEmpty) {
      currentPage = 0;
    }

    isLoading = false;
    notifyListeners();
  }

  Future changeTask({required int taskId}) async {
    var res = await _taskService.getDetailTask(taskId: taskId);
    if (res == null) {
      Fluttertoast.showToast(msg: 'Error');
    }
    task = res;
    notifyListeners();
  }

  Future<bool> addDiscountTask(
      {required Discount discount, int? taskId}) async {
    if (discount.id == null || taskId == null) {
      return false;
    }
    return _taskService.addDiscountTask(discount, taskId);
  }

  Future<bool> reportTask(
      {required List<PickedFile> images, required int taskId}) async {
    Map<String, dynamic> data = {
      "task_id": taskId,
    };

    for (int i = 0; i < images.length; i++) {
      String fileName = images[i].path.split('/').last;
      data.addAll({
        "images[$i]": await MultipartFile.fromFile(
          images[i].path,
          filename: fileName,
        )
      });
    }

    FormData formData = FormData.fromMap(data);

    return await _taskService.updateTaskStatus(data: formData);
  }

  Future<bool> removeVoucher({int? taskId, int? discountId}) async {
    if (taskId == null || discountId == null) {
      return false;
    } else {
      return await _taskService.removeVoucher(taskId, discountId);
    }
  }

  void changeIsLoading() {
    isLoading = true;
    notifyListeners();
  }

  void resetData() {
    isLoading = false;
    currentPage = 1;
    tasks.clear();
    discounts.clear();
    notifyListeners();
  }
}
