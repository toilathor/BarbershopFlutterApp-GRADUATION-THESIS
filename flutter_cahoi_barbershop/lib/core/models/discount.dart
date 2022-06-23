/// id : 1
/// code : "0"
/// name : "Autem aut sed non."
/// description : "Eligendi expedita itaque ullam dicta. Tempore doloribus labore voluptates suscipit. Reprehenderit beatae dolor eum."
/// is_public : 1
/// reduction : 0.1
/// pivot : {"task_id":192,"discount_id":1}

class Discount {
  Discount({
    this.id,
    this.code,
    this.name,
    this.description,
    this.isPublic,
    this.reduction,
  });

  Discount.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    isPublic = json['is_public'];
    reduction = json['reduction'];
  }

  int? id;
  String? code;
  String? name;
  String? description;
  int? isPublic;
  double? reduction;

  Discount copyWith({
    int? id,
    String? code,
    String? name,
    String? description,
    int? isPublic,
    double? reduction,
  }) =>
      Discount(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        description: description ?? this.description,
        isPublic: isPublic ?? this.isPublic,
        reduction: reduction ?? this.reduction,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['code'] = code;
    map['name'] = name;
    map['description'] = description;
    map['is_public'] = isPublic;
    map['reduction'] = reduction;
    return map;
  }
}
