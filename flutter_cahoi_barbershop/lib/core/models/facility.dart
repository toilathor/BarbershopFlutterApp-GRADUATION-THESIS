/// id : 6
/// address : "148 Dach Square Suite 887"
/// description : null
/// longitude : 105.17
/// latitude : 20.3512
/// image : null

class Facility {
  Facility({
    int? id,
    String? address,
    String? description,
    double? longitude,
    double? latitude,
    String? image,
  }) {
    _id = id;
    _address = address;
    _description = description;
    _longitude = longitude;
    _latitude = latitude;
    _image = image;
  }

  Facility.fromJson(dynamic json) {
    _id = json['id'];
    _address = json['address'];
    _description = json['description'];
    _longitude = json['longitude'];
    _latitude = json['latitude'];
    _image = json['image'];
  }

  int? _id;
  String? _address;
  dynamic _description;
  double? _longitude;
  double? _latitude;
  dynamic _image;

  Facility copyWith({
    int? id,
    String? address,
    dynamic description,
    double? longitude,
    double? latitude,
    dynamic image,
  }) =>
      Facility(
        id: id ?? _id,
        address: address ?? _address,
        description: description ?? _description,
        longitude: longitude ?? _longitude,
        latitude: latitude ?? _latitude,
        image: image ?? _image,
      );

  int? get id => _id;

  String? get address => _address;

  dynamic get description => _description;

  double? get longitude => _longitude;

  double? get latitude => _latitude;

  dynamic get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['address'] = _address;
    map['description'] = _description;
    map['longitude'] = _longitude;
    map['latitude'] = _latitude;
    map['image'] = _image;
    return map;
  }
}
