import 'dart:convert';

SscHomeData sscHomeDataFromJson(String str) =>
    SscHomeData.fromJson(json.decode(str));

String sscHomeDataToJson(SscHomeData data) => json.encode(data.toJson());

class SscHomeData {
  bool? success;
  String? message;
  Data? data;

  SscHomeData({
    this.success,
    this.message,
    this.data,
  });

  factory SscHomeData.fromJson(Map<String, dynamic> json) => SscHomeData(
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
  HomeDataSse? homeDataSse;

  Data({
    this.homeDataSse,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        homeDataSse: json["Home Data SSE"] == null
            ? null
            : HomeDataSse.fromJson(json["Home Data SSE"]),
      );

  Map<String, dynamic> toJson() => {
        "Home Data SSE": homeDataSse?.toJson(),
      };
}

class HomeDataSse {
  UserData? userData;
  Machines? machines;
  Tickets? tickets;

  HomeDataSse({
    this.userData,
    this.machines,
    this.tickets,
  });

  factory HomeDataSse.fromJson(Map<String, dynamic> json) => HomeDataSse(
        userData: json["userData"] == null
            ? null
            : UserData.fromJson(json["userData"]),
        machines: json["machines"] == null
            ? null
            : Machines.fromJson(json["machines"]),
        tickets:
            json["tickets"] == null ? null : Tickets.fromJson(json["tickets"]),
      );

  Map<String, dynamic> toJson() => {
        "userData": userData?.toJson(),
        "machines": machines?.toJson(),
        "tickets": tickets?.toJson(),
      };
}

class Machines {
  int? totalMachineCount;
  int? activeMachineCount;
  int? inActiveMachineCount;
  int? abandonedMachineCount;

  Machines({
    this.totalMachineCount,
    this.activeMachineCount,
    this.inActiveMachineCount,
    this.abandonedMachineCount,
  });

  factory Machines.fromJson(Map<String, dynamic> json) => Machines(
        totalMachineCount: json["totalMachineCount"],
        activeMachineCount: json["activeMachineCount"],
        inActiveMachineCount: json["inActiveMachineCount"],
        abandonedMachineCount: json["abandonedMachineCount"],
      );

  Map<String, dynamic> toJson() => {
        "totalMachineCount": totalMachineCount,
        "activeMachineCount": activeMachineCount,
        "inActiveMachineCount": inActiveMachineCount,
        "abandonedMachineCount": abandonedMachineCount,
      };
}

class Tickets {
  int? totalTicketData;
  int? todayTicketsAdded;
  int? resolvedTicketData;
  int? pendingTicketData;
  String? abondonedTicketData;
  int? ticketsApproved;
  int? ticketsUnverified;
  int? allTickets;

  Tickets({
    this.totalTicketData,
    this.todayTicketsAdded,
    this.resolvedTicketData,
    this.pendingTicketData,
    this.abondonedTicketData,
    this.ticketsApproved,
    this.ticketsUnverified,
    this.allTickets,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        totalTicketData: json["totalTicketData"],
        todayTicketsAdded: json["todayTicketsAdded"],
        resolvedTicketData: json["resolvedTicketData"],
        pendingTicketData: json["pendingTicketData"],
        abondonedTicketData: json["abondonedTicketData"],
        ticketsApproved: json["ticketsApproved"],
        ticketsUnverified: json["ticketsUnverified"],
        allTickets: json["allTickets"],
      );

  Map<String, dynamic> toJson() => {
        "totalTicketData": totalTicketData,
        "todayTicketsAdded": todayTicketsAdded,
        "resolvedTicketData": resolvedTicketData,
        "pendingTicketData": pendingTicketData,
        "abondonedTicketData": abondonedTicketData,
        "ticketsApproved": ticketsApproved,
        "ticketsUnverified": ticketsUnverified,
        "allTickets": allTickets,
      };
}

class UserData {
  int? userId;
  String? userName;
  String? profilePicture;

  UserData({
    this.userId,
    this.userName,
    this.profilePicture,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["user_id"],
        userName: json["user_name"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "profile_picture": profilePicture,
      };
}