import 'dart:convert';

ProfileDetails profileDetailsFromJson(String str) =>
    ProfileDetails.fromJson(json.decode(str));

String profileDetailsToJson(ProfileDetails data) => json.encode(data.toJson());

class ProfileDetails {
  bool? success;
  String? message;
  Data? data;

  ProfileDetails({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileDetails.fromJson(Map<String, dynamic> json) => ProfileDetails(
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
  UserData? userData;

  Data({
    this.userData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: json["User Data"] == null
            ? null
            : UserData.fromJson(json["User Data"]),
      );

  Map<String, dynamic> toJson() => {
        "User Data": userData?.toJson(),
      };
}

class UserData {
  int? id;
  String? roleId;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  int? phone;
  int? status;
  String? department;
  String? profilePicture;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;

  UserData({
    this.id,
    this.roleId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.phone,
    this.status,
    this.department,
    this.profilePicture,
    this.createdAt,
    this.updatedAt,
    this.role,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        phone: json["phone"],
        status: json["status"],
        department: json["department"],
        profilePicture: json["profile_picture"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "phone": phone,
        "status": status,
        "department": department,
        "profile_picture": profilePicture,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role,
      };
}
