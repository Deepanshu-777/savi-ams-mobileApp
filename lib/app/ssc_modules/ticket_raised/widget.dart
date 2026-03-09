import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/ticket_raised_controller.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/theme/app_colors.dart';
import '../../../model/scc_module_models/ticket_detail_model.dart';
import '../../../routes/img_routes.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/decorated_box.dart';

Widget body({
  double height = 20,
  double width = 20,
}) {
  TicketRaisedController controller = Get.find<TicketRaisedController>();
  Ticketetail? ticketetail = controller.ticketDetailRes.value.data?.ticketetail;
  return decoratedBox(
    width: width,
    padding: EdgeInsets.only(
      top: 25,
      left: width * 0.055,
      right: width * 0.055,
      bottom: 80,
    ),
    children: [
      Expanded(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(ImgRoutes.COMPLIANT),
                        customSizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mediumText(
                              title: Strings.TICKETRAISED,
                              fontColor: AppColors.navyBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              textAlign: TextAlign.center,
                            ),
                            customSizedBox(height: 6),
                            Row(
                              children: [
                                smallText(
                                  title: Strings.TICKETNUM,
                                  fontColor: AppColors.grey,
                                  textAlign: TextAlign.center,
                                ),
                                smallText(
                                  title: ticketetail?.ticketNumber ?? "",
                                  fontColor: AppColors.navyBlue,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              customSizedBox(height: 20),
              largeText(
                title: ticketetail?.machineName ?? "",
                fontSize: 16,
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 14),
              largeText(
                title: Strings.ACKNOTE,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.blackD,
              ),
              customSizedBox(height: 19),
              detail(
                Strings.RAISEDDATE,
                ticketetail?.createdAtDate ?? "",
              ),
              detail(
                Strings.RAISEDTIME,
                ticketetail?.createdAtTime ?? "",
              ),
              detail(
                Strings.RAISEDBY,
                ticketetail?.empName ?? "",
              ),
              detail(
                Strings.PLANTNO,
                ticketetail?.itemCode ?? "",
              ),
              detail(
                Strings.ASSIGNEDTO,
                ticketetail?.assigneeType ?? "",
              ),
              detail(
                Strings.PRIORITY,
                ticketetail?.priority ?? "",
              ),
              detail(
                Strings.LOCATION,
                ticketetail?.locationName ?? "",
              ),
              if (ticketetail?.repairCost != null)
                detail(
                  Strings.REPAIRCOST,
                  "₹ ${ticketetail?.repairCost ?? ""}",
                ),
              detail(
                Strings.AMC,
                ticketetail?.warrantyStatus ?? "",
              ),
              detail(
                Strings.VENDORNAME,
                ticketetail?.venderName ?? "",
              ),
              detail(
                Strings.VENDORNUM,
                ticketetail?.venderNumber ?? "",
              ),
              customSizedBox(height: 10),
              smallText(
                title: Strings.ISSUEDETAILDESC,
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 10),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ticketetail?.issueCodes?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 1,
                          backgroundColor: AppColors.black,
                        ),
                        customSizedBox(width: 8),
                        smallText(
                          title:
                              "${ticketetail?.issueCodes?[index].issueCode ?? ""}  |  ${ticketetail?.issueCodes?[index].partName ?? ""}",
                          fontColor: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  );
                },
              ),
              customSizedBox(height: 6),
              mediumText(
                title: ticketetail?.description ?? "",
                fontWeight: FontWeight.w600,
                fontSize: 13,
                fontColor: AppColors.black,
                height: 1.7,
              ),
              ticketetail?.attachments?.length == 0
                  ? const SizedBox()
                  : ticketAttachments(width: width),
              customSizedBox(height: 41),
            ],
          ),
        ),
      )
    ],
  );
}

