// To parse this JSON data, do
//
//     final machineCondemnRequestModel = machineCondemnRequestModelFromJson(jsonString);

import 'dart:convert';

MachineCondemnRequestModel machineCondemnRequestModelFromJson(String str) =>
    MachineCondemnRequestModel.fromJson(json.decode(str));

String machineCondemnRequestModelToJson(MachineCondemnRequestModel data) =>
    json.encode(data.toJson());

class MachineCondemnRequestModel {
  bool? success;
  String? message;
  Data? data;

  MachineCondemnRequestModel({
    this.success,
    this.message,
    this.data,
  });

  factory MachineCondemnRequestModel.fromJson(Map<String, dynamic> json) =>
      MachineCondemnRequestModel(
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
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  int? id;
  int? machineId;
  String? requestType;
  int? requestRaisedBy;
  int? actionBy;
  String? status;
  dynamic supportAttachment;
  dynamic requestByRemarks;
  dynamic actionByRemarks;
  dynamic actionedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? requestRaisedById;
  String? requestRaisedByName;
  int? actionById;
  String? actionByName;
  String? createdAtFormatted;
  dynamic actionedAtFormatted;
  Machine? machine;

  Datum({
    this.id,
    this.machineId,
    this.requestType,
    this.requestRaisedBy,
    this.actionBy,
    this.status,
    this.supportAttachment,
    this.requestByRemarks,
    this.actionByRemarks,
    this.actionedAt,
    this.createdAt,
    this.updatedAt,
    this.requestRaisedById,
    this.requestRaisedByName,
    this.actionById,
    this.actionByName,
    this.createdAtFormatted,
    this.actionedAtFormatted,
    this.machine,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        machineId: json["machine_id"],
        requestType: json["request_type"],
        requestRaisedBy: json["request_raised_by"],
        actionBy: json["action_by"],
        status: json["status"],
        supportAttachment: json["support_attachment"],
        requestByRemarks: json["request_by_remarks"],
        actionByRemarks: json["action_by_remarks"],
        actionedAt: json["actioned_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        requestRaisedById: json["request_raised_by_id"],
        requestRaisedByName: json["request_raised_by_name"],
        actionById: json["action_by_id"],
        actionByName: json["action_by_name"],
        createdAtFormatted: json["created_at_formatted"],
        actionedAtFormatted: json["actioned_at_formatted"],
        machine:
            json["machine"] == null ? null : Machine.fromJson(json["machine"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "machine_id": machineId,
        "request_type": requestType,
        "request_raised_by": requestRaisedBy,
        "action_by": actionBy,
        "status": status,
        "support_attachment": supportAttachment,
        "request_by_remarks": requestByRemarks,
        "action_by_remarks": actionByRemarks,
        "actioned_at": actionedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "request_raised_by_id": requestRaisedById,
        "request_raised_by_name": requestRaisedByName,
        "action_by_id": actionById,
        "action_by_name": actionByName,
        "created_at_formatted": createdAtFormatted,
        "actioned_at_formatted": actionedAtFormatted,
        "machine": machine?.toJson(),
      };
}

class Machine {
  int? id;
  String? name;
  String? machineCode;
  String? plantNo;
  String? itemCode;
  String? machineCost;
  String? mfgDate;
  DateTime? dateOfCommissioning;
  String? model;
  String? make;
  String? poNumber;
  String? poDate;
  int? isGemPoDetailsGiven;
  String? gemPoNumber;
  String? gemPoDate;
  String? expiryLife;
  int? warranty;
  String? allocation;
  String? capacity;
  String? status;
  String? workingStatus;
  String? machineImage;
  DateTime? lastTestedOn;
  DateTime? nextTestDueDate;
  DateTime? lastCalibratedOn;
  DateTime? nextCalibrationOn;
  String? testCertificate;
  String? underAmc;
  int? amcPeriod;
  String? amcWarrantyFrom;
  String? amcWarrantyTo;
  String? amcFirm;
  String? totalAmcCost;
  String? loaDetails;
  int? isAdditionalWarrantyDetailsGiven;
  String? warrantyFrom;
  String? warrantyTo;
  int? maintenance;
  int? maintenenceCount;
  DateTime? nextMaintenanceDate;
  String? qrCode;
  String? description;
  dynamic remarks;
  String? mcSpecility;
  int? vendor;
  String? vendorName;
  String? vendorPhoneNumber;
  String? vendorEmailAddress;
  String? vendorLocation;
  String? current;
  String? voltage;
  String? location;
  dynamic machinePhysicalLocation;
  String? power;
  String? efficiency;
  String? frequency;
  String? height;
  String? width;
  String? length;
  String? weight;
  String? isQrCodePrinted;
  String? isQrCodeGenerated;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  Machine({
    this.id,
    this.name,
    this.machineCode,
    this.plantNo,
    this.itemCode,
    this.machineCost,
    this.mfgDate,
    this.dateOfCommissioning,
    this.model,
    this.make,
    this.poNumber,
    this.poDate,
    this.isGemPoDetailsGiven,
    this.gemPoNumber,
    this.gemPoDate,
    this.expiryLife,
    this.warranty,
    this.allocation,
    this.capacity,
    this.status,
    this.workingStatus,
    this.machineImage,
    this.lastTestedOn,
    this.nextTestDueDate,
    this.lastCalibratedOn,
    this.nextCalibrationOn,
    this.testCertificate,
    this.underAmc,
    this.amcPeriod,
    this.amcWarrantyFrom,
    this.amcWarrantyTo,
    this.amcFirm,
    this.totalAmcCost,
    this.loaDetails,
    this.isAdditionalWarrantyDetailsGiven,
    this.warrantyFrom,
    this.warrantyTo,
    this.maintenance,
    this.maintenenceCount,
    this.nextMaintenanceDate,
    this.qrCode,
    this.description,
    this.remarks,
    this.mcSpecility,
    this.vendor,
    this.vendorName,
    this.vendorPhoneNumber,
    this.vendorEmailAddress,
    this.vendorLocation,
    this.current,
    this.voltage,
    this.location,
    this.machinePhysicalLocation,
    this.power,
    this.efficiency,
    this.frequency,
    this.height,
    this.width,
    this.length,
    this.weight,
    this.isQrCodePrinted,
    this.isQrCodeGenerated,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory Machine.fromJson(Map<String, dynamic> json) => Machine(
        id: json["id"],
        name: json["name"],
        machineCode: json["machine_code"],
        plantNo: json["plant_no"],
        itemCode: json["item_code"],
        machineCost: json["machine_cost"],
        mfgDate: json["mfg_date"],
        dateOfCommissioning: json["date_of_commissioning"] == null
            ? null
            : DateTime.parse(json["date_of_commissioning"]),
        model: json["model"],
        make: json["make"],
        poNumber: json["po_number"],
        poDate: json["po_date"],
        isGemPoDetailsGiven: json["is_gem_po_details_given"],
        gemPoNumber: json["gem_po_number"],
        gemPoDate: json["gem_po_date"],
        expiryLife: json["expiry_life"],
        warranty: json["warranty"],
        allocation: json["allocation"],
        capacity: json["capacity"],
        status: json["status"],
        workingStatus: json["working_status"],
        machineImage: json["machine_image"],
        lastTestedOn: json["last_tested_on"] == null
            ? null
            : DateTime.parse(json["last_tested_on"]),
        nextTestDueDate: json["next_test_due_date"] == null
            ? null
            : DateTime.parse(json["next_test_due_date"]),
        lastCalibratedOn: json["last_calibrated_on"] == null
            ? null
            : DateTime.parse(json["last_calibrated_on"]),
        nextCalibrationOn: json["next_calibration_on"] == null
            ? null
            : DateTime.parse(json["next_calibration_on"]),
        testCertificate: json["test_certificate"],
        underAmc: json["under_amc"],
        amcPeriod: json["amc_period"],
        amcWarrantyFrom: json["amc_warranty_from"],
        amcWarrantyTo: json["amc_warranty_to"],
        amcFirm: json["amc_firm"],
        totalAmcCost: json["total_amc_cost"],
        loaDetails: json["loa_details"],
        isAdditionalWarrantyDetailsGiven:
            json["is_additional_warranty_details_given"],
        warrantyFrom: json["warranty_from"],
        warrantyTo: json["warranty_to"],
        maintenance: json["maintenance"],
        maintenenceCount: json["maintenence_count"],
        nextMaintenanceDate: json["next_maintenance_date"] == null
            ? null
            : DateTime.parse(json["next_maintenance_date"]),
        qrCode: json["qr_code"],
        description: json["description"],
        remarks: json["remarks"],
        mcSpecility: json["mc_specility"],
        vendor: json["vendor"],
        vendorName: json["vendor_name"],
        vendorPhoneNumber: json["vendor_phone_number"],
        vendorEmailAddress: json["vendor_email_address"],
        vendorLocation: json["vendor_location"],
        current: json["current"],
        voltage: json["voltage"],
        location: json["location"],
        machinePhysicalLocation: json["machine_physical_location"],
        power: json["power"],
        efficiency: json["efficiency"],
        frequency: json["frequency"],
        height: json["height"],
        width: json["width"],
        length: json["length"],
        weight: json["weight"],
        isQrCodePrinted: json["is_qr_code_printed"],
        isQrCodeGenerated: json["is_qr_code_generated"],
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
        "name": name,
        "machine_code": machineCode,
        "plant_no": plantNo,
        "item_code": itemCode,
        "machine_cost": machineCost,
        "mfg_date": mfgDate,
        "date_of_commissioning":
            "${dateOfCommissioning!.year.toString().padLeft(4, '0')}-${dateOfCommissioning!.month.toString().padLeft(2, '0')}-${dateOfCommissioning!.day.toString().padLeft(2, '0')}",
        "model": model,
        "make": make,
        "po_number": poNumber,
        "po_date": poDate,
        "is_gem_po_details_given": isGemPoDetailsGiven,
        "gem_po_number": gemPoNumber,
        "gem_po_date": gemPoDate,
        "expiry_life": expiryLife,
        "warranty": warranty,
        "allocation": allocation,
        "capacity": capacity,
        "status": status,
        "working_status": workingStatus,
        "machine_image": machineImage,
        "last_tested_on":
            "${lastTestedOn!.year.toString().padLeft(4, '0')}-${lastTestedOn!.month.toString().padLeft(2, '0')}-${lastTestedOn!.day.toString().padLeft(2, '0')}",
        "next_test_due_date":
            "${nextTestDueDate!.year.toString().padLeft(4, '0')}-${nextTestDueDate!.month.toString().padLeft(2, '0')}-${nextTestDueDate!.day.toString().padLeft(2, '0')}",
        "last_calibrated_on":
            "${lastCalibratedOn!.year.toString().padLeft(4, '0')}-${lastCalibratedOn!.month.toString().padLeft(2, '0')}-${lastCalibratedOn!.day.toString().padLeft(2, '0')}",
        "next_calibration_on":
            "${nextCalibrationOn!.year.toString().padLeft(4, '0')}-${nextCalibrationOn!.month.toString().padLeft(2, '0')}-${nextCalibrationOn!.day.toString().padLeft(2, '0')}",
        "test_certificate": testCertificate,
        "under_amc": underAmc,
        "amc_period": amcPeriod,
        "amc_warranty_from": amcWarrantyFrom,
        "amc_warranty_to": amcWarrantyTo,
        "amc_firm": amcFirm,
        "total_amc_cost": totalAmcCost,
        "loa_details": loaDetails,
        "is_additional_warranty_details_given":
            isAdditionalWarrantyDetailsGiven,
        "warranty_from": warrantyFrom,
        "warranty_to": warrantyTo,
        "maintenance": maintenance,
        "maintenence_count": maintenenceCount,
        "next_maintenance_date":
            "${nextMaintenanceDate!.year.toString().padLeft(4, '0')}-${nextMaintenanceDate!.month.toString().padLeft(2, '0')}-${nextMaintenanceDate!.day.toString().padLeft(2, '0')}",
        "qr_code": qrCode,
        "description": description,
        "remarks": remarks,
        "mc_specility": mcSpecility,
        "vendor": vendor,
        "vendor_name": vendorName,
        "vendor_phone_number": vendorPhoneNumber,
        "vendor_email_address": vendorEmailAddress,
        "vendor_location": vendorLocation,
        "current": current,
        "voltage": voltage,
        "location": location,
        "machine_physical_location": machinePhysicalLocation,
        "power": power,
        "efficiency": efficiency,
        "frequency": frequency,
        "height": height,
        "width": width,
        "length": length,
        "weight": weight,
        "is_qr_code_printed": isQrCodePrinted,
        "is_qr_code_generated": isQrCodeGenerated,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
