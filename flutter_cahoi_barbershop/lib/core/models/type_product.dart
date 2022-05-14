class TypeProduct {
  int id;
  String name;

  TypeProduct({
    required this.id,
    required this.name,
  });

  factory TypeProduct.fromJson(Map<String, dynamic> json) =>
      _$TypeProductFromJson(json);
}

TypeProduct _$TypeProductFromJson(Map<String, dynamic> json) => TypeProduct(
      id: json['id'] as int,
      name: json['name'] as String,
    );
