import 'dart:convert';

RaiseTicketModel raiseTicketModelFromJson(String str) =>
    RaiseTicketModel.fromJson(json.decode(str));

String raiseTicketModelToJson(RaiseTicketModel data) =>
    json.encode(data.toJson());

class RaiseTicketModel {
  bool? success;
  String? message;
  Data? data;

  RaiseTicketModel({
    this.success,
    this.message,
    this.data,
  });

  factory RaiseTicketModel.fromJson(Map<String, dynamic> json) =>
      RaiseTicketModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] is Map<String, dynamic>
            ? Data.fromJson(json["data"])
            : null, // Handle cases where "data" is an empty list or null
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? ticketId;

  Data({
    this.ticketId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ticketId: json["ticket_id"],
      );

  Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
      };
}
