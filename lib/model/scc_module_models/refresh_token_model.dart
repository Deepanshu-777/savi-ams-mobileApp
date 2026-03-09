import 'dart:convert';

RefreshTokenModel refreshTokenModelFromJson(String str) =>
    RefreshTokenModel.fromJson(json.decode(str));

String refreshTokenModelToJson(RefreshTokenModel data) =>
    json.encode(data.toJson());

class RefreshTokenModel {
  bool? success;
  String? message;
  Response? response;

  RefreshTokenModel({
    this.success,
    this.message,
    this.response,
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      RefreshTokenModel(
        success: json["success"],
        message: json["message"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "response": response?.toJson(),
      };
}

class Response {
  String? token;

  Response({
    this.token,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
