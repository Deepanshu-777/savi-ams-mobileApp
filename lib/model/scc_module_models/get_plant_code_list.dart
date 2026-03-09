import 'dart:convert';

GetPlantCodeListModel getPlantCodeListModelFromJson(String str) =>
    GetPlantCodeListModel.fromJson(json.decode(str));

String getPlantCodeListModelToJson(GetPlantCodeListModel data) =>
    json.encode(data.toJson());

class GetPlantCodeListModel {
  bool? success;
  String? message;
  Data? data;

  GetPlantCodeListModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetPlantCodeListModel.fromJson(Map<String, dynamic> json) =>
      GetPlantCodeListModel(
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
  List<PlantsCodeList>? plantsCodeList;

  Data({
    this.plantsCodeList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        plantsCodeList: json["Plants Code List"] == null
            ? []
            : List<PlantsCodeList>.from(json["Plants Code List"]!
                .map((x) => PlantsCodeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Plants Code List": plantsCodeList == null
            ? []
            : List<dynamic>.from(plantsCodeList!.map((x) => x.toJson())),
      };
}

class PlantsCodeList {
  int? id;
  String? code;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PlantsCodeList({
    this.id,
    this.code,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PlantsCodeList.fromJson(Map<String, dynamic> json) => PlantsCodeList(
        id: json["id"],
        code: json["code"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
