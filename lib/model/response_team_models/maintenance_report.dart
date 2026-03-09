import 'dart:convert';

GetMaintenanceReport getMaintenanceReportFromJson(String str) =>
    GetMaintenanceReport.fromJson(json.decode(str));

String getMaintenanceReportToJson(GetMaintenanceReport data) =>
    json.encode(data.toJson());

class GetMaintenanceReport {
  bool? success;
  String? message;
  Data? data;

  GetMaintenanceReport({
    this.success,
    this.message,
    this.data,
  });

  factory GetMaintenanceReport.fromJson(Map<String, dynamic> json) =>
      GetMaintenanceReport(
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
  MaintenenceReportPdfDetails? maintenenceReportPdfDetails;

  Data({
    this.maintenenceReportPdfDetails,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        maintenenceReportPdfDetails:
            json["Maintenence Report Pdf Details"] == null
                ? null
                : MaintenenceReportPdfDetails.fromJson(
                    json["Maintenence Report Pdf Details"]),
      );

  Map<String, dynamic> toJson() => {
        "Maintenence Report Pdf Details": maintenenceReportPdfDetails?.toJson(),
      };
}

class MaintenenceReportPdfDetails {
  String? pdfName;
  String? pdfContent;

  MaintenenceReportPdfDetails({
    this.pdfName,
    this.pdfContent,
  });

  factory MaintenenceReportPdfDetails.fromJson(Map<String, dynamic> json) =>
      MaintenenceReportPdfDetails(
        pdfName: json["pdf_name"],
        pdfContent: json["pdf_content"],
      );

  Map<String, dynamic> toJson() => {
        "pdf_name": pdfName,
        "pdf_content": pdfContent,
      };
}
