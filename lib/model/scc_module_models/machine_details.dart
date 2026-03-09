// To parse this JSON data, do
//
//     final machineDetailsModel = machineDetailsModelFromJson(jsonString);

import 'dart:convert';

MachineDetailsModel machineDetailsModelFromJson(String str) =>
    MachineDetailsModel.fromJson(json.decode(str));

String machineDetailsModelToJson(MachineDetailsModel data) =>
    json.encode(data.toJson());

class MachineDetailsModel {
  bool? success;
  String? message;
  Data? data;

  MachineDetailsModel({
    this.success,
    this.message,
    this.data,
  });

  factory MachineDetailsModel.fromJson(Map<String, dynamic> json) =>
      MachineDetailsModel(
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
  String? mfgDate;
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
  String? amcWarrantyFrom;
  String? amcWarrantyTo;
  String? amcFirm;
  String? amcFirmContactEmailId;
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
  String? remarks;
  String? mcSpecility;
  int? vendor;
  String? vendorName;
  String? vendorPhoneNumber;
  String? vendorEmailAddress;
  String? current;
  String? voltage;
  String? location;
  String? power;
  String? efficiency;
  String? frequency;
  String? height;
  String? width;
  String? length;
  String? weight;
  String? isQrCodePrinted;
  String? isQrCodeGenerated;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusIndex;
  String? warrantyStatus;
  String? warrantyDate;
  VendorDetail? vendorDetail;
  List<Attachment>? poAttachments;
  List<Attachment>? generalAttachments;
  int? totalComplaintCount;
  int? totalTicketsCompleted;
  int? totalTicketsExpenditure;
  int? totalMaintenanceCount;
  int? totalMaintenanceExpenditure;
  List<TicketsLogHistory>? ticketsLogHistory;
  ScheduledMaintenence? scheduledMaintenence;
  bool? ifDcRequestRaisedFor;
  RequestDetails? requestDetails;

  String? stockHolderCode;
  String? station;
  String? categoryOfMachine;
  String? cofmowPoNoDate;
  String? dateOfAcquisitionInstallation;
  String? costOfAcquisitionInstallation;
  num? noOfShiftsUse;
  String? detailsOfImprovementsDate;
  String? detailsOfImprovementsCost;
  String? fundAllocationCode;
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
    this.amcWarrantyFrom,
    this.amcWarrantyTo,
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
    this.statusIndex,
    this.warrantyStatus,
    this.warrantyDate,
    this.vendorDetail,
    this.poAttachments,
    this.generalAttachments,
    this.totalComplaintCount,
    this.totalTicketsCompleted,
    this.totalTicketsExpenditure,
    this.totalMaintenanceCount,
    this.totalMaintenanceExpenditure,
    this.ticketsLogHistory,
    this.scheduledMaintenence,
    this.ifDcRequestRaisedFor,
    this.requestDetails,
    this.stockHolderCode,
    this.station,
    this.categoryOfMachine,
    this.cofmowPoNoDate,
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
        mfgDate: json["mfg_date"],
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
        amcWarrantyFrom: json["amc_warranty_from"],
        amcWarrantyTo: json["amc_warranty_to"],
        amcFirm: json["amc_firm"],
        amcFirmContactEmailId: json["amc_firm_contact_email_id"],
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        statusIndex: json["statusIndex"],
        warrantyStatus: json["warrantyStatus"],
        warrantyDate: json["warrantyDate"],
        ifDcRequestRaisedFor: json["if_dc_request_raised_for"],
        vendorDetail: json["vendorDetail"] == null
            ? null
            : VendorDetail.fromJson(json["vendorDetail"]),
        poAttachments: json["po_attachments"] == null
            ? []
            : List<Attachment>.from(
                json["po_attachments"]!.map((x) => Attachment.fromJson(x))),
        generalAttachments: json["general_attachments"] == null
            ? []
            : List<Attachment>.from(json["general_attachments"]!
                .map((x) => Attachment.fromJson(x))),
        totalComplaintCount: json["totalComplaintCount"],
        totalTicketsCompleted: json["total_tickets_completed"],
        totalTicketsExpenditure: json["total_tickets_expenditure"],
        totalMaintenanceCount: json["total_maintenance_count"],
        totalMaintenanceExpenditure: json["total_maintenance_expenditure"],
        ticketsLogHistory: json["ticketsLogHistory"] == null
            ? []
            : List<TicketsLogHistory>.from(json["ticketsLogHistory"]!
                .map((x) => TicketsLogHistory.fromJson(x))),
        scheduledMaintenence: json["scheduled_maintenence"] == null
            ? null
            : ScheduledMaintenence.fromJson(json["scheduled_maintenence"]),
        requestDetails: json["request_details"] == null
            ? null
            : RequestDetails.fromJson(json["request_details"]),
        stockHolderCode: json["stock_holder_code"],
        station: json["station"],
        categoryOfMachine: json["category_of_machine"],
        cofmowPoNoDate: json["cofmow_po_no_date"],
        dateOfAcquisitionInstallation: json["date_of_acquisition_installation"],
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
        "mfg_date": mfgDate,
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
        "amc_warranty_from": amcWarrantyFrom,
        "amc_warranty_to": amcWarrantyTo,
        "amc_firm": amcFirm,
        "amc_firm_contact_email_id": amcFirmContactEmailId,
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "statusIndex": statusIndex,
        "warrantyStatus": warrantyStatus,
        "warrantyDate": warrantyDate,
        "vendorDetail": vendorDetail?.toJson(),
        "po_attachments": poAttachments == null
            ? []
            : List<dynamic>.from(poAttachments!.map((x) => x.toJson())),
        "general_attachments": generalAttachments == null
            ? []
            : List<dynamic>.from(generalAttachments!.map((x) => x.toJson())),
        "totalComplaintCount": totalComplaintCount,
        "total_tickets_completed": totalTicketsCompleted,
        "total_tickets_expenditure": totalTicketsExpenditure,
        "total_maintenance_count": totalMaintenanceCount,
        "total_maintenance_expenditure": totalMaintenanceExpenditure,
        "ticketsLogHistory": ticketsLogHistory == null
            ? []
            : List<dynamic>.from(ticketsLogHistory!.map((x) => x.toJson())),
        "scheduled_maintenence": scheduledMaintenence?.toJson(),
        "if_dc_request_raised_for": ifDcRequestRaisedFor,
        "request_details": requestDetails?.toJson(),
        "stock_holder_code": stockHolderCode,
        "station": station,
        "category_of_machine": categoryOfMachine,
        "cofmow_po_no_date": cofmowPoNoDate,
        "date_of_acquisition_installation": dateOfAcquisitionInstallation,
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

class ScheduledMaintenence {
  String? upcomingMaintenenceDate;
  String? upcomingMaintenenceDay;
  String? upcomingMaintenenceMonth;
  String? upcomingMaintenenceYear;
  int? maintenance;
  String? dueDays;
  int? dueDaysCount;
  List<CompletedMaintenenceList>? completedMaintenenceList;

  ScheduledMaintenence({
    this.upcomingMaintenenceDate,
    this.upcomingMaintenenceDay,
    this.upcomingMaintenenceMonth,
    this.upcomingMaintenenceYear,
    this.maintenance,
    this.dueDays,
    this.dueDaysCount,
    this.completedMaintenenceList,
  });

  factory ScheduledMaintenence.fromJson(Map<String, dynamic> json) =>
      ScheduledMaintenence(
        upcomingMaintenenceDate: json["upcoming_maintenence_date"],
        upcomingMaintenenceDay: json["upcoming_maintenence_day"],
        upcomingMaintenenceMonth: json["upcoming_maintenence_month"],
        upcomingMaintenenceYear: json["upcoming_maintenence_year"],
        maintenance: json["maintenance"],
        dueDays: json["due_days"],
        dueDaysCount: json["due_days_count"],
        completedMaintenenceList: json["completed_maintenence_list"] == null
            ? []
            : List<CompletedMaintenenceList>.from(
                json["completed_maintenence_list"]!
                    .map((x) => CompletedMaintenenceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "upcoming_maintenence_date": upcomingMaintenenceDate,
        "upcoming_maintenence_day": upcomingMaintenenceDay,
        "upcoming_maintenence_month": upcomingMaintenenceMonth,
        "upcoming_maintenence_year": upcomingMaintenenceYear,
        "maintenance": maintenance,
        "due_days": dueDays,
        "due_days_count": dueDaysCount,
        "completed_maintenence_list": completedMaintenenceList == null
            ? []
            : List<dynamic>.from(
                completedMaintenenceList!.map((x) => x.toJson())),
      };
}

class CompletedMaintenenceList {
  int? id;
  int? machineId;
  int? userId;
  String? issueCodes;
  String? statusRemarks;
  String? maintenenceDoneDate;
  String? itemCode;
  String? name;
  String? maintenenceDate;
  String? maintenenceDay;
  String? maintenenceMonth;
  String? maintenenceYear;
  String? maintenenceTime;

  CompletedMaintenenceList({
    this.id,
    this.machineId,
    this.userId,
    this.issueCodes,
    this.statusRemarks,
    this.maintenenceDoneDate,
    this.itemCode,
    this.name,
    this.maintenenceDate,
    this.maintenenceDay,
    this.maintenenceMonth,
    this.maintenenceYear,
    this.maintenenceTime,
  });

  factory CompletedMaintenenceList.fromJson(Map<String, dynamic> json) =>
      CompletedMaintenenceList(
        id: json["id"],
        machineId: json["machine_id"],
        userId: json["user_id"],
        issueCodes: json["issue_codes"],
        statusRemarks: json["status_remarks"],
        maintenenceDoneDate: json["maintenence_done_date"],
        itemCode: json["item_code"],
        name: json["name"],
        maintenenceDate: json["maintenence_date"],
        maintenenceDay: json["maintenence_day"],
        maintenenceMonth: json["maintenence_month"],
        maintenenceYear: json["maintenence_year"],
        maintenenceTime: json["maintenence_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "machine_id": machineId,
        "user_id": userId,
        "issue_codes": issueCodes,
        "status_remarks": statusRemarks,
        "maintenence_done_date": maintenenceDate,
        "name": name,
        "maintenence_date": maintenenceDate,
        "maintenence_day": maintenenceDay,
        "maintenence_month": maintenenceMonth,
        "maintenence_year": maintenenceYear,
        "maintenence_time": maintenenceTime,
      };
}

class TicketsLogHistory {
  int? id;
  String? description;
  String? ticketNumber;
  String? machineId;
  dynamic status;
  String? issueCode;
  dynamic remarks;
  String? itemCode;
  String? locationId;
  String? locationName;
  int? warranty;
  String? name;
  dynamic createdAt;
  String? issueRaisedAt;
  String? issueRaisedRemark;
  String? verification;
  String? issueAcknowledgedDate;
  String? issueAcknowledgedRemark;
  String? issueResolvedDate;
  String? issueResolvedRemark;
  String? timeTaken;
  String? issueApprovedDate;
  String? issueApprovedRemark;
  String? issueUnverifiedDate;
  String? issueUnverifiedRemark;
  String? issueReopenedDate;
  String? issueReopenedRemark;
  String? issueCancelledDate;
  String? issueCancelledRemark;
  String? issueRaisedDate;
  List<IssueCode>? issueCodes;
  String? ticketDate;
  String? ticketMonth;
  String? ticketYear;
  String? statusIndex;

  TicketsLogHistory({
    this.id,
    this.description,
    this.ticketNumber,
    this.machineId,
    this.status,
    this.issueCode,
    this.remarks,
    this.itemCode,
    this.locationId,
    this.locationName,
    this.warranty,
    this.name,
    this.createdAt,
    this.issueRaisedAt,
    this.issueRaisedRemark,
    this.verification,
    this.issueAcknowledgedDate,
    this.issueAcknowledgedRemark,
    this.issueResolvedDate,
    this.issueResolvedRemark,
    this.timeTaken,
    this.issueApprovedDate,
    this.issueApprovedRemark,
    this.issueUnverifiedDate,
    this.issueUnverifiedRemark,
    this.issueReopenedDate,
    this.issueReopenedRemark,
    this.issueCancelledDate,
    this.issueCancelledRemark,
    this.issueRaisedDate,
    this.issueCodes,
    this.ticketDate,
    this.ticketMonth,
    this.ticketYear,
    this.statusIndex,
  });

  factory TicketsLogHistory.fromJson(Map<String, dynamic> json) =>
      TicketsLogHistory(
        id: json["id"],
        description: json["description"],
        ticketNumber: json["ticket_number"],
        machineId: json["machine_id"],
        status: json["status"],
        issueCode: json["issue_code"],
        remarks: json["remarks"],
        itemCode: json["item_code"],
        locationId: json["locationId"],
        locationName: json["locationName"],
        warranty: json["warranty"],
        name: json["name"],
        createdAt: json["created_at"],
        issueRaisedAt: json["issue_raised_at"],
        issueRaisedRemark: json["issue_raised_remark"],
        verification: json["verification"],
        issueAcknowledgedDate: json["issue_acknowledged_date"],
        issueAcknowledgedRemark: json["issue_acknowledged_remark"],
        issueResolvedDate: json["issue_resolved_date"],
        issueResolvedRemark: json["issue_resolved_remark"],
        timeTaken: json["time_taken"],
        issueApprovedDate: json["issue_approved_date"],
        issueApprovedRemark: json["issue_approved_remark"],
        issueUnverifiedDate: json["issue_unverified_date"],
        issueUnverifiedRemark: json["issue_unverified_remark"],
        issueReopenedDate: json["issue_reopened_date"],
        issueReopenedRemark: json["issue_reopened_remark"],
        issueCancelledDate: json["issue_cancelled_date"],
        issueCancelledRemark: json["issue_cancelled_remark"],
        issueRaisedDate: json["issue_raised_date"],
        issueCodes: json["issue_codes"] == null
            ? []
            : List<IssueCode>.from(
                json["issue_codes"]!.map((x) => IssueCode.fromJson(x))),
        ticketDate: json["ticketDate"],
        ticketMonth: json["ticketMonth"],
        ticketYear: json["ticketYear"],
        statusIndex: json["statusIndex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "ticket_number": ticketNumber,
        "machine_id": machineId,
        "status": status,
        "issue_code": issueCode,
        "remarks": remarks,
        "item_code": itemCode,
        "locationId": locationId,
        "locationName": locationName,
        "warranty": warranty,
        "name": name,
        "created_at": createdAt,
        "issue_raised_at": issueRaisedAt,
        "issue_raised_remark": issueRaisedRemark,
        "verification": verification,
        "issue_acknowledged_date": issueAcknowledgedDate,
        "issue_acknowledged_remark": issueAcknowledgedRemark,
        "issue_resolved_date": issueResolvedDate,
        "issue_resolved_remark": issueResolvedRemark,
        "time_taken": timeTaken,
        "issue_approved_date": issueApprovedDate,
        "issue_approved_remark": issueApprovedRemark,
        "issue_unverified_date": issueUnverifiedDate,
        "issue_unverified_remark": issueUnverifiedRemark,
        "issue_reopened_date": issueReopenedDate,
        "issue_reopened_remark": issueReopenedRemark,
        "issue_cancelled_date": issueCancelledDate,
        "issue_cancelled_remark": issueCancelledRemark,
        "issue_raised_date": issueRaisedDate,
        "issue_codes": issueCodes == null
            ? []
            : List<dynamic>.from(issueCodes!.map((x) => x.toJson())),
        "ticketDate": ticketDate,
        "ticketMonth": ticketMonth,
        "ticketYear": ticketYear,
        "statusIndex": statusIndex,
      };
}

class IssueCode {
  String? issueCode;
  String? partName;

  IssueCode({
    this.issueCode,
    this.partName,
  });

  factory IssueCode.fromJson(Map<String, dynamic> json) => IssueCode(
        issueCode: json["issue_code"],
        partName: json["part_name"],
      );

  Map<String, dynamic> toJson() => {
        "issue_code": issueCode,
        "part_name": partName,
      };
}

class VendorDetail {
  String? vendorName;
  String? phoneNumber;
  String? email;
  String? location;

  VendorDetail({
    this.vendorName,
    this.phoneNumber,
    this.email,
    this.location,
  });

  factory VendorDetail.fromJson(Map<String, dynamic> json) => VendorDetail(
        vendorName: json["vendor_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_name": vendorName,
        "phone_number": phoneNumber,
        "email": email,
        "location": location,
      };
}

class RequestDetails {
  int? id;
  int? machineId;
  String? requestType;
  int? requestRaisedBy;
  int? actionBy;
  String? status;
  String? supportAttachment;
  String? requestByRemarks;
  String? actionByRemarks;
  String? actionedAt;
  String? createdAt;
  String? updatedAt;

  int? requestRaisedById;
  String? requestRaisedByName;
  int? actionById;
  String? actionByName;
  String? createdAtFormatted;
  String? actionedAtFormatted;

  RequestDetails({
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
  });

  RequestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    machineId = json['machine_id'];
    requestType = json['request_type'];
    requestRaisedBy = json['request_raised_by'];
    actionBy = json['action_by'];
    status = json['status'];
    supportAttachment = json['support_attachment'];
    requestByRemarks = json['request_by_remarks'];
    actionByRemarks = json['action_by_remarks'];
    actionedAt = json['actioned_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    requestRaisedById = json['request_raised_by_id'];
    requestRaisedByName = json['request_raised_by_name'];
    actionById = json['action_by_id'];
    actionByName = json['action_by_name'];
    createdAtFormatted = json['created_at_formatted'];
    actionedAtFormatted = json['actioned_at_formatted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['machine_id'] = machineId;
    data['request_type'] = requestType;
    data['request_raised_by'] = requestRaisedBy;
    data['action_by'] = actionBy;
    data['status'] = status;
    data['support_attachment'] = supportAttachment;
    data['request_by_remarks'] = requestByRemarks;
    data['action_by_remarks'] = actionByRemarks;
    data['actioned_at'] = actionedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    data['request_raised_by_id'] = requestRaisedById;
    data['request_raised_by_name'] = requestRaisedByName;
    data['action_by_id'] = actionById;
    data['action_by_name'] = actionByName;
    data['created_at_formatted'] = createdAtFormatted;
    data['actioned_at_formatted'] = actionedAtFormatted;

    return data;
  }
}
