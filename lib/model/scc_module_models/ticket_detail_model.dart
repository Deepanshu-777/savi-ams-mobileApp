// To parse this JSON data, do
//
//     final ticketDetailModel = ticketDetailModelFromJson(jsonString);

import 'dart:convert';

TicketDetailModel ticketDetailModelFromJson(String str) =>
    TicketDetailModel.fromJson(json.decode(str));

String ticketDetailModelToJson(TicketDetailModel data) =>
    json.encode(data.toJson());

class TicketDetailModel {
  bool? success;
  String? message;
  Data? data;

  TicketDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory TicketDetailModel.fromJson(Map<String, dynamic> json) =>
      TicketDetailModel(
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
  Ticketetail? ticketetail;

  Data({
    this.ticketetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ticketetail: json["ticketetail"] == null
            ? null
            : Ticketetail.fromJson(json["ticketetail"]),
      );

  Map<String, dynamic> toJson() => {
        "ticketetail": ticketetail?.toJson(),
      };
}

class Ticketetail {
  int? id;
  int? userId;
  String? ticketNumber;
  String? batchNo;
  String? batchTicketId;
  String? machineName;
  String? machineId;
  String? empName;
  String? designation;
  String? phone;
  String? issueCode;
  String? priority;
  String? venderName;
  String? venderNumber;
  dynamic attachment;
  String? description;
  String? status;
  dynamic assignee;
  String? assigneeType;
  String? workingStatus;
  dynamic estimatedDate;
  dynamic remarks;
  int? reopenCount;
  String? isTicketCancelled;
  dynamic ticketRequestId;
  dynamic repairCost;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? make;
  String? model;
  String? poNumber;
  String? expiryLife;
  String? location;
  String? locationName;
  String? itemCode;
  DateTime? dateOfCommissioning;
  int? warranty;
  String? underAmc;
  DateTime? amcWarrantyFrom;
  DateTime? amcWarrantyTo;
  String? vendorEmailAddress;
  String? machineImage;
  String? machineDesc;
  String? poDate;
  String? raisedBy;
  String? createdAtDate;
  String? createdAtTime;
  String? warrantyDate;
  String? codalLife;
  String? shop;
  List<IssueCode>? issueCodes;
  List<Attachment>? attachments;
  String? warrantyStatus;
  List<Log>? logs;
  String? currentStatus;
  String? lastIssueRaisedOn;
  String? lastIssueResolvedOn;

  Ticketetail({
    this.id,
    this.userId,
    this.ticketNumber,
    this.batchNo,
    this.batchTicketId,
    this.machineName,
    this.machineId,
    this.empName,
    this.designation,
    this.phone,
    this.issueCode,
    this.priority,
    this.venderName,
    this.venderNumber,
    this.attachment,
    this.description,
    this.status,
    this.assignee,
    this.assigneeType,
    this.workingStatus,
    this.estimatedDate,
    this.remarks,
    this.reopenCount,
    this.isTicketCancelled,
    this.ticketRequestId,
    this.repairCost,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.make,
    this.model,
    this.poNumber,
    this.expiryLife,
    this.location,
    this.locationName,
    this.itemCode,
    this.dateOfCommissioning,
    this.warranty,
    this.underAmc,
    this.amcWarrantyFrom,
    this.amcWarrantyTo,
    this.vendorEmailAddress,
    this.machineImage,
    this.machineDesc,
    this.poDate,
    this.raisedBy,
    this.createdAtDate,
    this.createdAtTime,
    this.warrantyDate,
    this.codalLife,
    this.shop,
    this.issueCodes,
    this.attachments,
    this.warrantyStatus,
    this.logs,
    this.currentStatus,
    this.lastIssueRaisedOn,
    this.lastIssueResolvedOn,
  });

  factory Ticketetail.fromJson(Map<String, dynamic> json) => Ticketetail(
        id: json["id"],
        userId: json["user_id"],
        ticketNumber: json["ticket_number"],
        batchNo: json["batch_no"],
        batchTicketId: json["batch_ticket_id"],
        machineName: json["machine_name"],
        machineId: json["machine_id"],
        empName: json["emp_name"],
        designation: json["designation"],
        phone: json["phone"],
        issueCode: json["issue_code"],
        priority: json["priority"],
        venderName: json["vender_name"],
        venderNumber: json["vender_number"],
        attachment: json["attachment"],
        description: json["description"],
        status: json["status"],
        assignee: json["assignee"],
        assigneeType: json["assignee_type"],
        workingStatus: json["working_status"],
        estimatedDate: json["estimated_date"],
        remarks: json["remarks"],
        reopenCount: json["reopen_count"],
        isTicketCancelled: json["is_ticket_cancelled"],
        ticketRequestId: json["ticket_request_id"],
        repairCost: json["repair_cost"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        make: json["make"],
        model: json["model"],
        poNumber: json["po_number"],
        expiryLife: json["expiry_life"],
        location: json["location"],
        locationName: json["location_name"],
        itemCode: json["item_code"],
        dateOfCommissioning: json["date_of_commissioning"] == null
            ? null
            : DateTime.parse(json["date_of_commissioning"]),
        warranty: json["warranty"],
        underAmc: json["under_amc"],
        amcWarrantyFrom: json["amc_warranty_from"] == null
            ? null
            : DateTime.parse(json["amc_warranty_from"]),
        amcWarrantyTo: json["amc_warranty_to"] == null
            ? null
            : DateTime.parse(json["amc_warranty_to"]),
        vendorEmailAddress: json["vendor_email_address"],
        machineImage: json["machine_image"],
        machineDesc: json["machine_desc"],
        poDate: json["po_date"],
        raisedBy: json["raisedBy"],
        createdAtDate: json["created_at_date"],
        createdAtTime: json["created_at_time"],
        warrantyDate: json["warrantyDate"],
        codalLife: json["codalLife"],
        shop: json["shop"],
        issueCodes: json["issue_codes"] == null
            ? []
            : List<IssueCode>.from(
                json["issue_codes"]!.map((x) => IssueCode.fromJson(x))),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        warrantyStatus: json["warrantyStatus"],
        logs: json["logs"] == null
            ? []
            : List<Log>.from(json["logs"]!.map((x) => Log.fromJson(x))),
        currentStatus: json["current_status"],
        lastIssueRaisedOn: json["last_issue_raised_on"],
        lastIssueResolvedOn: json["last_issue_resolved_on"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ticket_number": ticketNumber,
        "batch_no": batchNo,
        "batch_ticket_id": batchTicketId,
        "machine_name": machineName,
        "machine_id": machineId,
        "emp_name": empName,
        "designation": designation,
        "phone": phone,
        "issue_code": issueCode,
        "priority": priority,
        "vender_name": venderName,
        "vender_number": venderNumber,
        "attachment": attachment,
        "description": description,
        "status": status,
        "assignee": assignee,
        "assignee_type": assigneeType,
        "working_status": workingStatus,
        "estimated_date": estimatedDate,
        "remarks": remarks,
        "reopen_count": reopenCount,
        "is_ticket_cancelled": isTicketCancelled,
        "ticket_request_id": ticketRequestId,
        "repair_cost": repairCost,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "make": make,
        "model": model,
        "po_number": poNumber,
        "expiry_life": expiryLife,
        "location": location,
        "location_name": locationName,
        "item_code": itemCode,
        "date_of_commissioning":
            "${dateOfCommissioning!.year.toString().padLeft(4, '0')}-${dateOfCommissioning!.month.toString().padLeft(2, '0')}-${dateOfCommissioning!.day.toString().padLeft(2, '0')}",
        "warranty": warranty,
        "under_amc": underAmc,
        "amc_warranty_from":
            "${amcWarrantyFrom!.year.toString().padLeft(4, '0')}-${amcWarrantyFrom!.month.toString().padLeft(2, '0')}-${amcWarrantyFrom!.day.toString().padLeft(2, '0')}",
        "amc_warranty_to":
            "${amcWarrantyTo!.year.toString().padLeft(4, '0')}-${amcWarrantyTo!.month.toString().padLeft(2, '0')}-${amcWarrantyTo!.day.toString().padLeft(2, '0')}",
        "vendor_email_address": vendorEmailAddress,
        "machine_image": machineImage,
        "machine_desc": machineDesc,
        "po_date": poDate,
        "raisedBy": raisedBy,
        "created_at_date": createdAtDate,
        "created_at_time": createdAtTime,
        "warrantyDate": warrantyDate,
        "codalLife": codalLife,
        "shop": shop,
        "issue_codes": issueCodes == null
            ? []
            : List<dynamic>.from(issueCodes!.map((x) => x.toJson())),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "warrantyStatus": warrantyStatus,
        "logs": logs == null
            ? []
            : List<dynamic>.from(logs!.map((x) => x.toJson())),
        "current_status": currentStatus,
        "last_issue_raised_on": lastIssueRaisedOn,
        "last_issue_resolved_on": lastIssueResolvedOn,
      };
}

class Attachment {
  String? name;

  Attachment({
    this.name,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
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

class Log {
  String? action;
  String? remarks;
  String? changedBy;
  String? estimatedDate;
  String? actionDate;
  String? actionMonth;
  String? actionYear;
  String? actionTime;

  Log({
    this.action,
    this.remarks,
    this.changedBy,
    this.estimatedDate,
    this.actionDate,
    this.actionMonth,
    this.actionYear,
    this.actionTime,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        action: json["action"],
        remarks: json["remarks"],
        changedBy: json["changed_by"],
        estimatedDate: json["estimated_date"],
        actionDate: json["actionDate"],
        actionMonth: json["actionMonth"],
        actionYear: json["actionYear"],
        actionTime: json["actionTime"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "remarks": remarks,
        "changed_by": changedBy,
        "estimated_date": estimatedDate,
        "actionDate": actionDate,
        "actionMonth": actionMonth,
        "actionYear": actionYear,
        "actionTime": actionTime,
      };
}
