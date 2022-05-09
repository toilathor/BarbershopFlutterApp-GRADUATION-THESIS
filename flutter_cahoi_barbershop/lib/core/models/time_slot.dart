/// id : 1
/// time : "08:00:00"

class TimeSlot {
  TimeSlot({
    this.id,
    this.time,
    this.isSelected = false,
  });

  TimeSlot.fromJson(dynamic json) {
    id = json['id'];
    time = json['time'];
    isSelected = json['isSelected'] ?? false;
  }

  int? id;
  String? time;
  bool? isSelected;

  TimeSlot copyWith({
    int? id,
    String? time,
  }) =>
      TimeSlot(
        id: id ?? this.id,
        time: time ?? this.time,
        isSelected: isSelected ?? false,
      );
}
