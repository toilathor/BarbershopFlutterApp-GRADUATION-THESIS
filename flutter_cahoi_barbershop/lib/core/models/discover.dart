class Discover {
  String id;
  String name;
  String src;
  Discover({
    required this.id,
    required this.name,
    required this.src,
  });

  factory Discover.fromJson(Map<String, dynamic> json) =>
      _$DiscoverFromJson(json);

  Map<String, dynamic> toJson() => _$DiscoverToJson(this);
}
Discover _$DiscoverFromJson(Map<String, dynamic> json) => Discover(
  id: json['id'] as String,
  name: json['name'] as String,
  src: json['src'] as String,
);

Map<String, dynamic> _$DiscoverToJson(Discover instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'src': instance.src,
};
