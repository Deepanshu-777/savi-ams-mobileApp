import 'dart:convert';

ShopListModel shopListModelFromJson(String str) =>
    ShopListModel.fromJson(json.decode(str));

String shopListModelToJson(ShopListModel data) => json.encode(data.toJson());

class ShopListModel {
  bool? success;
  String? message;
  Data? data;

  ShopListModel({
    this.success,
    this.message,
    this.data,
  });

  factory ShopListModel.fromJson(Map<String, dynamic> json) => ShopListModel(
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
  List<ShopList>? shopList;

  Data({
    this.shopList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        shopList: json["Shop List"] == null
            ? []
            : List<ShopList>.from(
                json["Shop List"]!.map((x) => ShopList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Shop List": shopList == null
            ? []
            : List<dynamic>.from(shopList!.map((x) => x.toJson())),
      };
}

class ShopList {
  int? id;
  String? name;
  num? machineCount;

  ShopList({
    this.id,
    this.name,
    this.machineCount,
  });

  factory ShopList.fromJson(Map<String, dynamic> json) => ShopList(
        id: json["id"],
        name: json["name"],
        machineCount: json["machine_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "machine_count": machineCount,
      };
}
