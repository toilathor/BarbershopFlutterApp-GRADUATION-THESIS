import 'package:flutter_cahoi_barbershop/core/models/task.dart';

/// id : 2
/// captions : "hello"
/// like_count : 0
/// public_at : "2022-05-13 02:07:41"
/// deleted_at : null
/// task_id : 79

class Post {
  Post({
    this.id,
    this.captions,
    this.likeCount,
    this.publicAt,
    this.deletedAt,
    this.taskId,
    this.task,
  });

  Post.fromJson(dynamic json) {
    id = json['id'];
    captions = json['captions'];
    likeCount = json['like_count'];
    publicAt = json['public_at'];
    deletedAt = json['deleted_at'];
    taskId = json['task_id'];
    if(json['task'] != null){
      task = Task.fromJson(json['task']);
    }
  }

  int? id;
  String? captions;
  int? likeCount;
  String? publicAt;
  dynamic deletedAt;
  int? taskId;
  Task? task;

  Post copyWith({
    int? id,
    String? captions,
    int? likeCount,
    String? publicAt,
    dynamic deletedAt,
    int? taskId,
    Task? task,
  }) =>
      Post(
        id: id ?? this.id,
        captions: captions ?? this.captions,
        likeCount: likeCount ?? this.likeCount,
        publicAt: publicAt ?? this.publicAt,
        deletedAt: deletedAt ?? this.deletedAt,
        taskId: taskId ?? this.taskId,
        task: task ?? this.task,
      );
}
