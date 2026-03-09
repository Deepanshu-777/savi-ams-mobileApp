import 'dart:convert';

GetNotificationsList getNotificationsListFromJson(String str) =>
    GetNotificationsList.fromJson(json.decode(str));

String getNotificationsListToJson(GetNotificationsList data) =>
    json.encode(data.toJson());

class GetNotificationsList {
  bool? success;
  String? message;
  Data? data;

  GetNotificationsList({
    this.success,
    this.message,
    this.data,
  });

  factory GetNotificationsList.fromJson(Map<String, dynamic> json) =>
      GetNotificationsList(
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
  List<Notification>? notifications;

  Data({
    this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: json["notifications"] == null
            ? []
            : List<Notification>.from(
                json["notifications"]!.map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notification {
  int? id;
  dynamic userId;
  String? title; // Changed from Title? to String?
  String? msgBody;
  dynamic messageTo;
  dynamic targetUrl;
  dynamic createdId;
  String? status;
  dynamic hasImage;
  String? isSentToARole;
  int? roleId;
  dynamic ipAddress;
  DateTime? createdAt;
  DateTime? updatedAt;

  Notification({
    this.id,
    this.userId,
    this.title,
    this.msgBody,
    this.messageTo,
    this.targetUrl,
    this.createdId,
    this.status,
    this.hasImage,
    this.isSentToARole,
    this.roleId,
    this.ipAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"], // Changed
        msgBody: json["msg_body"],
        messageTo: json["message_to"],
        targetUrl: json["target_url"],
        createdId: json["created_id"],
        status: json["status"],
        hasImage: json["has_image"],
        isSentToARole: json["is_sent_to_a_role"],
        roleId: json["role_id"],
        ipAddress: json["ip_address"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title, // Changed
        "msg_body": msgBody,
        "message_to": messageTo,
        "target_url": targetUrl,
        "created_id": createdId,
        "status": status,
        "has_image": hasImage,
        "is_sent_to_a_role": isSentToARole,
        "role_id": roleId,
        "ip_address": ipAddress,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
