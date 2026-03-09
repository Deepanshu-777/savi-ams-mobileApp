import 'dart:convert';

GetTicketReport getTicketReportFromJson(String str) =>
    GetTicketReport.fromJson(json.decode(str));

String getTicketReportToJson(GetTicketReport data) =>
    json.encode(data.toJson());

class GetTicketReport {
  bool? success;
  String? message;
  Data? data;

  GetTicketReport({
    this.success,
    this.message,
    this.data,
  });

  factory GetTicketReport.fromJson(Map<String, dynamic> json) =>
      GetTicketReport(
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
  TicketReportPdfDetails? ticketReportPdfDetails;

  Data({
    this.ticketReportPdfDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ticketReportPdfDetails: json["Ticket Report Pdf Details"] == null
            ? null
            : TicketReportPdfDetails.fromJson(
                json["Ticket Report Pdf Details"]),
      );

  Map<String, dynamic> toJson() => {
        "Ticket Report Pdf Details": ticketReportPdfDetails?.toJson(),
      };
}

class TicketReportPdfDetails {
  String? pdfName;
  String? pdfContent;
  String? pdfUrl;

  TicketReportPdfDetails({
    this.pdfName,
    this.pdfContent,
    this.pdfUrl,
  });

  factory TicketReportPdfDetails.fromJson(Map<String, dynamic> json) =>
      TicketReportPdfDetails(
        pdfName: json["pdf_name"],
        pdfContent: json["pdf_content"],
        pdfUrl: json["pdf_url"],
      );

  Map<String, dynamic> toJson() => {
        "pdf_name": pdfName,
        "pdf_content": pdfContent,
        "pdf_url": pdfUrl,
      };
}
