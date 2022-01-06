import 'package:json_annotation/json_annotation.dart';

part 'discover.g.dart';

@JsonSerializable()
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
