import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rail_weld/app/response_team_module/ticket_detail/ticket_detail_controller.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/widgets/custom_rich_text.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import 'package:slider_button/slider_button.dart';
import '../../../data/strings.dart';
import '../../../model/scc_module_models/ticket_detail_model.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/attachment_viewer.dart';
import '../../../widgets/custom_date_container.dart';
import '../../../widgets/custom_popup.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/decorated_box.dart';
import '../../../widgets/sheet_topbar.dart';
import '../../ssc_modules/machine_details/widget.dart' as m;
import '../../ssc_modules/ticket_raised/widget.dart';

Widget bodyNew({
  double height = 20,
  double width = 20,
  EdgeInsetsGeometry? padding,
}) {
  RTicketDetailController controller = Get.find<RTicketDetailController>();
  Ticketetail? ticketetail =
      controller.detailController.ticketDetails.value.data?.ticketetail;
  return decoratedBox(
    width: width,
    padding: padding,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              mediumText(
                                title: ticketetail?.status == "0"
                                    ? Strings.TICKETRAISED
                                    : ticketetail?.status == "1"
                                        ? Strings.ACKTICKET
                                        : ticketetail?.status == "2"
                                            ? Strings.RESOLVEDTICKET
                                            : ticketetail?.status == "3"
                                                ? Strings.TICKETAPPROVED
                                                : ticketetail?.status == "6"
                                                    ? Strings.TICKETCANCELLED
                                                    : ticketetail?.status == "5"
                                                        ? Strings.REOPENEDTICKET
                                                        : "",
                                fontColor: AppColors.navyBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                textAlign: TextAlign.start,
                                maxLines: 1,
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
                Strings.ASSIGNEDTO,
                ticketetail?.assigneeType ?? "",
              ),
              detail(
                Strings.PLANTNO,
                ticketetail?.itemCode ?? "",
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
                ticketetail?.underAmc ?? "",
              ),
              detail(
                Strings.DETAILS,
                "${ticketetail?.amcWarrantyFrom != null ? DateFormat('dd/MM/yy').format(ticketetail?.amcWarrantyFrom ?? DateTime.now()) : ''} - "
                "${ticketetail?.amcWarrantyTo != null ? DateFormat('dd/MM/yy').format(ticketetail?.amcWarrantyTo ?? DateTime.now()) : ''}",
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
              attachments(
                ticketetail: ticketetail,
                width: width,
              ),
              customSizedBox(height: 15),
              ticketLogs(
                ticketetail: ticketetail,
              ),
              customSizedBox(height: 41),
              if (ticketetail?.lastIssueRaisedOn != null &&
                  (ticketetail?.lastIssueRaisedOn?.isNotEmpty ?? false))
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [6, 3],
                      color: AppColors.navyBlue.withOpacity(0.8),
                      strokeWidth: 1,
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 12,
                          top: 8.7,
                          bottom: 8.7,
                          right: 12,
                        ),
                        child: Column(
                          children: [
                            raisedDetailsRow(
                              "Raised On",
                              "${ticketetail?.lastIssueRaisedOn}",
                            ),
                            raisedDetailsRow(
                              "Resolved On",
                              "${ticketetail?.lastIssueResolvedOn ?? "N/A"}",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          color: Colors.white,
                          child: mediumText(
                            title: "Last Issue",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontColor: AppColors.navyBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              customSizedBox(height: 41),
            ],
          ),
        ),
      )
    ],
  );
}

Widget raisedDetailsRow(String title, String date) {
  return Padding(
    padding: EdgeInsets.zero,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: mediumText(
            title: title,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.black.withOpacity(0.59),
          ),
        ),
        Text(
          ":",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(width: 22),
        mediumText(
            title: date,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.black),
      ],
    ),
  );
}

