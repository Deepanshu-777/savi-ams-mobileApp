import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/ticket_request/ticket_request_controller.dart';
import 'package:rail_weld/app/ssc_modules/settings/widgets.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/active_inactive_box.dart';
import 'package:rail_weld/widgets/attachment_viewer.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

import '../../../../model/scc_module_models/ticket_request_model.dart';

import '../../../../routes/app_pages.dart';

Widget ticketRequestCard({
  Color bgColor = AppColors.lightGreen,
  Color borderColor = AppColors.green,
  required Datum ticketDetail,
  required BuildContext context,
}) {
  final normalizedStatus = ticketDetail.status?.toString() ?? "Pending";
  return GestureDetector(
    onTap: () => showTicketDetailBottomSheet(context, ticketDetail),
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.offWhite, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: AppColors.offWhite, width: 1),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                ticketDetail.machine?.machineImage ?? ""),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      activeInactiveBox(
                        width: 66,
                        fontSize: 11,
                        bgColor: normalizedStatus == "rejected"
                            ? AppColors.lightRed
                            : normalizedStatus == "approved"
                                ? bgColor
                                : AppColors.lightYellow,
                        borderColor: normalizedStatus == "rejected"
                            ? AppColors.red
                            : normalizedStatus == "approved"
                                ? borderColor
                                : AppColors.yellow,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        status:
                            "${normalizedStatus[0].toUpperCase()}${normalizedStatus.substring(1)}",
                      ),
                    ],
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText(
                          title: ticketDetail.machine?.name ?? "",
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.black,
                          height: 1.4,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 6),
                        if ((ticketDetail.machine?.itemCode ?? "").isNotEmpty ||
                            (ticketDetail.machine?.location ?? "").isNotEmpty)
                          Row(
                            children: [
                              mediumText(
                                title:
                                    "#${ticketDetail.machine?.itemCode ?? ''}   |  ${ticketDetail.machine?.location ?? ''}",
                                fontSize: 13,
                                fontColor: AppColors.navyBlue.withOpacity(0.9),
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            mediumText(
                              title: "Raise by  : ",
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              fontColor: AppColors.blackL,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            mediumText(
                              title: ticketDetail.name ?? "",
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 10,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mediumText(
                  title: "Description",
                  fontSize: 11,
                  fontColor: AppColors.blackL,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 6,
                ),
                mediumText(
                  title: ticketDetail.description ?? "",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.black,
                  maxLines: 3,
                ),
                SizedBox(
                  height: 14,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      smallText(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        title:
                            "Requested on: ${ticketDetail.createdAtFormatted}",
                        fontColor: AppColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

void showTicketDetailBottomSheet(BuildContext context, Datum ticketDetail) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;
      TicketRequestController controller = Get.find<TicketRequestController>();
      return Padding(
        padding: const EdgeInsets.all(23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.offWhite, width: 1),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            ticketDetail.machine?.machineImage ?? ""),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText(
                          title: ticketDetail.machine?.name ?? "",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.black,
                          maxLines: 3,
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        if ((ticketDetail.machine?.itemCode ?? "").isNotEmpty ||
                            (ticketDetail.machine?.location ?? "").isNotEmpty)
                          Row(
                            children: [
                              mediumText(
                                title:
                                    "#${ticketDetail.machine?.itemCode ?? ''}   |  ${ticketDetail.machine?.location ?? ''}",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.navyBlue,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  mediumText(
                    title: "Raise by  :   ",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.blackL,
                  ),
                  mediumText(
                    title: ticketDetail.name ?? "",
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontColor: AppColors.black,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              mediumText(
                title: "Description",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.blackL,
                maxLines: 3,
              ),
              SizedBox(
                height: 6,
              ),
              mediumText(
                title: ticketDetail.description ?? "",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              largeText(
                title: "Machine Basic Details",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              const SizedBox(height: 10),
              _infoRow(
                "Date Of Comm.",
                ticketDetail.machine?.dateOfCommissioning?.toIso8601String() ??
                    '',
              ),
              SizedBox(
                height: 7,
              ),
              _infoRow("Model", ticketDetail.machine?.model),
              SizedBox(
                height: 7,
              ),
              _infoRow("Make", ticketDetail.machine?.make),
              SizedBox(
                height: 7,
              ),
              _infoRow(
                  "Machine Cost", "INR ${ticketDetail.machine?.machineCost}"),
              SizedBox(
                height: 7,
              ),
              _infoRow(
                "Warranty Status",
                ticketDetail.machine?.warranty == true
                    ? "🟢 In Warranty"
                    : "🔴 Out of Warranty",
                textColor: ticketDetail.machine?.warranty == true
                    ? Colors.green
                    : Colors.red,
              ),
              attachments(
                ticketetail: ticketDetail,
                width: width,
              ),
              const SizedBox(height: 20),
              ticketDetail.status == 'pending'
                  ? Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: width * 0.12,
                            width: width * 0.4,
                            child: customElevatedButtonIcon(
                              bgColor: AppColors.red.withOpacity(0.1),
                              fontColor: AppColors.red,
                              border:
                                  BorderSide(color: AppColors.red, width: 1),
                              onPressed: () async {
                                await controller.ticketRequestProcess(
                                  ticketRequestId:
                                      (ticketDetail.id ?? 0).toInt(),
                                  action: 'decline',
                                );
                              },
                              title: 'Decline',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              isWidget: true,
                              icon: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.red),
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: AppColors.red,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          SizedBox(
                            height: width * 0.12,
                            width: width * 0.4,
                            child: customElevatedButtonIcon(
                              bgColor: AppColors.green,
                              fontColor: AppColors.white,
                              border:
                                  BorderSide(color: AppColors.green, width: 1),
                              onPressed: () {
                                Get.back();
                                Get.toNamed(
                                  Routes.RAISETICKET,
                                  arguments: ticketDetail.machine,
                                );
                              },
                              title: 'Approve',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              isWidget: true,
                              icon: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.check,
                                  size: 14,
                                  color: AppColors.green,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: width * 0.12,
                          width: width * 0.6,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: ticketDetail.status == 'approved'
                                ? AppColors.green
                                : AppColors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ticketDetail.status == 'approved'
                                  ? AppColors.green
                                  : AppColors.red,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ticketDetail.status == 'approved'
                                      ? Colors.white
                                      : null,
                                  border: ticketDetail.status == 'approved'
                                      ? null
                                      : Border.all(color: AppColors.red),
                                ),
                                child: Icon(
                                  ticketDetail.status == 'approved'
                                      ? Icons.check
                                      : Icons.close,
                                  size: 14,
                                  color: ticketDetail.status == 'approved'
                                      ? AppColors.green
                                      : AppColors.red,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                ticketDetail.status == 'approved'
                                    ? 'Request Approved'
                                    : 'Request Declined',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ticketDetail.status == 'approved'
                                      ? AppColors.white
                                      : AppColors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _infoRow(String label, String? value, {Color? textColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: mediumText(
            title: "$label :",
            fontColor: AppColors.blackL2,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: mediumText(
            title: value ?? "-",
            fontColor: AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget detailTitle({
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: smallText(
      title: title,
      fontSize: 12,
      fontColor: AppColors.blackL,
      maxLines: 1,
    ),
  );
}

Widget detailValue({
  required String title,
  Color color = AppColors.black,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.5),
    child: smallText(
      title: title,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontColor: color,
      maxLines: 1,
    ),
  );
}

Widget statusContainer({
  Color? boxColor = AppColors.white,
  required String title,
  required double hPadding,
  int statusIndex = 0,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: hPadding,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.6),
        color: boxColor,
        border: Border.all(
          color: boxColor == AppColors.navyBlue
              ? AppColors.navyBlue
              : AppColors.black,
        ),
      ),
      child: smallText(
        title: title,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontColor:
            boxColor == AppColors.navyBlue ? AppColors.white : AppColors.black,
      ),
    ),
  );
}

Widget noRecord({
  double height = 20,
  double width = 20,
}) {
  TicketRequestController controller = Get.find<TicketRequestController>();
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(ImgRoutes.NOMACHINEFOUND),
        customSizedBox(height: 20),
        smallText(
          title: "No Ticket Request Found!",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.navyBlue,
        ),
        customSizedBox(height: 20),
        customElevatedButton(
          onPressed: () {
            // controller.shopIds = <int>[].obs;
            // controller.shopTitles = <String>[].obs;
            // controller.currentMachineStatusIndex.value = 5;
            // controller.currentWarrantyIndex.value = 5;
            // controller.currentTimeIndex.value = 5;
            // controller.currentConditionIndex.value = 5;
            // Get.back();
            // controller.getMachineList(isReset: true);
          },
          title: "Reset",
          bgColor: AppColors.navyBlue,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.2,
            vertical: 10,
          ),
        ),
      ],
    ),
  );
}

Widget cc() {
  return Column(
    children: [
      GestureDetector(
        onTap: () => Get.toNamed(Routes.MACHINEDETAILS),
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 15,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: AppColors.dGrey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  smallText(
                    title: "#124366884910",
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.black,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 25,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: AppColors.offWhite,
                        )),
                    child: Image.asset("assets/images/png_img/img.png"),
                  ),
                  activeInactiveBox(),
                ],
              ),
              customSizedBox(width: 13),
              Column(
                children: [
                  Row(
                    children: [
                      smallText(
                        title: "Maintenance on :   ",
                        fontSize: 12,
                        fontColor: AppColors.black,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 0.5,
                            color: AppColors.offWhite,
                          ),
                        ),
                        child: mediumText(
                          title: "25-02-2025",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  mediumText(
                    title:
                        "400 ampress Dual IGBT Invertor Type DC Arc Welding Machine",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: AppColors.black,
                    maxLines: 6,
                    height: 1.5,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailTitle(title: "Local No. : "),
                          detailTitle(title: "Ticket Raised at : "),
                          detailTitle(title: "Issue Code : "),
                          detailTitle(title: "Priority : "),
                          detailTitle(title: "Vendor Name : "),
                          detailTitle(title: "Vendor Number : "),
                        ],
                      ),
                      customSizedBox(width: Get.width * 0.17),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            detailValue(title: "72356754781"),
                            detailValue(title: "28-12-2023, 11:00 AM"),
                            detailValue(title: "236548"),
                            detailValue(title: "High"),
                            detailValue(title: "RB Innovations"),
                            detailValue(title: "+91 1234567890"),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      customSizedBox(height: 17),
    ],
  );
}

Widget attachments({
  required Datum? ticketetail,
  required double width,
}) {
  return ticketetail?.attachments?.length != 0
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(height: 20),
            mediumText(
              title: Strings.ATTACHMENT,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontColor: AppColors.black,
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
                    imgPath: ticketetail?.attachments?[index] ?? "",
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
                          ticketetail?.attachments?[index] ?? "",
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
