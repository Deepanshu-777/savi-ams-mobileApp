import 'dart:convert';

MaintenanceListModel maintenanceListModelFromJson(String str) =>
    MaintenanceListModel.fromJson(json.decode(str));

String maintenanceListModelToJson(MaintenanceListModel data) =>
    json.encode(data.toJson());

class MaintenanceListModel {
  bool? success;
  String? message;
  Data? data;

  MaintenanceListModel({
    this.success,
    this.message,
    this.data,
  });

  factory MaintenanceListModel.fromJson(Map<String, dynamic> json) =>
      MaintenanceListModel(
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
  List<UpcomingMaintenceList>? upcomingMaintenceList;
  List<DueMaintenanceList>? dueMaintenenceList;
  List<CompletedMaintenceList>? completedMaintenceList;

  Data({
    this.upcomingMaintenceList,
    this.dueMaintenenceList,
    this.completedMaintenceList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        upcomingMaintenceList: json["Upcoming Maintence List"] == null
            ? []
            : List<UpcomingMaintenceList>.from(json["Upcoming Maintence List"]!
                .map((x) => UpcomingMaintenceList.fromJson(x))),
        dueMaintenenceList: json["Due Maintenence List"] == null
            ? []
            : List<DueMaintenanceList>.from(json["Due Maintenence List"]!
                .map((x) => DueMaintenanceList.fromJson(x))),
        completedMaintenceList: json["Completed Maintence List"] == null
            ? []
            : List<CompletedMaintenceList>.from(
                json["Completed Maintence List"]!
                    .map((x) => CompletedMaintenceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Upcoming Maintence List": upcomingMaintenceList == null
            ? []
            : List<dynamic>.from(upcomingMaintenceList!.map((x) => x.toJson())),
        "Due Maintenence List": dueMaintenenceList == null
            ? []
            : List<dynamic>.from(dueMaintenenceList!.map((x) => x.toJson())),
        "Completed Maintence List": completedMaintenceList == null
            ? []
            : List<dynamic>.from(
                completedMaintenceList!.map((x) => x.toJson())),
      };
}

class CompletedMaintenceList {
  int? id;
  int? machineId;
  int? userId;
  String? issueCodes;
  String? maintenenceStatus;
  int? maintenenceCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? maintenenceDate;
  String? maintenenceDay;
  String? maintenenceMonth;
  String? maintenenceYear;
  String? name;
  String? time;
  String? itemCode;

  CompletedMaintenceList({
    this.id,
    this.machineId,
    this.userId,
    this.issueCodes,
    this.maintenenceStatus,
    this.maintenenceCount,
    this.createdAt,
    this.updatedAt,
    this.maintenenceDate,
    this.maintenenceDay,
    this.maintenenceMonth,
    this.maintenenceYear,
    this.time,
    this.name,
    this.itemCode,
  });

  factory CompletedMaintenceList.fromJson(Map<String, dynamic> json) =>
      CompletedMaintenceList(
        id: json["id"],
        machineId: json["machine_id"],
        userId: json["user_id"],
        issueCodes: json["issue_codes"],
        maintenenceStatus: json["maintenence_status"],
        maintenenceCount: json["maintenence_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        maintenenceDate: json["maintenence_date"],
        maintenenceDay: json["maintenence_day"],
        maintenenceMonth: json["maintenence_month"],
        maintenenceYear: json["maintenence_year"],
        name: json["name"],
        time: json["maintenence_time"],
        itemCode: json["item_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "machine_id": machineId,
        "user_id": userId,
        "issue_codes": issueCodes,
        "maintenence_status": maintenenceStatus,
        "maintenence_count": maintenenceCount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "maintenence_date": maintenenceDate,
        "maintenence_day": maintenenceDay,
        "maintenence_month": maintenenceMonth,
        "maintenence_year": maintenenceYear,
        "name": name,
        "maintenence_time": time,
        "item_code": itemCode,
      };
}

class UpcomingMaintenceList {
  int? id;
  String? name;
  String? itemCode;
  DateTime? dateOfCommissioning;
  int? maintenance;
  int? maintenenceCount;
  String? upcomingMaintenceDate;
  String? upcomingMaintenenceDay;
  String? upcomingMaintenenceMonth;
  String? upcomingMaintenenceYear;

  UpcomingMaintenceList({
    this.id,
    this.name,
    this.itemCode,
    this.dateOfCommissioning,
    this.maintenance,
    this.maintenenceCount,
    this.upcomingMaintenceDate,
    this.upcomingMaintenenceDay,
    this.upcomingMaintenenceMonth,
    this.upcomingMaintenenceYear,
  });

  factory UpcomingMaintenceList.fromJson(Map<String, dynamic> json) =>
      UpcomingMaintenceList(
        id: json["id"],
        name: json["name"],
        itemCode: json["item_code"],
        dateOfCommissioning: json["date_of_commissioning"] == null
            ? null
            : DateTime.parse(json["date_of_commissioning"]),
        maintenance: json["maintenance"],
        maintenenceCount: json["maintenence_count"],
        upcomingMaintenceDate: json["upcoming_maintence_date"],
        upcomingMaintenenceDay: json["upcoming_maintenence_day"],
        upcomingMaintenenceMonth: json["upcoming_maintenence_month"],
        upcomingMaintenenceYear: json["upcoming_maintenence_year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "item_code": itemCode,
        "date_of_commissioning":
            "${dateOfCommissioning!.year.toString().padLeft(4, '0')}-${dateOfCommissioning!.month.toString().padLeft(2, '0')}-${dateOfCommissioning!.day.toString().padLeft(2, '0')}",
        "maintenance": maintenance,
        "maintenence_count": maintenenceCount,
        "upcoming_maintence_date": upcomingMaintenceDate,
        "upcoming_maintenence_day": upcomingMaintenenceDay,
        "upcoming_maintenence_month": upcomingMaintenenceMonth,
        "upcoming_maintenence_year": upcomingMaintenenceYear,
      };
}

class DueMaintenanceList {
  int? id;
  String? name;
  String? itemCode;
  DateTime? dateOfCommissioning;
  int? maintenance;
  int? maintenenceCount;
  String? upcomingMaintenceDate;
  String? upcomingMaintenenceDay;
  String? upcomingMaintenenceMonth;
  String? upcomingMaintenenceYear;

  DueMaintenanceList({
    this.id,
    this.name,
    this.itemCode,
    this.dateOfCommissioning,
    this.maintenance,
    this.maintenenceCount,
    this.upcomingMaintenceDate,
    this.upcomingMaintenenceDay,
    this.upcomingMaintenenceMonth,
    this.upcomingMaintenenceYear,
  });

  factory DueMaintenanceList.fromJson(Map<String, dynamic> json) =>
      DueMaintenanceList(
        id: json["id"],
        name: json["name"],
        itemCode: json["item_code"],
        dateOfCommissioning: json["date_of_commissioning"] == null
            ? null
            : DateTime.parse(json["date_of_commissioning"]),
        maintenance: json["maintenance"],
        maintenenceCount: json["maintenence_count"],
        upcomingMaintenceDate: json["upcoming_maintence_date"],
        upcomingMaintenenceDay: json["upcoming_maintenence_day"],
        upcomingMaintenenceMonth: json["upcoming_maintenence_month"],
        upcomingMaintenenceYear: json["upcoming_maintenence_year"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "item_code": itemCode,
        "date_of_commissioning":
            "${dateOfCommissioning!.year.toString().padLeft(4, '0')}-${dateOfCommissioning!.month.toString().padLeft(2, '0')}-${dateOfCommissioning!.day.toString().padLeft(2, '0')}",
        "maintenance": maintenance,
        "maintenence_count": maintenenceCount,
        "upcoming_maintence_date": upcomingMaintenceDate,
        "upcoming_maintenence_day": upcomingMaintenenceDay,
        "upcoming_maintenence_month": upcomingMaintenenceMonth,
        "upcoming_maintenence_year": upcomingMaintenenceYear,
      };
}
