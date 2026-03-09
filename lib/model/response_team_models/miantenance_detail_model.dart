import 'dart:convert';

MaintenanceDetail maintenanceDetailFromJson(String str) =>
    MaintenanceDetail.fromJson(json.decode(str));

String maintenanceDetailToJson(MaintenanceDetail data) =>
    json.encode(data.toJson());

class MaintenanceDetail {
  bool? success;
  String? message;
  Data? data;

  MaintenanceDetail({
    this.success,
    this.message,
    this.data,
  });

  factory MaintenanceDetail.fromJson(Map<String, dynamic> json) =>
      MaintenanceDetail(
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
  SavedData? savedData;

  Data({
    this.savedData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        savedData: json["Saved Data"] == null
            ? null
            : SavedData.fromJson(json["Saved Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Saved Data": savedData?.toJson(),
      };
}

class SavedData {
  dynamic machineId;
  int? userId;
  String? issueCodes;
  String? maintenenceStatus;
  String? statusRemarks;
  int? maintenenceCount;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  SavedData({
    this.machineId,
    this.userId,
    this.issueCodes,
    this.maintenenceStatus,
    this.statusRemarks,
    this.maintenenceCount,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory SavedData.fromJson(Map<String, dynamic> json) => SavedData(
        machineId: json["machine_id"],
        userId: json["user_id"],
        issueCodes: json["issue_codes"],
        maintenenceStatus: json["maintenence_status"],
        statusRemarks: json["status_remarks"],
        maintenenceCount: json["maintenence_count"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "machine_id": machineId,
        "user_id": userId,
        "issue_codes": issueCodes,
        "maintenence_status": maintenenceStatus,
        "status_remarks": statusRemarks,
        "maintenence_count": maintenenceCount,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
