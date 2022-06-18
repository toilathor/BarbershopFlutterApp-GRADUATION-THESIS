/// communication_rate : 5
/// skill_rate : 5
/// assessment : 5
/// secure : 5
/// checkout : 5
/// comment : ""
/// task_id : 190
/// id : 50

class Rating {
  Rating({
    this.communicationRate,
    this.skillRate,
    this.assessment,
    this.secure,
    this.checkout,
    this.comment,
    this.taskId,
    this.id,
  });

  Rating.fromJson(dynamic json) {
    communicationRate = json['communication_rate'];
    skillRate = json['skill_rate'];
    assessment = json['assessment'];
    secure = json['secure'];
    checkout = json['checkout'];
    comment = json['comment'];
    taskId = json['task_id'];
    id = json['id'];
  }

  dynamic communicationRate;
  dynamic skillRate;
  dynamic assessment;
  dynamic secure;
  dynamic checkout;
  String? comment;
  int? taskId;
  int? id;

  Rating copyWith({
    dynamic communicationRate,
    dynamic skillRate,
    dynamic assessment,
    dynamic secure,
    dynamic checkout,
    String? comment,
    int? taskId,
    int? id,
  }) =>
      Rating(
        communicationRate: communicationRate ?? this.communicationRate,
        skillRate: skillRate ?? this.skillRate,
        assessment: assessment ?? this.assessment,
        secure: secure ?? this.secure,
        checkout: checkout ?? this.checkout,
        comment: comment ?? this.comment,
        taskId: taskId ?? this.taskId,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['communication_rate'] = communicationRate;
    map['skill_rate'] = skillRate;
    map['assessment'] = assessment;
    map['secure'] = secure;
    map['checkout'] = checkout;
    map['comment'] = comment;
    map['task_id'] = taskId;
    map['id'] = id;
    return map;
  }
}
