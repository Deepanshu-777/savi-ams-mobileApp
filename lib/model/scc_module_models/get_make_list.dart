import 'dart:convert';

GetMakeList getMakeListFromJson(String str) =>
    GetMakeList.fromJson(json.decode(str));

String getMakeListToJson(GetMakeList data) => json.encode(data.toJson());

class GetMakeList {
  bool? success;
  String? message;
  Data? data;

  GetMakeList({
    this.success,
    this.message,
    this.data,
  });

  factory GetMakeList.fromJson(Map<String, dynamic> json) => GetMakeList(
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
  List<MakeList>? makeList;

  Data({
    this.makeList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        makeList: json["Make List"] == null
            ? []
            : List<MakeList>.from(
                json["Make List"]!.map((x) => MakeList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Make List": makeList == null
            ? []
            : List<dynamic>.from(makeList!.map((x) => x.toJson())),
      };
}

class MakeList {
  int? id;
  String? name;

  MakeList({
    this.id,
    this.name,
  });

  factory MakeList.fromJson(Map<String, dynamic> json) => MakeList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
