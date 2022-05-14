import 'package:dio/dio.dart';
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

  bool isLoading = false;
  int currentPage = 1;

  changeTasksToday(String? searchString) async {
    if (currentPage == 0) {
      return;
    }

    isLoading = true;
    notifyListeners();

    var res = await _taskService.searchTask(searchString, page: currentPage);

    tasks += res;

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

  Future reportTask({required List<PickedFile> images}) async {
    Map<String, dynamic> data = {
      "task_id": 1,
    };

    for (int i = 0; i < images.length; i++) {
      String fileName = images[i].path.split('/').last;
      data.addAll({
        "images[$i]": await MultipartFile.fromFile(
          images[0].path,
          filename: fileName,
        )
      });
    }

    FormData formData = FormData.fromMap(data);

    _taskService.updateTaskStatus(data: formData);
  }

  void changeIsLoading() {
    isLoading = true;
    notifyListeners();
  }

  void resetData() {
    isLoading = false;
    currentPage = 1;
    tasks.clear();
    notifyListeners();
  }
}
