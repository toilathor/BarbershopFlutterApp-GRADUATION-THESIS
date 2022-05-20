/// id : 1
/// total : 7.11
/// task_id : 80
/// discount_id : null

class Bill {
  Bill({
    this.id,
    this.total,
    this.taskId,
    this.discountId,
  });

  Bill.fromJson(dynamic json) {
    id = json['id'];
    total = json['total'];
    taskId = json['task_id'];
    discountId = json['discount_id'];
  }

  int? id;
  dynamic total;
  int? taskId;
  dynamic discountId;

  Bill copyWith({
    int? id,
    dynamic total,
    int? taskId,
    dynamic discountId,
  }) =>
      Bill(
        id: id ?? this.id,
        total: total ?? this.total,
        taskId: taskId ?? this.taskId,
        discountId: discountId ?? this.discountId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['total'] = total;
    map['task_id'] = taskId;
    map['discount_id'] = discountId;
    return map;
  }
}
