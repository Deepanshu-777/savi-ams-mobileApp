// To parse this JSON data, do
//
//     final machineDetailsToEdit = machineDetailsToEditFromJson(jsonString);

import 'dart:convert';

MachineDetailsToEdit machineDetailsToEditFromJson(String str) =>
    MachineDetailsToEdit.fromJson(json.decode(str));

String machineDetailsToEditToJson(MachineDetailsToEdit data) =>
    json.encode(data.toJson());

class MachineDetailsToEdit {
  bool? success;
  String? message;
  Data? data;

  MachineDetailsToEdit({
    this.success,
    this.message,
    this.data,
  });

  factory MachineDetailsToEdit.fromJson(Map<String, dynamic> json) =>
      MachineDetailsToEdit(
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
  MachineDetails? machineDetails;

  Data({
    this.machineDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        machineDetails: json["Machine Details"] == null
            ? null
            : MachineDetails.fromJson(json["Machine Details"]),
      );

  Map<String, dynamic> toJson() => {
        "Machine Details": machineDetails?.toJson(),
      };
}

class MachineDetails {
  int? id;
  String? name;
  String? machineCode;
  String? plantNo;
  String? itemCode;
  String? machineCost;
  DateTime? mfgDate;
  DateTime? dateOfCommissioning;
  String? model;
  String? make;
  String? poNumber;
  String? irepsPoNumber;
  DateTime? poDate;
  int? isGemPoDetailsGiven;
  String? gemPoNumber;
  DateTime? gemPoDate;
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
  DateTime? amcFrom;
  DateTime? amcTo;
  String? amcFirm;
  String? amcFirmContactEmailId;
  String? totalAmcCost;
  String? loaDetails;
  int? isAdditionalWarrantyDetailsGiven;
  DateTime? warrantyFrom;
  DateTime? warrantyTo;
  int? maintenance;
  int? maintenenceCount;
  DateTime? nextMaintenanceDate;
  DateTime? lastMaintenanceScheduledDate;
  DateTime? lastMaintenanceDate;
  String? qrCode;
  String? description;
  String? remarks;
  String? mcSpecility;
  int? vendor;
  String? vendorName;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusTitle;
  String? makeTitle;
  List<Attachment>? poAttachments;
  List<Attachment>? generalAttachments;
  String? vendorLocation;
  String? plantNumber;
  String? plantCode;

  String? stockHolderCode;
  String? station;
  int? categoryOfMachineId;
  String? categoryOfMachine;
  String? cofmowPoNoDate;
  String? dateOfAcquisitionInstallation;
  String? costOfAcquisitionInstallation;
  num? noOfShiftsUse;
  String? detailsOfImprovementsDate;
  String? detailsOfImprovementsCost;
  String? fundAllocationCode;
  int? fundAllocationCodeId;
  String? noOfYearsMachineryInUse;
  dynamic rateOfDepreciation;
  dynamic accumulatedDepreciation;
  dynamic netBookValue;
  // String? referenceOfAvailableDocuments;
  dynamic currentMarketValue;
  String? condition;
  String? headQuartersUcNo;
  String? whetherSurplus;
  String? machinePhysicalLocation;
  String? pressureVesselNo;
  String? hoursPerDay;
  String? machineType;

  MachineDetails({
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
    this.irepsPoNumber,
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
    this.amcFrom,
    this.amcTo,
    this.amcFirm,
    this.amcFirmContactEmailId,
    this.totalAmcCost,
    this.loaDetails,
    this.isAdditionalWarrantyDetailsGiven,
    this.warrantyFrom,
    this.warrantyTo,
    this.maintenance,
    this.maintenenceCount,
    this.nextMaintenanceDate,
    this.lastMaintenanceScheduledDate,
    this.lastMaintenanceDate,
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
    this.createdAt,
    this.updatedAt,
    this.statusTitle,
    this.makeTitle,
    this.poAttachments,
    this.generalAttachments,
    this.vendorLocation,
    this.plantNumber,
    this.plantCode,
    this.stockHolderCode,
    this.station,
    this.categoryOfMachine,
    this.categoryOfMachineId,
    this.cofmowPoNoDate,
    this.dateOfAcquisitionInstallation,
    this.costOfAcquisitionInstallation,
    this.noOfShiftsUse,
    this.detailsOfImprovementsDate,
    this.detailsOfImprovementsCost,
    this.fundAllocationCode,
    this.fundAllocationCodeId,
    this.noOfYearsMachineryInUse,
    this.rateOfDepreciation,
    this.accumulatedDepreciation,
    this.netBookValue,
    this.currentMarketValue,
    this.condition,
    this.headQuartersUcNo,
    this.machinePhysicalLocation,
    this.whetherSurplus,
    this.pressureVesselNo,
    this.hoursPerDay,
    this.machineType,
  });

  factory MachineDetails.fromJson(Map<String, dynamic> json) => MachineDetails(
        id: json["id"],
        name: json["name"],
        machineCode: json["machine_code"],
        plantNo: json["plant_no"],
        itemCode: json["item_code"],
        machineCost: json["machine_cost"],
        mfgDate:
            json["mfg_date"] == null ? null : DateTime.parse(json["mfg_date"]),
        dateOfCommissioning: json["date_of_commissioning"] == null
            ? null
            : DateTime.parse(json["date_of_commissioning"]),
        model: json["model"],
        make: json["make"],
        poNumber: json["po_number"],
        irepsPoNumber: json["ireps_po_number"],
        poDate:
            json["po_date"] == null ? null : DateTime.parse(json["po_date"]),
        isGemPoDetailsGiven: json["is_gem_po_details_given"],
        gemPoNumber: json["gem_po_number"],
        gemPoDate: json["gem_po_date"] == null
            ? null
            : DateTime.parse(json["gem_po_date"]),
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
        amcFrom: json["amc_warranty_from"] == null
            ? null
            : DateTime.parse(json["amc_warranty_from"]),
        amcTo: json["amc_warranty_to"] == null
            ? null
            : DateTime.parse(json["amc_warranty_to"]),
        amcFirm: json["amc_firm"],
        amcFirmContactEmailId: json["amc_firm_contact_email_id"],
        totalAmcCost: json["total_amc_cost"],
        loaDetails: json["loa_details"],
        isAdditionalWarrantyDetailsGiven:
            json["is_additional_warranty_details_given"],
        warrantyFrom: json["warranty_from"] == null
            ? null
            : DateTime.parse(json["warranty_from"]),
        warrantyTo: json["warranty_to"] == null
            ? null
            : DateTime.parse(json["warranty_to"]),
        maintenance: json["maintenance"],
        maintenenceCount: json["maintenence_count"],
        nextMaintenanceDate: json["next_maintenance_date"] == null
            ? null
            : DateTime.parse(json["next_maintenance_date"]),
        lastMaintenanceScheduledDate: json["last_maintenance_scheduled_date"] == null
            ? null
            : DateTime.parse(json["last_maintenance_scheduled_date"]),
        lastMaintenanceDate: json["last_maintenance_date"] == null
            ? null
            : DateTime.parse(json["last_maintenance_date"]),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        statusTitle: json["status_title"],
        makeTitle: json["make_title"],
        poAttachments: json["po_attachments"] == null
            ? []
            : List<Attachment>.from(
                json["po_attachments"]!.map((x) => Attachment.fromJson(x))),
        generalAttachments: json["general_attachments"] == null
            ? []
            : List<Attachment>.from(json["general_attachments"]!
                .map((x) => Attachment.fromJson(x))),
        vendorLocation: json["vendor_location"],
        plantNumber: json["plant_number"],
        plantCode: json["plant_code"],
        stockHolderCode: json["stock_holder_code"],
        station: json["station"],
        categoryOfMachine: json["category_of_machine"],
        categoryOfMachineId: json["category_of_machine_id"],
        cofmowPoNoDate: json["cofmow_po_no_date"],
        dateOfAcquisitionInstallation: json["date_of_acquisition_installation"],
        costOfAcquisitionInstallation: json["cost_of_acquisition_installation"],
        noOfShiftsUse: json["no_of_shifts_use"],
        detailsOfImprovementsDate: json["details_of_improvements_date"],
        detailsOfImprovementsCost: json["details_of_improvements_cost"],
        fundAllocationCode: json["fund_allocation_code"],
        fundAllocationCodeId: json["fund_allocation_code_id"],
        noOfYearsMachineryInUse: json["no_of_years_machinery_in_use"],
        rateOfDepreciation: json["rate_of_depreciation"],
        accumulatedDepreciation: json["accumulated_depreciation"],
        netBookValue: json["net_book_value"],
        currentMarketValue: json["current_market_value"],
        condition: json["condition"],
        headQuartersUcNo: json["head_quarters_uc_no"],
        whetherSurplus: json["whether_surplus"],
        machinePhysicalLocation: json["machine_physical_location"],
        pressureVesselNo: json["pressure_vessel_no"],
        hoursPerDay: json["hours_per_day"],
        machineType: json["machine_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "machine_code": machineCode,
        "plant_no": plantNo,
        "item_code": itemCode,
        "machine_cost": machineCost,
        "mfg_date":
            "${mfgDate!.year.toString().padLeft(4, '0')}-${mfgDate!.month.toString().padLeft(2, '0')}-${mfgDate!.day.toString().padLeft(2, '0')}",
        "date_of_commissioning":
            "${dateOfCommissioning!.year.toString().padLeft(4, '0')}-${dateOfCommissioning!.month.toString().padLeft(2, '0')}-${dateOfCommissioning!.day.toString().padLeft(2, '0')}",
        "model": model,
        "make": make,
        "po_number": poNumber,
        "ireps_po_number": irepsPoNumber,
        "po_date":
            "${poDate!.year.toString().padLeft(4, '0')}-${poDate!.month.toString().padLeft(2, '0')}-${poDate!.day.toString().padLeft(2, '0')}",
        "is_gem_po_details_given": isGemPoDetailsGiven,
        "gem_po_number": gemPoNumber,
        "gem_po_date":
            "${gemPoDate!.year.toString().padLeft(4, '0')}-${gemPoDate!.month.toString().padLeft(2, '0')}-${gemPoDate!.day.toString().padLeft(2, '0')}",
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
        "amc_warranty_from":
            "${amcFrom!.year.toString().padLeft(4, '0')}-${amcFrom!.month.toString().padLeft(2, '0')}-${amcFrom!.day.toString().padLeft(2, '0')}",
        "amc_warranty_to":
            "${amcTo!.year.toString().padLeft(4, '0')}-${amcTo!.month.toString().padLeft(2, '0')}-${amcTo!.day.toString().padLeft(2, '0')}",
        "amc_firm": amcFirm,
        "amc_firm_contact_email_id": amcFirmContactEmailId,
        "total_amc_cost": totalAmcCost,
        "loa_details": loaDetails,
        "is_additional_warranty_details_given":
            isAdditionalWarrantyDetailsGiven,
        "warranty_from":
            "${warrantyFrom!.year.toString().padLeft(4, '0')}-${warrantyFrom!.month.toString().padLeft(2, '0')}-${warrantyFrom!.day.toString().padLeft(2, '0')}",
        "warranty_to":
            "${warrantyTo!.year.toString().padLeft(4, '0')}-${warrantyTo!.month.toString().padLeft(2, '0')}-${warrantyTo!.day.toString().padLeft(2, '0')}",
        "maintenance": maintenance,
        "maintenence_count": maintenenceCount,
        "next_maintenance_date":
            "${nextMaintenanceDate!.year.toString().padLeft(4, '0')}-${nextMaintenanceDate!.month.toString().padLeft(2, '0')}-${nextMaintenanceDate!.day.toString().padLeft(2, '0')}",
        "last_maintenance_scheduled_date":
            "${lastMaintenanceScheduledDate!.year.toString().padLeft(4, '0')}-${lastMaintenanceScheduledDate!.month.toString().padLeft(2, '0')}-${lastMaintenanceScheduledDate!.day.toString().padLeft(2, '0')}",
        "last_maintenance_date":
            "${lastMaintenanceDate!.year.toString().padLeft(4, '0')}-${lastMaintenanceDate!.month.toString().padLeft(2, '0')}-${lastMaintenanceDate!.day.toString().padLeft(2, '0')}",
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status_title": statusTitle,
        "make_title": makeTitle,
        "po_attachments": poAttachments == null
            ? []
            : List<dynamic>.from(poAttachments!.map((x) => x.toJson())),
        "general_attachments": generalAttachments == null
            ? []
            : List<dynamic>.from(generalAttachments!.map((x) => x.toJson())),
        "vendor_location": vendorLocation,
        "plant_number": plantNumber,
        "plant_code": plantCode,
        "stock_holder_code": stockHolderCode,
        "station": station,
        "category_of_machine": categoryOfMachine,
        "category_of_machine_id": categoryOfMachineId,
        "cofmow_po_no_date": cofmowPoNoDate,
        "date_of_acquisition_installation": dateOfAcquisitionInstallation,
        "cost_of_acquisition_installation": costOfAcquisitionInstallation,
        "no_of_shifts_use": noOfShiftsUse,
        "details_of_improvements_date": detailsOfImprovementsDate,
        "details_of_improvements_cost": detailsOfImprovementsCost,
        "fund_allocation_code": fundAllocationCode,
        "fund_allocation_code_id": fundAllocationCodeId,
        "no_of_years_machinery_in_use": noOfYearsMachineryInUse,
        "rate_of_depreciation": rateOfDepreciation,
        "accumulated_depreciation": accumulatedDepreciation,
        "net_book_value": netBookValue,
        "current_market_value": currentMarketValue,
        "condition": condition,
        "head_quarters_uc_no": headQuartersUcNo,
        "whether_surplus": whetherSurplus,
        "machine_physical_location": machinePhysicalLocation,
        "pressure_vessel_no": pressureVesselNo,
        "hours_per_day": hoursPerDay,
        "machine_type": machineType,
      };
}

class Attachment {
  int? id;
  String? name;

  Attachment({
    this.id,
    this.name,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
