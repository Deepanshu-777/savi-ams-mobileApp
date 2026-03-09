// To parse this JSON data, do
//
//     final ticketListing = ticketListingFromJson(jsonString);

import 'dart:convert';

TicketListing ticketListingFromJson(String str) =>
    TicketListing.fromJson(json.decode(str));

String ticketListingToJson(TicketListing data) => json.encode(data.toJson());

class TicketListing {
  bool? success;
  String? message;
  Data? data;

  TicketListing({
    this.success,
    this.message,
    this.data,
  });

  factory TicketListing.fromJson(Map<String, dynamic> json) => TicketListing(
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
  TicketsList? ticketsList;

  Data({
    this.ticketsList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ticketsList: json["Tickets List"] == null
            ? null
            : TicketsList.fromJson(json["Tickets List"]),
      );

  Map<String, dynamic> toJson() => {
        "Tickets List": ticketsList?.toJson(),
      };
}

class TicketsList {
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

  TicketsList({
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

  factory TicketsList.fromJson(Map<String, dynamic> json) => TicketsList(
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
  int? userId;
  String? ticketNumber;
  String? machineName;
  String? machineId;
  String? priority;
  String? venderName;
  String? venderNumber;
  dynamic attachment;
  String? description;
  String? status;
  int? assignee;
  String? workingStatus;
  DateTime? estimatedDate;
  String? remarks;
  int? reopenCount;
  String? isTicketCancelled;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? itemCode;
  String? make;
  String? location;
  DateTime? dateOfCommissioning;
  int? warranty;
  String? underAmc;
  DateTime? amcWarrantyFrom;
  DateTime? amcWarrantyTo;
  String? raisedBy;
  String? createdAtDate;
  String? createdAtTime;
  List<IssueCode>? issueCodes;
  String? warrantyStatus;
  String? ticketRaisedOn;
  String? ticketAcknowledgedOn;
  String? ticketResolvedOn;
  dynamic ticketApprovedOn;
  dynamic ticketRejectedOn;
  dynamic ticketReOpenedOn;
  String? ticketCancelledOn;

  Datum({
    this.id,
    this.userId,
    this.ticketNumber,
    this.machineName,
    this.machineId,
    this.priority,
    this.venderName,
    this.venderNumber,
    this.attachment,
    this.description,
    this.status,
    this.assignee,
    this.workingStatus,
    this.estimatedDate,
    this.remarks,
    this.reopenCount,
    this.isTicketCancelled,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.itemCode,
    this.make,
    this.location,
    this.dateOfCommissioning,
    this.warranty,
    this.underAmc,
    this.amcWarrantyFrom,
    this.amcWarrantyTo,
    this.raisedBy,
    this.createdAtDate,
    this.createdAtTime,
    this.issueCodes,
    this.warrantyStatus,
    this.ticketRaisedOn,
    this.ticketAcknowledgedOn,
    this.ticketResolvedOn,
    this.ticketApprovedOn,
    this.ticketRejectedOn,
    this.ticketReOpenedOn,
    this.ticketCancelledOn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        ticketNumber: json["ticket_number"],
        machineName: json["machine_name"],
        machineId: json["machine_id"],
        priority: json["priority"],
        venderName: json["vender_name"],
        venderNumber: json["vender_number"],
        attachment: json["attachment"],
        description: json["description"],
        status: json["status"],
        assignee: json["assignee"],
        workingStatus: json["working_status"],
        estimatedDate: json["estimated_date"] == null
            ? null
            : DateTime.parse(json["estimated_date"]),
        remarks: json["remarks"],
        reopenCount: json["reopen_count"],
        isTicketCancelled: json["is_ticket_cancelled"],
        isDeleted: json["is_deleted"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        itemCode: json["item_code"],
        make: json["make"],
        location: json["location"],
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
        raisedBy: json["raisedBy"],
        createdAtDate: json["created_at_date"],
        createdAtTime: json["created_at_time"],
        issueCodes: json["issue_codes"] == null
            ? []
            : List<IssueCode>.from(
                json["issue_codes"]!.map((x) => IssueCode.fromJson(x))),
        warrantyStatus: json["warrantyStatus"],
        ticketRaisedOn: json["ticketRaisedOn"],
        ticketAcknowledgedOn: json["ticketAcknowledgedOn"],
        ticketResolvedOn: json["ticketResolvedOn"],
        ticketApprovedOn: json["ticketApprovedOn"],
        ticketRejectedOn: json["ticketRejectedOn"],
        ticketReOpenedOn: json["ticketReOpenedOn"],
        ticketCancelledOn: json["ticketCancelledOn"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ticket_number": ticketNumber,
        "machine_name": machineName,
        "machine_id": machineId,
        "priority": priority,
        "vender_name": venderName,
        "vender_number": venderNumber,
        "attachment": attachment,
        "description": description,
        "status": status,
        "assignee": assignee,
        "working_status": workingStatus,
        "estimated_date":
            "${estimatedDate!.year.toString().padLeft(4, '0')}-${estimatedDate!.month.toString().padLeft(2, '0')}-${estimatedDate!.day.toString().padLeft(2, '0')}",
        "remarks": remarks,
        "reopen_count": reopenCount,
        "is_ticket_cancelled": isTicketCancelled,
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "item_code": itemCode,
        "make": make,
        "location": location,
        "date_of_commissioning":
            "${dateOfCommissioning!.year.toString().padLeft(4, '0')}-${dateOfCommissioning!.month.toString().padLeft(2, '0')}-${dateOfCommissioning!.day.toString().padLeft(2, '0')}",
        "warranty": warranty,
        "under_amc": underAmc,
        "amc_warranty_from":
            "${amcWarrantyFrom!.year.toString().padLeft(4, '0')}-${amcWarrantyFrom!.month.toString().padLeft(2, '0')}-${amcWarrantyFrom!.day.toString().padLeft(2, '0')}",
        "amc_warranty_to":
            "${amcWarrantyTo!.year.toString().padLeft(4, '0')}-${amcWarrantyTo!.month.toString().padLeft(2, '0')}-${amcWarrantyTo!.day.toString().padLeft(2, '0')}",
        "raisedBy": raisedBy,
        "created_at_date": createdAtDate,
        "created_at_time": createdAtTime,
        "issue_codes": issueCodes == null
            ? []
            : List<dynamic>.from(issueCodes!.map((x) => x.toJson())),
        "warrantyStatus": warrantyStatus,
        "ticketRaisedOn": ticketRaisedOn,
        "ticketAcknowledgedOn": ticketAcknowledgedOn,
        "ticketResolvedOn": ticketResolvedOn,
        "ticketApprovedOn": ticketApprovedOn,
        "ticketRejectedOn": ticketRejectedOn,
        "ticketReOpenedOn": ticketReOpenedOn,
        "ticketCancelledOn": ticketCancelledOn,
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
