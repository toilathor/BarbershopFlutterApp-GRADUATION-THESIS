class Response {
  bool? success;
  int? errorCode;
  String? message;
  dynamic data;

  Response({this.success, this.errorCode, this.message, this.data});

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
