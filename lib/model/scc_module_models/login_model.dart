import 'dart:convert';


Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  bool? success;
  String? message;
  Data? data;

  Login({
    this.success,
    this.message,
    this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
      };
}

class User {
  int? id;
  String? roleId;
  List<String>? shop;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  int? phone;
  int? status;
  int? department;
  String? profilePicture;
  int? otp;
  DateTime? otpExpiry;
  int? isDeleted;
  String? fcmToken;
  List<String>? responseTeamType;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.roleId,
    this.shop,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.status,
    this.department,
    this.profilePicture,
    this.otp,
    this.otpExpiry,
    this.isDeleted,
    this.fcmToken,
    this.responseTeamType,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        shop: json["shop"] == null
            ? []
            : List<String>.from(json["shop"].map((x) => x)),
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"],
        status: json["status"],
        department: json["department"],
        profilePicture: json["profile_picture"],
        otp: json["OTP"],
        otpExpiry: json["OTP_expiry"] == null
            ? null
            : DateTime.tryParse(json["OTP_expiry"]),
        isDeleted: json["is_deleted"],
        fcmToken: json["fcm_token"],
        responseTeamType: json["response_team_type"] == null
            ? []
            : List<String>.from(json["response_team_type"].map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.tryParse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.tryParse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "shop": shop,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "status": status,
        "department": department,
        "profile_picture": profilePicture,
        "OTP": otp,
        "OTP_expiry": otpExpiry?.toIso8601String(),
        "is_deleted": isDeleted,
        "fcm_token": fcmToken,
        "response_team_type": responseTeamType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
