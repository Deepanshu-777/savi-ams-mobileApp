// To parse this JSON data, do
//
//     final designationModel = designationModelFromJson(jsonString);

import 'dart:convert';

DesignationModel designationModelFromJson(String str) =>
    DesignationModel.fromJson(json.decode(str));

String designationModelToJson(DesignationModel data) =>
    json.encode(data.toJson());

class DesignationModel {
  bool success;
  String message;
  Data data;

  DesignationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DesignationModel.fromJson(Map<String, dynamic> json) =>
      DesignationModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<DesignationList> designationList;

  Data({
    required this.designationList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        designationList: List<DesignationList>.from(
            json["Designation List"].map((x) => DesignationList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Designation List":
            List<dynamic>.from(designationList.map((x) => x.toJson())),
      };
}

class DesignationList {
  int id;
  String name;
  int status;

  DesignationList({
    required this.id,
    required this.name,
    required this.status,
  });

  factory DesignationList.fromJson(Map<String, dynamic> json) =>
      DesignationList(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
