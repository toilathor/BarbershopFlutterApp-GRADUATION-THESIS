import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Response {
  @JsonKey(name: 'success')
  bool success;
  @JsonKey(name: 'errorCode')
  int errorCode;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'data')
  dynamic data;

  Response(
      {required this.success,
      required this.errorCode,
      required this.message,
      required this.data});

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}

Response _$ResponseFromJson(Map<String, dynamic> json) {
  return Response(
      success: json['success'],
      errorCode: json['errorCode'],
      message: json['message'],
      data: json['data']);
}

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'success': instance.success,
      'errorCode': instance.errorCode,
      'message': instance.message,
      'data': instance.data,
    };
