import 'dart:convert';

ResponseTeamHome responseTeamHomeFromJson(String str) =>
    ResponseTeamHome.fromJson(json.decode(str));

String responseTeamHomeToJson(ResponseTeamHome data) =>
    json.encode(data.toJson());

class ResponseTeamHome {
  bool? success;
  String? message;
  Data? data;

  ResponseTeamHome({
    this.success,
    this.message,
    this.data,
  });

  factory ResponseTeamHome.fromJson(Map<String, dynamic> json) =>
      ResponseTeamHome(
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
  Tickets? tickets;

  HomeDataSse({
    this.userData,
    this.tickets,
  });

  factory HomeDataSse.fromJson(Map<String, dynamic> json) => HomeDataSse(
        userData: json["userData"] == null
            ? null
            : UserData.fromJson(json["userData"]),
        tickets:
            json["tickets"] == null ? null : Tickets.fromJson(json["tickets"]),
      );

  Map<String, dynamic> toJson() => {
        "userData": userData?.toJson(),
        "tickets": tickets?.toJson(),
      };
}

class Tickets {
  int? totalTicketAssigned;
  int? todayTicketsAdded;
  int? totalTicketResolved;
  int? totalTicketAcknowledged;
  int? ticketsRejected;
  int? ticketsApproved;

  Tickets({
    this.totalTicketAssigned,
    this.todayTicketsAdded,
    this.totalTicketResolved,
    this.totalTicketAcknowledged,
    this.ticketsRejected,
    this.ticketsApproved,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        totalTicketAssigned: json["totalTicketAssigned"],
        todayTicketsAdded: json["todayTicketsAdded"],
        totalTicketResolved: json["totalTicketResolved"],
        totalTicketAcknowledged: json["totalTicketAcknowledged"],
        ticketsRejected: json["ticketsRejected"],
        ticketsApproved: json["ticketsApproved"],
      );

  Map<String, dynamic> toJson() => {
        "totalTicketAssigned": totalTicketAssigned,
        "todayTicketsAdded": todayTicketsAdded,
        "totalTicketResolved": totalTicketResolved,
        "totalTicketAcknowledged": totalTicketAcknowledged,
        "ticketsRejected": ticketsRejected,
        "ticketsApproved": ticketsApproved,
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
