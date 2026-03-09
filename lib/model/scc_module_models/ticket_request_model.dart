// To parse this JSON data, do
//
//     final ticketRequestModel = ticketRequestModelFromJson(jsonString);

import 'dart:convert';

TicketRequestModel ticketRequestModelFromJson(String str) =>
    TicketRequestModel.fromJson(json.decode(str));

String ticketRequestModelToJson(TicketRequestModel data) =>
    json.encode(data.toJson());

class TicketRequestModel {
  bool? success;
  String? message;
  Data? data;

  TicketRequestModel({
    this.success,
    this.message,
    this.data,
  });

  factory TicketRequestModel.fromJson(Map<String, dynamic> json) =>
      TicketRequestModel(
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
  String? userLocation;
  int? total;
  TicketRequests? ticketRequests;

  Data({
    this.userLocation,
    this.total,
    this.ticketRequests,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userLocation: json["user_location"],
        total: json["total"],
        ticketRequests: json["ticket_requests"] == null
            ? null
            : TicketRequests.fromJson(json["ticket_requests"]),
      );

  Map<String, dynamic> toJson() => {
        "user_location": userLocation,
        "total": total,
        "ticket_requests": ticketRequests?.toJson(),
      };
}

class TicketRequests {
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

  TicketRequests({
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

  factory TicketRequests.fromJson(Map<String, dynamic> json) => TicketRequests(
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
  String? name;
  String? phone;
  String? description;
  int? machineId;
  String? shop;
  List<String>? attachments;
  String? raisedFrom;
  String? status;
  dynamic actionByUserId;
  dynamic actionAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdAtFormatted;
  Machine? machine;

  Datum({
    this.id,
    this.name,
    this.phone,
    this.description,
    this.machineId,
    this.shop,
    this.attachments,
    this.raisedFrom,
    this.status,
    this.actionByUserId,
    this.actionAt,
    this.createdAt,
    this.updatedAt,
    this.createdAtFormatted,
    this.machine,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        description: json["description"],
        machineId: json["machine_id"],
        shop: json["shop"],
        attachments: json["attachments"] == null
            ? []
            : List<String>.from(json["attachments"]!.map((x) => x)),
        raisedFrom: json["raised_from"],
        status: json["status"],
        actionByUserId: json["action_by_user_id"],
        actionAt: json["action_at"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAtFormatted: json["created_at_formatted"],
        machine:
            json["machine"] == null ? null : Machine.fromJson(json["machine"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "description": description,
        "machine_id": machineId,
        "shop": shop,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "raised_from": raisedFrom,
        "status": status,
        "action_by_user_id": actionByUserId,
        "action_at": actionAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "created_at_formatted": createdAtFormatted,
        "machine": machine?.toJson(),
      };
}

class Machine {
  int? id;
  String? name;
  String? machineCode;
  dynamic plantNo;
  String? itemCode;
  dynamic machineCost;
  dynamic mfgDate;
  DateTime? dateOfCommissioning;
  dynamic model;
  String? make;
  dynamic poNumber;
  dynamic poDate;
  int? isGemPoDetailsGiven;
  dynamic gemPoNumber;
  dynamic gemPoDate;
  String? expiryLife;
  int? warranty;
  dynamic allocation;
  String? capacity;
  String? status;
  String? workingStatus;
  String? machineImage;
  dynamic lastTestedOn;
  dynamic nextTestDueDate;
  dynamic lastCalibratedOn;
  dynamic nextCalibrationOn;
  dynamic testCertificate;
  String? underAmc;
  dynamic amcPeriod;
  DateTime? amcWarrantyFrom;
  DateTime? amcWarrantyTo;
  dynamic amcFirm;
  dynamic totalAmcCost;
  dynamic loaDetails;
  int? isAdditionalWarrantyDetailsGiven;
  dynamic warrantyFrom;
  dynamic warrantyTo;
  int? maintenance;
  int? maintenenceCount;
  DateTime? nextMaintenanceDate;
  String? qrCode;
  String? description;
  dynamic remarks;
  dynamic mcSpecility;
  int? vendor;
  dynamic vendorName;
  String? vendorPhoneNumber;
  String? vendorEmailAddress;
  dynamic current;
  dynamic voltage;
  String? location;
  dynamic power;
  dynamic efficiency;
  dynamic frequency;
  dynamic height;
  dynamic width;
  dynamic length;
  dynamic weight;
  String? isQrCodePrinted;
  String? isQrCodeGenerated;
  int? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? ticketRequestId;

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
    this.current,
    this.voltage,
    this.location,
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
    this.ticketRequestId,
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
        lastTestedOn: json["last_tested_on"],
        nextTestDueDate: json["next_test_due_date"],
        lastCalibratedOn: json["last_calibrated_on"],
        nextCalibrationOn: json["next_calibration_on"],
        testCertificate: json["test_certificate"],
        underAmc: json["under_amc"],
        amcPeriod: json["amc_period"],
        amcWarrantyFrom: json["amc_warranty_from"] == null
            ? null
            : DateTime.parse(json["amc_warranty_from"]),
        amcWarrantyTo: json["amc_warranty_to"] == null
            ? null
            : DateTime.parse(json["amc_warranty_to"]),
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
        current: json["current"],
        voltage: json["voltage"],
        location: json["location"],
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
        ticketRequestId: json["ticket_request_id"],
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
        "last_tested_on": lastTestedOn,
        "next_test_due_date": nextTestDueDate,
        "last_calibrated_on": lastCalibratedOn,
        "next_calibration_on": nextCalibrationOn,
        "test_certificate": testCertificate,
        "under_amc": underAmc,
        "amc_period": amcPeriod,
        "amc_warranty_from":
            "${amcWarrantyFrom!.year.toString().padLeft(4, '0')}-${amcWarrantyFrom!.month.toString().padLeft(2, '0')}-${amcWarrantyFrom!.day.toString().padLeft(2, '0')}",
        "amc_warranty_to":
            "${amcWarrantyTo!.year.toString().padLeft(4, '0')}-${amcWarrantyTo!.month.toString().padLeft(2, '0')}-${amcWarrantyTo!.day.toString().padLeft(2, '0')}",
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
        "current": current,
        "voltage": voltage,
        "location": location,
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
        "ticket_request_id": ticketRequestId,
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
