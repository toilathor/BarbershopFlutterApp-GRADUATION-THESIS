class Product {
  int id;
  String name;
  String image;
  dynamic price;
  int duration;
  String sortDescription;
  String fullDescription;
  int status;
  int typeProductId;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.sortDescription,
    required this.fullDescription,
    required this.typeProductId,
    required this.status,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
  id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as dynamic,
      duration: json['duration'],
      sortDescription: json['sort_description'] as String,
      fullDescription: json['description'] as String,
      typeProductId: json['type_product_id'] as int,
      image: json['image'] as String,
      status: json['status'] as int,
    );
