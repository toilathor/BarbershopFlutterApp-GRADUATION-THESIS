/// avg_communication_rate : "3.2"
/// avg_skill_rate : "4.4"

class Rating {
  Rating({
    String? avgCommunicationRate,
    String? avgSkillRate,
  }) {
    _avgCommunicationRate = avgCommunicationRate;
    _avgSkillRate = avgSkillRate;
  }

  Rating.fromJson(dynamic json) {
    _avgCommunicationRate = json['avg_communication_rate'];
    _avgSkillRate = json['avg_skill_rate'];
  }

  String? _avgCommunicationRate;
  String? _avgSkillRate;

  Rating copyWith({
    String? avgCommunicationRate,
    String? avgSkillRate,
  }) =>
      Rating(
        avgCommunicationRate: avgCommunicationRate ?? _avgCommunicationRate,
        avgSkillRate: avgSkillRate ?? _avgSkillRate,
      );

  String? get avgCommunicationRate => _avgCommunicationRate;

  String? get avgSkillRate => _avgSkillRate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avg_communication_rate'] = _avgCommunicationRate;
    map['avg_skill_rate'] = _avgSkillRate;
    return map;
  }
}
