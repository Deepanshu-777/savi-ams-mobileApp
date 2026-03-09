import 'dart:convert';

GetVendorList getVendorListFromJson(String str) =>
    GetVendorList.fromJson(json.decode(str));

String getVendorListToJson(GetVendorList data) => json.encode(data.toJson());

class GetVendorList {
  bool? success;
  String? message;
  Data? data;

  GetVendorList({
    this.success,
    this.message,
    this.data,
  });

  factory GetVendorList.fromJson(Map<String, dynamic> json) => GetVendorList(
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
  List<VendorList>? vendorList;

  Data({
    this.vendorList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        vendorList: json["Vendor List"] == null
            ? []
            : List<VendorList>.from(
                json["Vendor List"]!.map((x) => VendorList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Vendor List": vendorList == null
            ? []
            : List<dynamic>.from(vendorList!.map((x) => x.toJson())),
      };
}

class VendorList {
  int? id;
  String? vendorName;
  String? phoneNumber;
  String? email;
  String? location;

  VendorList({
    this.id,
    this.vendorName,
    this.phoneNumber,
    this.email,
    this.location,
  });

  factory VendorList.fromJson(Map<String, dynamic> json) => VendorList(
        id: json["id"],
        vendorName: json["vendor_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_name": vendorName,
        "phone_number": phoneNumber,
        "email": email,
        "location": location,
      };
}
