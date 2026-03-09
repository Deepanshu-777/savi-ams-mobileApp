// To parse this JSON data, do
//
//     final pmsDetailsModel = pmsDetailsModelFromJson(jsonString);

import 'dart:convert';

PmsDetailsModel pmsDetailsModelFromJson(String str) =>
    PmsDetailsModel.fromJson(json.decode(str));

String pmsDetailsModelToJson(PmsDetailsModel data) =>
    json.encode(data.toJson());

class PmsDetailsModel {
  bool? success;
  String? message;
  Data? data;

  PmsDetailsModel({
    this.success,
    this.message,
    this.data,
  });

  factory PmsDetailsModel.fromJson(Map<String, dynamic> json) =>
      PmsDetailsModel(
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
  MaintenanceFormData? maintenanceFormData;

  Data({
    this.maintenanceFormData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        maintenanceFormData: json["Maintenance Form Data"] == null
            ? null
            : MaintenanceFormData.fromJson(json["Maintenance Form Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Maintenance Form Data": maintenanceFormData?.toJson(),
      };
}

class MaintenanceFormData {
  MachineData? machineData;
  List<DesignationList>? designationList;
  List<PmsTask>? pmsTasks;
  Format? format;
  List<String>? loadedTaskTypes;
  List<String>? loadedTypes;
  ScheduleDetails? scheduleDetails;

  MaintenanceFormData({
    this.machineData,
    this.designationList,
    this.pmsTasks,
    this.format,
    this.loadedTaskTypes,
    this.loadedTypes,
    this.scheduleDetails,
  });

  factory MaintenanceFormData.fromJson(Map<String, dynamic> json) =>
      MaintenanceFormData(
        machineData: json["machineData"] == null
            ? null
            : MachineData.fromJson(json["machineData"]),
        designationList: json["designationList"] == null
            ? []
            : List<DesignationList>.from(json["designationList"]!
                .map((x) => DesignationList.fromJson(x))),
        pmsTasks: json["pmsTasks"] == null
            ? []
            : List<PmsTask>.from(
                json["pmsTasks"]!.map((x) => PmsTask.fromJson(x))),
        format: json["format"] == null ? null : Format.fromJson(json["format"]),
        loadedTaskTypes: json["loadedTaskTypes"] == null
            ? []
            : List<String>.from(json["loadedTaskTypes"]!.map((x) => x)),
        loadedTypes: json["loadedTypes"] == null
            ? []
            : List<String>.from(json["loadedTypes"]!.map((x) => x)),
        scheduleDetails: json["scheduleDetails"] == null
            ? null
            : ScheduleDetails.fromJson(json["scheduleDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "machineData": machineData?.toJson(),
        "designationList": designationList == null
            ? []
            : List<dynamic>.from(designationList!.map((x) => x.toJson())),
        "pmsTasks": pmsTasks == null
            ? []
            : List<dynamic>.from(pmsTasks!.map((x) => x.toJson())),
        "format": format?.toJson(),
        "loadedTaskTypes": loadedTaskTypes == null
            ? []
            : List<dynamic>.from(loadedTaskTypes!.map((x) => x)),
        "loadedTypes": loadedTypes == null
            ? []
            : List<dynamic>.from(loadedTypes!.map((x) => x)),
        "scheduleDetails": scheduleDetails?.toJson(),
      };
}

class DesignationList {
  int? id;
  String? name;
  int? status;

  DesignationList({
    this.id,
    this.name,
    this.status,
  });

  factory DesignationList.fromJson(Map<String, dynamic> json) =>
      DesignationList(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}

class Format {
  int? id;
  String? formatName;
  String? formatDescription;
  String? formatType;
  List<String>? referenceIds;
  String? status;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  Format({
    this.id,
    this.formatName,
    this.formatDescription,
    this.formatType,
    this.referenceIds,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        id: json["id"],
        formatName: json["format_name"],
        formatDescription: json["format_description"],
        formatType: json["format_type"],
        referenceIds: json["reference_ids"] == null
            ? []
            : List<String>.from(json["reference_ids"]!.map((x) => x)),
        status: json["status"],
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
        "format_name": formatName,
        "format_description": formatDescription,
        "format_type": formatType,
        "reference_ids": referenceIds == null
            ? []
            : List<dynamic>.from(referenceIds!.map((x) => x)),
        "status": status,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class MachineData {
  int? id;
  String? name;
  String? machineCode;
  String? itemCode;
  String? machineCost;
  dynamic mfgDate;
  DateTime? dateOfCommissioning;
  String? model;
  String? make;
  String? poNumber;
  dynamic irepsPoNumber;
  dynamic poDate;
  int? isGemPoDetailsGiven;
  String? gemPoNumber;
  dynamic gemPoDate;
  String? expiryLife;
  int? warranty;
  String? allocation;
  String? capacity;
  String? status;
  String? workingStatus;
  String? machineImage;
  dynamic lastTestedOn;
  dynamic nextTestDueDate;
  dynamic lastCalibratedOn;
  dynamic nextCalibrationOn;
  String? testCertificate;
  String? underAmc;
  int? amcPeriod;
  dynamic amcWarrantyFrom;
  dynamic amcWarrantyTo;
  String? amcFirm;
  String? totalAmcCost;
  String? loaDetails;
  int? isAdditionalWarrantyDetailsGiven;
  dynamic warrantyFrom;
  dynamic warrantyTo;
  int? maintenance;
  int? maintenenceCount;
  DateTime? nextMaintenanceDate;
  dynamic nextMaintenanceId;
  DateTime? lastMaintenanceDate;
  DateTime? lastMaintenanceScheduledDate;
  String? qrCode;
  String? description;
  String? remarks;
  String? mcSpecility;
  int? vendor;
  String? vendorName;
  String? vendorPhoneNumber;
  String? vendorEmailAddress;
  String? vendorLocation;
  String? location;
  String? machinePhysicalLocation;
  String? stockHolderCode;
  String? station;
  String? categoryOfMachine;
  DateTime? dateOfAcquisitionInstallation;
  String? costOfAcquisitionInstallation;
  int? noOfShiftsUse;
  dynamic detailsOfImprovementsDate;
  String? detailsOfImprovementsCost;
  String? fundAllocationCode;
  String? noOfYearsMachineryInUse;
  String? rateOfDepreciation;
  String? accumulatedDepreciation;
  String? netBookValue;
  String? currentMarketValue;
  String? condition;
  String? headQuartersUcNo;
  String? whetherSurplus;
  String? pressureVesselNo;
  String? hoursPerDay;
  String? machineType;
  String? type;
  String? requiredIfNotWorking;
  String? actionTakenIfNotWorking;
  String? maintainedBy;
  String? amcFirmContactEmailId;
  String? amcContractPeriod;
  String? loaNoAgreementNo;
  String? isQrCodePrinted;
  String? isQrCodeGenerated;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? generalAttachments;
  String? machineWorkingStatus;
  String? vendorNumber;
  int? fundAllocationCodeId;
  int? categoryOfMachineId;

  MachineData({
    this.id,
    this.name,
    this.machineCode,
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
    this.nextMaintenanceId,
    this.lastMaintenanceDate,
    this.lastMaintenanceScheduledDate,
    this.qrCode,
    this.description,
    this.remarks,
    this.mcSpecility,
    this.vendor,
    this.vendorName,
    this.vendorPhoneNumber,
    this.vendorEmailAddress,
    this.vendorLocation,
    this.location,
    this.machinePhysicalLocation,
    this.stockHolderCode,
    this.station,
    this.categoryOfMachine,
    this.dateOfAcquisitionInstallation,
    this.costOfAcquisitionInstallation,
    this.noOfShiftsUse,
    this.detailsOfImprovementsDate,
    this.detailsOfImprovementsCost,
    this.fundAllocationCode,
    this.noOfYearsMachineryInUse,
    this.rateOfDepreciation,
    this.accumulatedDepreciation,
    this.netBookValue,
    this.currentMarketValue,
    this.condition,
    this.headQuartersUcNo,
    this.whetherSurplus,
    this.pressureVesselNo,
    this.hoursPerDay,
    this.machineType,
    this.type,
    this.requiredIfNotWorking,
    this.actionTakenIfNotWorking,
    this.maintainedBy,
    this.amcFirmContactEmailId,
    this.amcContractPeriod,
    this.loaNoAgreementNo,
    this.isQrCodePrinted,
    this.isQrCodeGenerated,
    this.createdAt,
    this.updatedAt,
    this.generalAttachments,
    this.machineWorkingStatus,
    this.vendorNumber,
    this.fundAllocationCodeId,
    this.categoryOfMachineId,
  });

  factory MachineData.fromJson(Map<String, dynamic> json) => MachineData(
        id: json["id"],
        name: json["name"],
        machineCode: json["machine_code"],
        itemCode: json["item_code"],
        machineCost: json["machine_cost"],
        mfgDate: json["mfg_date"],
        dateOfCommissioning: json["date_of_commissioning"] == null
            ? null
            : DateTime.parse(json["date_of_commissioning"]),
        model: json["model"],
        make: json["make"],
        poNumber: json["po_number"],
        irepsPoNumber: json["ireps_po_number"],
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
        nextMaintenanceId: json["next_maintenance_id"],
        lastMaintenanceDate: json["last_maintenance_date"] == null
            ? null
            : DateTime.parse(json["last_maintenance_date"]),
        lastMaintenanceScheduledDate:
            json["last_maintenance_scheduled_date"] == null
                ? null
                : DateTime.parse(json["last_maintenance_scheduled_date"]),
        qrCode: json["qr_code"],
        description: json["description"],
        remarks: json["remarks"],
        mcSpecility: json["mc_specility"],
        vendor: json["vendor"],
        vendorName: json["vendor_name"],
        vendorPhoneNumber: json["vendor_phone_number"],
        vendorEmailAddress: json["vendor_email_address"],
        vendorLocation: json["vendor_location"],
        location: json["location"],
        machinePhysicalLocation: json["machine_physical_location"],
        stockHolderCode: json["stock_holder_code"],
        station: json["station"],
        categoryOfMachine: json["category_of_machine"],
        dateOfAcquisitionInstallation:
            json["date_of_acquisition_installation"] == null
                ? null
                : DateTime.parse(json["date_of_acquisition_installation"]),
        costOfAcquisitionInstallation: json["cost_of_acquisition_installation"],
        noOfShiftsUse: json["no_of_shifts_use"],
        detailsOfImprovementsDate: json["details_of_improvements_date"],
        detailsOfImprovementsCost: json["details_of_improvements_cost"],
        fundAllocationCode: json["fund_allocation_code"],
        noOfYearsMachineryInUse: json["no_of_years_machinery_in_use"],
        rateOfDepreciation: json["rate_of_depreciation"],
        accumulatedDepreciation: json["accumulated_depreciation"],
        netBookValue: json["net_book_value"],
        currentMarketValue: json["current_market_value"],
        condition: json["condition"],
        headQuartersUcNo: json["head_quarters_uc_no"],
        whetherSurplus: json["whether_surplus"],
        pressureVesselNo: json["pressure_vessel_no"],
        hoursPerDay: json["hours_per_day"],
        machineType: json["machine_type"],
        type: json["type"],
        requiredIfNotWorking: json["required_if_not_working"],
        actionTakenIfNotWorking: json["action_taken_if_not_working"],
        maintainedBy: json["maintained_by"],
        amcFirmContactEmailId: json["amc_firm_contact_email_id"],
        amcContractPeriod: json["amc_contract_period"],
        loaNoAgreementNo: json["loa_no_agreement_no"],
        isQrCodePrinted: json["is_qr_code_printed"],
        isQrCodeGenerated: json["is_qr_code_generated"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        generalAttachments: json["general_attachments"] == null
            ? []
            : List<dynamic>.from(json["general_attachments"]!.map((x) => x)),
        machineWorkingStatus: json["machine_working_status"],
        vendorNumber: json["vendor_number"],
        fundAllocationCodeId: json["fund_allocation_code_id"],
        categoryOfMachineId: json["category_of_machine_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "machine_code": machineCode,
        "item_code": itemCode,
        "machine_cost": machineCost,
        "mfg_date": mfgDate,
        "date_of_commissioning":
            "${dateOfCommissioning!.year.toString().padLeft(4, '0')}-${dateOfCommissioning!.month.toString().padLeft(2, '0')}-${dateOfCommissioning!.day.toString().padLeft(2, '0')}",
        "model": model,
        "make": make,
        "po_number": poNumber,
        "ireps_po_number": irepsPoNumber,
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
        "next_maintenance_id": nextMaintenanceId,
        "last_maintenance_date":
            "${lastMaintenanceDate!.year.toString().padLeft(4, '0')}-${lastMaintenanceDate!.month.toString().padLeft(2, '0')}-${lastMaintenanceDate!.day.toString().padLeft(2, '0')}",
        "last_maintenance_scheduled_date":
            "${lastMaintenanceScheduledDate!.year.toString().padLeft(4, '0')}-${lastMaintenanceScheduledDate!.month.toString().padLeft(2, '0')}-${lastMaintenanceScheduledDate!.day.toString().padLeft(2, '0')}",
        "qr_code": qrCode,
        "description": description,
        "remarks": remarks,
        "mc_specility": mcSpecility,
        "vendor": vendor,
        "vendor_name": vendorName,
        "vendor_phone_number": vendorPhoneNumber,
        "vendor_email_address": vendorEmailAddress,
        "vendor_location": vendorLocation,
        "location": location,
        "machine_physical_location": machinePhysicalLocation,
        "stock_holder_code": stockHolderCode,
        "station": station,
        "category_of_machine": categoryOfMachine,
        "date_of_acquisition_installation":
            "${dateOfAcquisitionInstallation!.year.toString().padLeft(4, '0')}-${dateOfAcquisitionInstallation!.month.toString().padLeft(2, '0')}-${dateOfAcquisitionInstallation!.day.toString().padLeft(2, '0')}",
        "cost_of_acquisition_installation": costOfAcquisitionInstallation,
        "no_of_shifts_use": noOfShiftsUse,
        "details_of_improvements_date": detailsOfImprovementsDate,
        "details_of_improvements_cost": detailsOfImprovementsCost,
        "fund_allocation_code": fundAllocationCode,
        "no_of_years_machinery_in_use": noOfYearsMachineryInUse,
        "rate_of_depreciation": rateOfDepreciation,
        "accumulated_depreciation": accumulatedDepreciation,
        "net_book_value": netBookValue,
        "current_market_value": currentMarketValue,
        "condition": condition,
        "head_quarters_uc_no": headQuartersUcNo,
        "whether_surplus": whetherSurplus,
        "pressure_vessel_no": pressureVesselNo,
        "hours_per_day": hoursPerDay,
        "machine_type": machineType,
        "type": type,
        "required_if_not_working": requiredIfNotWorking,
        "action_taken_if_not_working": actionTakenIfNotWorking,
        "maintained_by": maintainedBy,
        "amc_firm_contact_email_id": amcFirmContactEmailId,
        "amc_contract_period": amcContractPeriod,
        "loa_no_agreement_no": loaNoAgreementNo,
        "is_qr_code_printed": isQrCodePrinted,
        "is_qr_code_generated": isQrCodeGenerated,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "general_attachments": generalAttachments == null
            ? []
            : List<dynamic>.from(generalAttachments!.map((x) => x)),
        "machine_working_status": machineWorkingStatus,
        "vendor_number": vendorNumber,
        "fund_allocation_code_id": fundAllocationCodeId,
        "category_of_machine_id": categoryOfMachineId,
      };
}

class PmsTask {
  int? id;
  int? scheduleId;
  int? formatId;
  String? type;
  String? taskType;
  String? taskNumber;
  String? taskName;
  String? workToBeDone;
  dynamic workDone;
  dynamic remarks;
  String? status;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  PmsTask({
    this.id,
    this.scheduleId,
    this.formatId,
    this.type,
    this.taskType,
    this.taskNumber,
    this.taskName,
    this.workToBeDone,
    this.workDone,
    this.remarks,
    this.status,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory PmsTask.fromJson(Map<String, dynamic> json) => PmsTask(
        id: json["id"],
        scheduleId: json["schedule_id"],
        formatId: json["format_id"],
        type: json["type"],
        taskType: json["task_type"],
        taskNumber: json["task_number"],
        taskName: json["task_name"],
        workToBeDone: json["work_to_be_done"],
        workDone: json["work_done"],
        remarks: json["remarks"],
        status: json["status"],
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
        "schedule_id": scheduleId,
        "format_id": formatId,
        "type": type,
        "task_type": taskType,
        "task_number": taskNumber,
        "task_name": taskName,
        "work_to_be_done": workToBeDone,
        "work_done": workDone,
        "remarks": remarks,
        "status": status,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ScheduleDetails {
  int? scheduleId;
  DateTime? maintenanceDate;
  int? machineId;
  String? type;
  Format? formatDetails;

  ScheduleDetails({
    this.scheduleId,
    this.maintenanceDate,
    this.machineId,
    this.type,
    this.formatDetails,
  });

  factory ScheduleDetails.fromJson(Map<String, dynamic> json) =>
      ScheduleDetails(
        scheduleId: json["schedule_id"],
        maintenanceDate: json["maintenance_date"] == null
            ? null
            : DateTime.parse(json["maintenance_date"]),
        machineId: json["machine_id"],
        type: json["type"],
        formatDetails: json["format_details"] == null
            ? null
            : Format.fromJson(json["format_details"]),
      );

  Map<String, dynamic> toJson() => {
        "schedule_id": scheduleId,
        "maintenance_date":
            "${maintenanceDate!.year.toString().padLeft(4, '0')}-${maintenanceDate!.month.toString().padLeft(2, '0')}-${maintenanceDate!.day.toString().padLeft(2, '0')}",
        "machine_id": machineId,
        "type": type,
        "format_details": formatDetails?.toJson(),
      };
}
