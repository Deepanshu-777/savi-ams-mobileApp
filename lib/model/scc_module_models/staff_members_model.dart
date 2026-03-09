// To parse this JSON data, do
//
//     final staffMembersModel = staffMembersModelFromJson(jsonString);

import 'dart:convert';

StaffMembersModel staffMembersModelFromJson(String str) =>
    StaffMembersModel.fromJson(json.decode(str));

String staffMembersModelToJson(StaffMembersModel data) =>
    json.encode(data.toJson());

class StaffMembersModel {
  bool? success;
  String? message;
  Data? data;

  StaffMembersModel({
    this.success,
    this.message,
    this.data,
  });

  factory StaffMembersModel.fromJson(Map<String, dynamic> json) =>
      StaffMembersModel(
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
  List<StaffMemberList>? staffMemberList;

  Data({
    this.staffMemberList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        staffMemberList: json["Staff Member List"] == null
            ? []
            : List<StaffMemberList>.from(json["Staff Member List"]!
                .map((x) => StaffMemberList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Staff Member List": staffMemberList == null
            ? []
            : List<dynamic>.from(staffMemberList!.map((x) => x.toJson())),
      };
}

class StaffMemberList {
  String? empId;
  String? name;
  String? designation;

  StaffMemberList({
    this.empId,
    this.name,
    this.designation,
  });

  factory StaffMemberList.fromJson(Map<String, dynamic> json) =>
      StaffMemberList(
        empId: json["emp_id"],
        name: json["name"],
        designation: json["designation"],
      );

  Map<String, dynamic> toJson() => {
        "emp_id": empId,
        "name": name,
        "designation": designation,
      };
}