Widget detail(
  String title,
  String val,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: detailTitle(title: title),
        ),
        customSizedBox(width: 20),
        detailTitle(title: " : "),
        customSizedBox(width: 20),
        Expanded(
          child: detailValue(
            title: val,
            color: val == "Low"
                ? AppColors.green
                : val == "Medium"
                    ? AppColors.yellow
                    : val == "High"
                        ? AppColors.red
                        : AppColors.black,
          ),
        ),
      ],
    ),
  );
}

Widget detailValue({
  required String title,
  Color color = AppColors.black,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.4),
    child: smallText(
      title: title,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontColor: color,
      maxLines: 1,
    ),
  );
}

Widget detailTitle({
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 11),
    child: smallText(
      title: title,
      fontSize: 14,
      maxLines: 4,
      fontColor: AppColors.black,
    ),
  );
}

Widget ticketAttachments({
  double width = 20,
}) {
  TicketRaisedController controller = Get.find<TicketRaisedController>();
  Ticketetail? ticketetail = controller.ticketDetailRes.value.data?.ticketetail;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customSizedBox(height: 29),
      smallText(
        title: "Attachments",
        fontColor: AppColors.black,
      ),
      customSizedBox(height: 10),
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 15,
        spacing: 10,
        children: List<Widget>.generate(
          ticketetail?.attachments?.length ?? 0,
          (index) => Container(
            height: 100,
            width: width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                width: 0.7,
                color: AppColors.black,
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      ticketetail?.attachments?[index].name ?? "")),
            ),
          ),
          growable: true,
        ),
      ),
    ],
  );
}

Widget webView({
  double height = 20,
  double width = 20,
}) {
  TicketRaisedController controller = Get.find<TicketRaisedController>();
  return Scaffold(
    body: Stack(
      children: [
        InAppWebView(
          onWebViewCreated: (
            InAppWebViewController webViewController,
          ) {
            // controller.inAppWebViewController = webViewController;
          },
          initialUrlRequest: URLRequest(
            url: WebUri(
              "https://dev-railweld.fictivebox.tech/user/download-ticket-report?ticket_id=1&token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbG9jYWxob3N0L3JhaWx3ZWxkL3B1YmxpYy9hcGkvbG9naW4iLCJpYXQiOjE3MjQ5MjQwMTAsImV4cCI6MTcyNTc4ODAxMCwibmJmIjoxNzI0OTI0MDEwLCJqdGkiOiJIQ3pTYVNuNlZwSkFuVGV0Iiwic3ViIjoiMTQiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.-6LmD5pklei-0hHHmoOXm49u9N0RkDbCm1f1pE6BTl4",
            ),
          ),
          onProgressChanged: (
            InAppWebViewController webController,
            int progress,
          ) {
            // controller.webPageProgress.value = progress;
          },
          onLoadStop: (webController, url) {
            // controller.url = "";
          },
          onDownloadStartRequest: (
            webController,
            file,
          ) {
            // controller.downloadFile(
            //   fileUrl: file.url.toString(),
            // );
          },
          onReceivedError: (
            webController,
            WebResourceRequest request,
            WebResourceError error,
          ) async {
            log("Error : $error");
            // controller.openWhatsapp(
            //   url: request.url.toString(),
            // );
          },
        ),
        // SizedBox(
        //   height: height,
        //   child: Center(
        //     child: Obx(
        //       () => (controller.webPageProgress.value < 70 &&
        //               controller.url != "")
        //           ? Container(
        //               height: height,
        //               width: width,
        //               decoration: const BoxDecoration(
        //                 color: AppColors.white,
        //                 image: DecorationImage(
        //                   fit: BoxFit.cover,
        //                   image: AssetImage(
        //                     ImgRoutes.LOADERBG,
        //                   ),
        //                 ),
        //               ),
        //             )
        //           : const SizedBox(),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: height,
        //   child: Center(
        //     child: Obx(
        //       () => controller.webPageProgress.value < 70
        //           ? const CircularProgressIndicator(
        //               color: AppColors.blue,
        //             )
        //           : const SizedBox(),
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