Widget ticketLogs({
  required Ticketetail? ticketetail,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customSizedBox(height: 20),
      ticketetail?.logs?.length == 0
          ? const SizedBox()
          : mediumText(
              title: "STATUS",
              fontWeight: FontWeight.w400,
              fontColor: AppColors.black,
              fontSize: 14,
            ),
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ticketetail?.logs?.length ?? 0,
          itemBuilder: (context, index) {
            Log? log = ticketetail?.logs?[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: Get.context!,
                  builder: (context) => Container(
                    padding: const EdgeInsets.only(
                      top: 31,
                      left: 24,
                      right: 24,
                      bottom: 50,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          bottomSheetTopbar(title: "Log Details"),
                          customSizedBox(height: 33),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  detailTitle(title: "Status"),
                                  log?.action == "Acknowledged"
                                      ? detailTitle(title: "Acknowledged At")
                                      : log?.action == "Resolved"
                                          ? detailTitle(title: "Resolved At")
                                          : log?.action == "Raised"
                                              ? detailTitle(title: "Raised At")
                                              : log?.action == "Unverified"
                                                  ? detailTitle(
                                                      title: "Unverified At")
                                                  : log?.action == "Reopened"
                                                      ? detailTitle(
                                                          title: "Reopened At")
                                                      : log?.action ==
                                                              "Cancelled"
                                                          ? detailTitle(
                                                              title:
                                                                  "Cancelled At")
                                                          : detailTitle(
                                                              title:
                                                                  "Verified At"),
                                  log?.action == "Acknowledged"
                                      ? detailTitle(title: "Acknowledged By")
                                      : log?.action == "Resolved"
                                          ? detailTitle(title: "Resolved By")
                                          : log?.action == "Raised"
                                              ? detailTitle(title: "Raised By")
                                              : log?.action == "Unverified"
                                                  ? detailTitle(
                                                      title: "Unverified By")
                                                  : log?.action == "Reopened"
                                                      ? detailTitle(
                                                          title: "Reopened By")
                                                      : log?.action ==
                                                              "Cancelled"
                                                          ? detailTitle(
                                                              title:
                                                                  "Cancelled By")
                                                          : detailTitle(
                                                              title:
                                                                  "Verified By"),
                                  log?.action == "Acknowledged"
                                      ? detailTitle(title: "Estimated Date")
                                      : const SizedBox(),
                                  detailTitle(title: "Remark"),
                                ],
                              ),
                              customSizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  log?.action == "Acknowledged"
                                      ? detailTitle(title: ": ")
                                      : const SizedBox(),
                                  detailTitle(title: ": "),
                                  detailTitle(title: ": "),
                                  detailTitle(title: ": "),
                                  detailTitle(title: ": "),
                                ],
                              ),
                              customSizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    detailTitle(title: log?.action ?? ""),
                                    detailTitle(
                                        title:
                                            "${log?.actionDate} ${log?.actionMonth} ${log?.actionYear} ${log?.actionTime}"),
                                    detailTitle(title: log?.changedBy ?? ""),
                                    log?.action == "Acknowledged"
                                        ? detailTitle(
                                            title: log?.estimatedDate ?? "")
                                        : const SizedBox(),
                                    detailTitle(
                                        title: log?.remarks ?? "No Remarks"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: statusHistoryCard(
                logs: log ?? Log(),
              ),
            );
          }),
    ],
  );
}

Widget attachments({
  required Ticketetail? ticketetail,
  required double width,
}) {
  return ticketetail?.attachments?.length != 0
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(height: 32),
            mediumText(
              title: Strings.ATTACHMENT,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.black,
              fontSize: 14,
            ),
            customSizedBox(height: 14),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 15,
              spacing: 10,
              children: List<Widget>.generate(
                ticketetail?.attachments?.length ?? 0,
                (index) => GestureDetector(
                  onTap: () => attachmentViewer(
                    width: width,
                    imgPath: ticketetail?.attachments?[index].name ?? "",
                  ),
                  child: Container(
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
                          ticketetail?.attachments?[index].name ?? "",
                        ),
                      ),
                    ),
                  ),
                ),
                growable: true,
              ),
            ),
          ],
        )
      : const SizedBox();
}

Widget statusHistoryCard({
  required Log logs,
}) {
  return Container(
    margin: EdgeInsets.only(top: 12),
    padding: const EdgeInsets.only(
      bottom: 8,
      top: 8,
      left: 9,
      right: 19,
    ),
    decoration: BoxDecoration(
      color: AppColors.logCardColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        customDateContainer(
          boxColor: AppColors.white,
          dayNo: logs.actionDate ?? "",
          month: logs.actionMonth ?? "",
          year: logs.actionYear ?? "",
        ),
        customSizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              m.ticketStatus(
                currentStatus: logs.action ?? "",
                fontColor: logs.action == "Acknowledged"
                    ? AppColors.yellow
                    : logs.action == "Resolved"
                        ? AppColors.green
                        : logs.action == "Unverified"
                            ? AppColors.red
                            : logs.action == "Reopened"
                                ? AppColors.red
                                : logs.action == "Cancelled"
                                    ? AppColors.red
                                    : AppColors.navyBlue,
              ),
              customSizedBox(height: 10),
              richText(
                title: "Time: ",
                subTitle: logs.actionTime ?? "",
                subTitleFontWeight: FontWeight.w500,
              ),
              customSizedBox(height: 2),
              richText(
                title: logs.action == "Resolved"
                    ? "Resolved by: "
                    : logs.action == "Raised"
                        ? "Raised by: "
                        : logs.action == "Acknowledged"
                            ? "Acknowledged by: "
                            : logs.action == "Unverified"
                                ? "Unverified by: "
                                : logs.action == "Reopened"
                                    ? "Reopened by: "
                                    : logs.action == "Cancelled"
                                        ? "Cancelled by: "
                                        : "Approved by: ",
                subTitle: logs.changedBy ?? "",
                subTitleFontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          ImgRoutes.VIEWMORE,
        ),
      ],
    ),
  );
}

