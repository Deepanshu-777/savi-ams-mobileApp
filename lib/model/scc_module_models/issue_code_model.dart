import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

IssueCodeModel issueCodeModelFromJson(String str) =>
    IssueCodeModel.fromJson(json.decode(str));

String issueCodeModelToJson(IssueCodeModel data) => json.encode(data.toJson());

class IssueCodeModel {
  bool? success;
  String? message;
  Data? data;

  IssueCodeModel({
    this.success,
    this.message,
    this.data,
  });

  factory IssueCodeModel.fromJson(Map<String, dynamic> json) => IssueCodeModel(
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
  List<IssueCodeList>? issueCodeList;

  Data({
    this.issueCodeList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        issueCodeList: json["Issue Code List"] == null
            ? []
            : List<IssueCodeList>.from(
                json["Issue Code List"]!.map((x) => IssueCodeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Issue Code List": issueCodeList == null
            ? []
            : List<dynamic>.from(issueCodeList!.map((x) => x.toJson())),
      };
}

class IssueCodeList {
  int? id;
  String? partName;
  String? issueCode;
  String? description;
  RxInt? isSelected = 2.obs;
  TextEditingController? controller;

  IssueCodeList({
    this.id,
    this.partName,
    this.issueCode,
    this.description,
    this.isSelected,
    this.controller,
  });

  factory IssueCodeList.fromJson(Map<String, dynamic> json) => IssueCodeList(
        id: json["id"],
        partName: json["part_name"],
        issueCode: json["issue_code"],
        description: json["description"],
        isSelected: 2.obs,
        controller: TextEditingController(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "part_name": partName,
        "issue_code": issueCode,
        "description": description,
        "is_selected": isSelected,
      };
}
