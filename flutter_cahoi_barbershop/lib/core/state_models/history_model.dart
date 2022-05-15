import 'package:flutter_cahoi_barbershop/core/models/task.dart';
import 'package:flutter_cahoi_barbershop/core/services/post_service.dart';
import 'package:flutter_cahoi_barbershop/core/services/task_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class HistoryModel extends BaseModel {
  final _taskService = locator<TaskService>();
  final _postService = locator<PostService>();

  List<Task> tasks = [];
  int currentPage = 1;
  bool isLoading = false;

  Future changeTasksHistory() async {
    if (currentPage == 0) {
      return;
    }

    isLoading = true;
    notifyListeners();

    var res = await _taskService.getTaskHistory(page: currentPage);
    currentPage++;
    if (res.isEmpty) {
      currentPage = 0;
    }
    tasks += res;
    isLoading = false;
    notifyListeners();
  }

  Future<bool> sharePost({required Task task, String caption = ''}) async {
    return await _postService.sharePost(
      taskId: task.id ?? 0,
      caption: caption.isNotEmpty ? caption : null,
    );
  }
}
