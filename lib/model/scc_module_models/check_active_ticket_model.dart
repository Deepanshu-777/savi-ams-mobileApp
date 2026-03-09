// To parse this JSON data, do
//
//     final checkActiveTicketModel = checkActiveTicketModelFromJson(jsonString);

import 'dart:convert';

CheckActiveTicketModel checkActiveTicketModelFromJson(String str) =>
    CheckActiveTicketModel.fromJson(json.decode(str));

String checkActiveTicketModelToJson(CheckActiveTicketModel data) =>
    json.encode(data.toJson());

class CheckActiveTicketModel {
  bool success;
  String message;
  Data data;

  CheckActiveTicketModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CheckActiveTicketModel.fromJson(Map<String, dynamic> json) =>
      CheckActiveTicketModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String? message;
  String? ticketNumber;
  TicketDetails? ticketDetails;

  Data({
    required this.message,
    required this.ticketNumber,
    required this.ticketDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] ?? "", // Handle null
        ticketNumber: json["ticket_number"] ?? "", // Handle null
        ticketDetails: json["ticket_details"] != null
            ? TicketDetails.fromJson(json["ticket_details"])
            : null, // Handle null
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "ticket_number": ticketNumber,
        "ticket_details": ticketDetails?.toJson(),
      };
}

class TicketDetails {
  int id;
  int userId;
  String? ticketNumber;
  String? batchNo;
  String? batchTicketId;
  String? machineName;
  String? machineId;
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
  int reopenCount;
  String? isTicketCancelled;
  String? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? raisedBy;

  TicketDetails({
    required this.id,
    required this.userId,
    required this.ticketNumber,
    required this.batchNo,
    required this.batchTicketId,
    required this.machineName,
    required this.machineId,
    required this.issueCode,
    required this.priority,
    required this.venderName,
    required this.venderNumber,
    required this.attachment,
    required this.description,
    required this.status,
    required this.assignee,
    required this.assigneeType,
    required this.workingStatus,
    required this.estimatedDate,
    required this.remarks,
    required this.reopenCount,
    required this.isTicketCancelled,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.raisedBy,
  });

  factory TicketDetails.fromJson(Map<String, dynamic> json) => TicketDetails(
        id: json["id"] ?? 0,
        userId: json["user_id"] ?? 0,
        ticketNumber: json["ticket_number"] ?? "",
        batchNo: json["batch_no"] ?? "",
        batchTicketId: json["batch_ticket_id"] ?? "",
        machineName: json["machine_name"] ?? "",
        machineId: json["machine_id"] ?? "",
        issueCode: json["issue_code"] ?? "",
        priority: json["priority"] ?? "",
        venderName: json["vender_name"] ?? "",
        venderNumber: json["vender_number"] ?? "",
        attachment: json["attachment"],
        description: json["description"] ?? "",
        status: json["status"] ?? "",
        assignee: json["assignee"],
        assigneeType: json["assignee_type"] ?? "",
        workingStatus: json["working_status"] ?? "",
        estimatedDate: json["estimated_date"],
        remarks: json["remarks"],
        reopenCount: json["reopen_count"] ?? 0,
        isTicketCancelled: json["is_ticket_cancelled"] ?? "0",
        isDeleted: json["is_deleted"] ?? "0",
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null, // Handle null date
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null, // Handle null date
        raisedBy: json["raisedBy"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ticket_number": ticketNumber,
        "batch_no": batchNo,
        "batch_ticket_id": batchTicketId,
        "machine_name": machineName,
        "machine_id": machineId,
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
        "is_deleted": isDeleted,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "raisedBy": raisedBy,
      };
}
