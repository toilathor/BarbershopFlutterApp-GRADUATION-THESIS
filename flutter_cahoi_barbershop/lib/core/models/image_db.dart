/// id : 39
/// link : "/upload/task/Task-0801652541209.jpg"
/// task_id : 80

class ImageDB {
  ImageDB({
    this.id,
    this.link,
    this.taskId,
  });

  ImageDB.fromJson(dynamic json) {
    id = json['id'];
    link = json['link'];
    taskId = json['task_id'];
  }

  int? id;
  String? link;
  int? taskId;

  ImageDB copyWith({
    int? id,
    String? link,
    int? taskId,
  }) =>
      ImageDB(
        id: id ?? this.id,
        link: link ?? this.link,
        taskId: taskId ?? this.taskId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['link'] = link;
    map['task_id'] = taskId;
    return map;
  }
}
