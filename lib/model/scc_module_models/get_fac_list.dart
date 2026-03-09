import 'dart:convert';

GetFacList getFacListFromJson(String str) =>
    GetFacList.fromJson(json.decode(str));

String getFacListToJson(GetFacList data) => json.encode(data.toJson());

class GetFacList {
  bool? success;
  String? message;
  Data? data;

  GetFacList({
    this.success,
    this.message,
    this.data,
  });

  factory GetFacList.fromJson(Map<String, dynamic> json) => GetFacList(
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
  List<FacList>? facList;

  Data({
    this.facList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        facList: json["Fund Allocation Code List"] == null
            ? []
            : List<FacList>.from(
                json["Fund Allocation Code List"]!.map((x) => FacList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Fund Allocation Code List": facList == null
            ? []
            : List<dynamic>.from(facList!.map((x) => x.toJson())),
      };
}

class FacList {
  int? id;
  String? name;

  FacList({
    this.id,
    this.name,
  });

  factory FacList.fromJson(Map<String, dynamic> json) => FacList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
