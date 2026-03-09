import 'dart:convert';
import 'package:get/get.dart';
import 'package:rail_weld/routes/app_pages.dart';
import '../../../model/scc_module_models/get_ticket_report.dart';
import '../../../model/scc_module_models/ticket_detail_model.dart';
import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';
import '../../../storage/storage.dart';
import '../../../widgets/download_file.dart';

class TicketRaisedController extends GetxController {
  Rx<TicketDetailModel> ticketDetailRes = TicketDetailModel().obs;
  String? id = "";

  Future<void> ticketDetail({
    String? ticketId,
  }) async {
    id = ticketId;
    final response = await NetworkRequester().post(
      api: () async => await ticketDetail(),
      path: Urls.TICKETDETAIL,
      data: {
        "user_id": Storage.getUserId(),
        "ticket_id": ticketId,
      },
    );

    if (response != null) {
      if (jsonDecode(jsonEncode(response))["success"] == true) {
        ticketDetailRes.value = ticketDetailModelFromJson(
          jsonEncode(response),
        );
        Get.toNamed(Routes.TICKETRAISED);
      }
    }
  }

  Rx<GetTicketReport> ticketReport = GetTicketReport().obs;

  Future<void> getTicketReport({
    bool isLoader = true,
  }) async {
    final response = await NetworkRequester().post(
      isLoader: isLoader,
      api: () async => await getTicketReport(),
      data: {
        "ticket_id": id,
      },
      path: Urls.TICKETREPORT,
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        ticketReport.value = getTicketReportFromJson(jsonEncode(response));
        await downloadMaintenanceReport(
          fileName:
              ticketReport.value.data?.ticketReportPdfDetails?.pdfName ?? "",
          base64String:
              ticketReport.value.data?.ticketReportPdfDetails?.pdfContent ?? "",
        );
        Get.offAllNamed(Routes.MAINVIEW);
      }
    }
  }
}
