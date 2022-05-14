class Product {
  int id;
  String name;
  dynamic price;
  int duration;
  String shortDescription;
  String fullDescription;
  int typeProductId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.shortDescription,
    required this.fullDescription,
    required this.typeProductId,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as dynamic,
      duration: json['duration'] as int,
      shortDescription: json['sort_description'] as String,
      fullDescription: json['description'] as String,
      typeProductId: json['type_product_id'] as int,
    );