Widget swipeButton({
  double width = 20,
  String title = "Swipe to Acknowledge",
  Color bgColor = AppColors.lightYellow,
  Color color = AppColors.yellow,
  required Future<bool?> Function() action,
  String icon = ImgRoutes.ACKNOWLEDGEDICON,
  double height = 20,
  required String ticketId,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: bgColor,
          border: Border.all(
            width: 1,
            color: color,
          ),
        ),
        child: SliderButton(
          action: action,
          label: mediumText(
            title: title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.black,
          ),
          alignLabel: Alignment.center,
          backgroundColor: bgColor,
          width: width - 2 * (width * 0.055),
          height: 50,
          buttonSize: 48,
          buttonColor: color,
          icon: SvgPicture.asset(
            icon,
          ),
        ),
      ),
      customSizedBox(height: 7),
      GestureDetector(
        onTap: () => cancelTicketPopup(
          ticketId: ticketId,
          height: height,
          width: width,
        ),
        child: smallText(
          title: "Cancel Ticket",
          fontColor: AppColors.black,
        ),
      )
    ],
  );
}

Future ticketRessolvePopUp({
  required String ticketId,
  double height = 20,
}) {
  RTicketDetailController controller = Get.find<RTicketDetailController>();
  return Future.delayed(
    Duration.zero,
    () => ticketResolveCostPopup(
      title: "Resolve Ticket",
      content: "Please enter your remark and repair cost below.",
      imageRoute: ImgRoutes.ACKNOWLEDGED,
      remarkController: controller.resolvedRemark,
      repairCostController: controller.repairCostController,
      height: height,
      buttonTitle: "Submit",
      onPressed: () async {
        final remark = controller.resolvedRemark.value.text.trim();
        final cost = controller.repairCostController.value.text.trim();

        if (remark.isEmpty || cost.isEmpty) {
          customToast(msg: "Remark and Repair Cost are required.");
          return;
        }

        final costValue = double.tryParse(cost);
        if (costValue == null || costValue < 0) {
          customToast(msg: "Enter a valid repair cost.");
          return;
        }

        Get.back();
        await controller.changeTicketStatus(
          status: "2",
          ticketId: ticketId,
          date: controller.selectedDate.value,
          remark: remark,
          repair_cost: cost,
        );
      },
    ),
  );
}

Future ticketAcknowledgedPopUp({
  required String ticketId,
  double height = 20,
}) {
  RTicketDetailController controller = Get.find<RTicketDetailController>();
  return Future.delayed(
    Duration.zero,
    () => popUp(
      height: height,
      onDatePicker: controller.selectDate,
      selectedDate: controller.selectedDate,
      imageRoute: ImgRoutes.ACKNOWLEDGED,
      isDatePicker: true,
      title: "Estimated Date!",
      content: "Please choose the date by which the ticket will be resolved.",
      buttonTitle: "Proceed",
      remarkController: controller.acknowledgeRemark,
      onPressed: () async {
        if (controller.selectedDate.value != "") {
          Get.back();
          await controller.changeTicketStatus(
            status: "1",
            ticketId: ticketId,
            date: controller.selectedDate.value,
            remark: controller.acknowledgeRemark.value.text,
          );
        } else {
          customToast(msg: "Please Select Estimated Date!");
        }
      },
    ),
  );
}

Future verifyTicketPopup({
  required String ticketId,
  double height = 20,
  double width = 20,
}) {
  RTicketDetailController controller = Get.find<RTicketDetailController>();
  return Future.delayed(
    Duration.zero,
    () => popUp(
      height: height,
      width: width,
      isRemark: true,
      imageRoute: ImgRoutes.ACKNOWLEDGED,
      isMultiButton: true,
      // isButton: false,
      title: "Verify Ticket",
      content: "Are you sure you want to verify the ticket?",
      buttonTitle: "Approve",
      remarkController: controller.verificationRemark,
      onPressed: () async {
        Get.back();
        await controller.changeTicketStatus(
          status: "3",
          ticketId: ticketId,
          remark: controller.verificationRemark.value.text,
        );
        Get.back();
      },
      onTicketReject: () async {
        Get.back();
        await controller.changeTicketStatus(
          status: "4",
          ticketId: ticketId,
          remark: controller.verificationRemark.value.text,
        );
        Get.back();
      },
    ),
  );
}

Future cancelTicketPopup({
  required String ticketId,
  double height = 20,
  double width = 20,
}) {
  RTicketDetailController controller = Get.find<RTicketDetailController>();
  return Future.delayed(
    Duration.zero,
    () => popUp(
      height: height,
      width: width,
      isRemark: true,
      imageRoute: ImgRoutes.CANCELTICKET,
      isButton: true,
      title: "Cancel Ticket",
      content: "Are you sure you want to cancel the ticket?",
      buttonTitle: "Proceed",
      remarkController: controller.cancelTicketRemark,
      onPressed: () async {
        Get.back();
        await controller.changeTicketStatus(
          status: "6",
          ticketId: ticketId,
          remark: controller.cancelTicketRemark.value.text,
        );
        Get.back();
      },
    ),
  );
}
