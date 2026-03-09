import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/active_inactive_box.dart';
import 'package:rail_weld/widgets/custom_date_container.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import '../../../../model/scc_module_models/tickets_list_model.dart';

Widget ticketCard({
  void Function()? onTap,
  Color? bgColor = AppColors.white,
  Color dateCardColor = AppColors.lGrey,
  required Datum ticketDetail,
  double width = 20,
}) {
  List<String> date = ticketDetail.createdAtDate == null
      ? ("01-Jan-2000").split("-")
      : ticketDetail.createdAtDate?.split("-") ?? [];
  DateTime dateTime = ticketDetail.createdAtTime != null
      ? DateFormat("HH:mm:ss").parse(ticketDetail.createdAtTime ?? "")
      : DateFormat("HH:mm:ss").parse("15:19:09");
  String formattedTime = DateFormat("h:mm a").format(dateTime);
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(
            top: 12,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              width: 1,
              color: AppColors.borderGrey,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.navyBlue.withOpacity(0.25),
                offset: Offset(0, 6),
                blurRadius: 2,
              ),
              BoxShadow(
                color: AppColors.navyBlue.withOpacity(0.25),
                blurRadius: 2,
                offset: Offset(1, 2),
              ),
              BoxShadow(
                color: AppColors.navyBlue.withOpacity(0.25),
                offset: Offset(-1, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        customDateContainer(
                          width: 90,
                          boxColor: dateCardColor,
                          dayNo: date[0],
                          month: date[1].toUpperCase(),
                          year: date[2],
                        ),
                        customSizedBox(height: 5),
                        smallText(
                          title: formattedTime,
                          fontColor: AppColors.black,
                          fontSize: 12,
                        ),
                        customSizedBox(height: 13),
                        activeInactiveBox(
                          fontSize: ticketDetail.status == "0"
                              ? 12
                              : ticketDetail.status == "1"
                                  ? 9
                                  : ticketDetail.status == "2"
                                      ? 11
                                      : ticketDetail.status == "3"
                                          ? 11
                                          : ticketDetail.status == "6"
                                              ? 11
                                              : ticketDetail.status == "5"
                                                  ? 11
                                                  : 10,
                          status: ticketDetail.status == "0"
                              ? Strings.NEW
                              : ticketDetail.status == "1"
                                  ? Strings.ACKNOWLEDGED
                                  : ticketDetail.status == "2"
                                      ? Strings.RESOLVED
                                      : ticketDetail.status == "3"
                                          ? Strings.APPROVED
                                          : ticketDetail.status == "6"
                                              ? Strings.CANCELLED
                                              : ticketDetail.status == "5"
                                                  ? Strings.REOPENED
                                                  : "",
                          width: 90,
                          height: 22,
                          padding: EdgeInsets.all(0),
                          bgColor: ticketDetail.status == "0"
                              ? AppColors.lightNavyBlue
                              : ticketDetail.status == "1"
                                  ? AppColors.lightYellow
                                  : ticketDetail.status == "2"
                                      ? AppColors.lightGreen
                                      : ticketDetail.status == "3"
                                          ? AppColors.lightGreen
                                          : ticketDetail.status == "5"
                                              ? AppColors.lightNavyBlue
                                              : ticketDetail.status == "6"
                                                  ? AppColors.lightRed
                                                  : AppColors.lightNavyBlue,
                          borderColor: ticketDetail.status == "0"
                              ? AppColors.darkNavyBlue
                              : ticketDetail.status == "1"
                                  ? AppColors.yellow
                                  : ticketDetail.status == "2"
                                      ? AppColors.greenn
                                      : ticketDetail.status == "3"
                                          ? AppColors.green
                                          : ticketDetail.status == "5"
                                              ? AppColors.darkNavyBlue
                                              : ticketDetail.status == "6"
                                                  ? AppColors.red
                                                  : AppColors.darkNavyBlue,
                        ),
                      ],
                    ),
                    customSizedBox(width: Get.width * 0.07),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              smallText(
                                title: ticketDetail.ticketNumber.toString(),
                                fontWeight: FontWeight.w600,
                                fontColor: AppColors.navyBlue,
                                fontSize: 15,
                              ),
                              activeInactiveBox(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                status: ticketDetail.priority ?? "",
                                bgColor: ticketDetail.priority == "High"
                                    ? AppColors.lightRed
                                    : ticketDetail.priority == "Medium"
                                        ? AppColors.lightYellow
                                        : AppColors.lightGreen,
                                borderColor: ticketDetail.priority == "High"
                                    ? AppColors.red
                                    : ticketDetail.priority == "Medium"
                                        ? AppColors.yellow
                                        : AppColors.green,
                              ),
                            ],
                          ),
                          customSizedBox(height: 12),
                          detail(Strings.MACHINE,
                              ticketDetail.machineName ?? "", 3),
                          detail(
                              Strings.PLANTNO, ticketDetail.itemCode ?? "", 3),
                          detail(
                              Strings.LOCATION, ticketDetail.location ?? "", 1),
                          detail(
                            Strings.ISSUECODE,
                            ticketDetail.issueCodes?.length == 0
                                ? ""
                                : ticketDetail.issueCodes?.length == 1
                                    ? "${ticketDetail.issueCodes?[0].issueCode}"
                                    : "${ticketDetail.issueCodes?[0].issueCode} + ${(ticketDetail.issueCodes?.length ?? 0) - 1}",
                            3,
                          ),
                          detail(Strings.AMC, ticketDetail.underAmc ?? "", 3),
                          detail(
                            Strings.DETAILS,
                            "${ticketDetail.amcWarrantyFrom != null ? DateFormat('dd/MM/yy').format(ticketDetail.amcWarrantyFrom ?? DateTime.now()) : ''} - "
                            "${ticketDetail.amcWarrantyTo != null ? DateFormat('dd/MM/yy').format(ticketDetail.amcWarrantyTo ?? DateTime.now()) : ''}",
                            3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (ticketDetail.status != "0")
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: ticketDetail.status == "0"
                        ? AppColors.darkNavyBlue
                        : ticketDetail.status == "1"
                            ? AppColors.yellow
                            : ticketDetail.status == "2"
                                ? AppColors.greenn
                                : ticketDetail.status == "3"
                                    ? AppColors.green
                                    : ticketDetail.status == "5"
                                        ? AppColors.darkNavyBlue
                                        : ticketDetail.status == "6"
                                            ? AppColors.red
                                            : AppColors.darkNavyBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (ticketDetail.status == "1")
                          Row(
                            children: [
                              smallText(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                title:
                                    "Raised on: ${ticketDetail.ticketRaisedOn}",
                                fontColor: AppColors.white,
                              ),
                            ],
                          ),
                        if (ticketDetail.status == "2")
                          Row(
                            children: [
                              smallText(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                title:
                                    "Raised on: ${ticketDetail.ticketRaisedOn}",
                                fontColor: AppColors.white,
                              ),
                              smallText(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  title: " | "),
                              smallText(
                                fontSize: 8,
                                fontWeight: FontWeight.w400,
                                title:
                                    "Acknowledged On: ${ticketDetail.ticketAcknowledgedOn}",
                                fontColor: AppColors.white,
                              ),
                            ],
                          ),
                        if (ticketDetail.status == "3")
                          smallText(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            title:
                                "Approved on: ${ticketDetail.ticketApprovedOn}",
                            fontColor: AppColors.white,
                          ),
                        if (ticketDetail.status == "4")
                          smallText(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            title:
                                "Rejected on: ${ticketDetail.ticketRejectedOn}",
                            fontColor: AppColors.white,
                          ),
                        if (ticketDetail.status == "5")
                          smallText(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            title:
                                "Re-Opened on: ${ticketDetail.ticketReOpenedOn}",
                            fontColor: AppColors.white,
                          ),
                        if (ticketDetail.status == "6")
                          smallText(
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            title:
                                "Cancelled on: ${ticketDetail.ticketCancelledOn}",
                            fontColor: AppColors.white,
                          ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
      customSizedBox(height: 22),
    ],
  );
}

Widget detail(
  String title,
  String val,
  int maxline,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: detailValue(title: title),
        ),
        customSizedBox(width: 5),
        detailValue(title: " : "),
        customSizedBox(width: 5),
        Expanded(
          child: detailValue(
            title: val,
            color: AppColors.black,
            fontWeight: title == Strings.PLANTNO ? FontWeight.w700 : null,
            maxLines: maxline,
          ),
        ),
      ],
    ),
  );
}

Widget detailValue({
  required String title,
  FontWeight? fontWeight = FontWeight.w400,
  Color color = AppColors.black,
  int? maxLines = null,
}) {
  return smallText(
    title: title,
    fontSize: 12,
    fontWeight: fontWeight,
    fontColor: color,
    maxLines: maxLines,
  );
}
