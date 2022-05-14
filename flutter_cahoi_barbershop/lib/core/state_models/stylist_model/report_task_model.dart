import 'package:dio/dio.dart';
import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/services/task_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:image_picker/image_picker.dart';

class ReportTaskModel extends BaseModel {
  final _taskService = locator<TaskService>();
  Task? task;

  Future changeTask({required int taskId}) async {
    var res = await _taskService.getDetailTask(taskId: taskId);
  }

  Future reportTask({required List<PickedFile> images}) async {
    print('report task');
    return;
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
}
