import 'dart:convert';

GetCategoryList getCategoryListFromJson(String str) =>
    GetCategoryList.fromJson(json.decode(str));

String getCategoryListToJson(GetCategoryList data) =>
    json.encode(data.toJson());

class GetCategoryList {
  bool? success;
  String? message;
  Data? data;

  GetCategoryList({
    this.success,
    this.message,
    this.data,
  });

  factory GetCategoryList.fromJson(Map<String, dynamic> json) =>
      GetCategoryList(
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
  List<CategoryList>? categoryList;

  Data({
    this.categoryList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categoryList: json["Category List"] == null
            ? []
            : List<CategoryList>.from(
                json["Category List"]!.map((x) => CategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Category List": categoryList == null
            ? []
            : List<dynamic>.from(categoryList!.map((x) => x.toJson())),
      };
}

class CategoryList {
  int? id;
  String? name;

  CategoryList({
    this.id,
    this.name,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
