import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/machine_condemn_request/machine_condemn_request_controller.dart';
import 'package:rail_weld/data/strings.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/active_inactive_box.dart';
import 'package:rail_weld/widgets/attachment_viewer.dart';
import 'package:rail_weld/widgets/common_single_attachment_container.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/model/scc_module_models/machine_condemn_request_list_model.dart';
import 'package:intl/intl.dart';

Widget machineCodemnRequestCard({
  Color bgColor = AppColors.lightGreen,
  Color borderColor = AppColors.green,
  required Datum requestDetail,
  required BuildContext context,
}) {
  final normalizedStatus = requestDetail.status?.toLowerCase() ?? "pending";
  final controller = Get.find<MachineCondemnRequestController>();
  return GestureDetector(
    onTap: () => showCodemnRequestDetailBottomSheet(
      context,
      requestDetail,
      controller.role?.value ?? "3",
      controller.roleType.value ?? [],
    ),
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
      child: Padding(
        padding: const EdgeInsets.all(12),
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
                    border: Border.all(color: AppColors.offWhite),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          requestDetail.machine?.machineImage ?? ""),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                    title: requestDetail.machine?.name ?? "",
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                    height: 1.4,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 6),
                  if ((requestDetail.machine?.itemCode ?? "").isNotEmpty ||
                      (requestDetail.machine?.location ?? "").isNotEmpty)
                    mediumText(
                      title:
                          "#${requestDetail.machine?.itemCode ?? ''} | ${requestDetail.machine?.location ?? ''}",
                      fontSize: 12,
                      fontColor: AppColors.navyBlue.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  const SizedBox(height: 6),
                  mediumText(
                    title:
                        "Requested by: ${requestDetail.requestRaisedByName ?? ''}",
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                  ),
                  const SizedBox(height: 6),
                  mediumText(
                    title: "Date: ${requestDetail.createdAtFormatted ?? ''}",
                    fontSize: 10,
                    fontColor: AppColors.blackL,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showCodemnRequestDetailBottomSheet(
  BuildContext context,
  Datum requestDetail,
  String userRole,
  List<String> roleType,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      final width = MediaQuery.of(context).size.width;
      final controller = Get.find<MachineCondemnRequestController>();

      return Padding(
        padding: const EdgeInsets.all(23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- [Header] ---
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
                          requestDetail.machine?.machineImage ?? "",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText(
                          title: requestDetail.machine?.name ?? "",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.black,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 8),
                        mediumText(
                          title:
                              "#${requestDetail.machine?.itemCode ?? ''} | ${requestDetail.machine?.location ?? ''}",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.navyBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // --- [Request Info] ---
              _infoRow("Requested By", requestDetail.requestRaisedByName),
              const SizedBox(height: 7),
              _infoRow("Status", requestDetail.status),
              const SizedBox(height: 7),
              _infoRow("Date", requestDetail.createdAtFormatted),
              // const SizedBox(height: 7),
              // _infoRow("Remarks", requestDetail.requestByRemarks ?? "—"),
              const SizedBox(height: 20),

              mediumText(
                title: "Reason for Codemnation",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              const SizedBox(height: 6),
              mediumText(
                title: requestDetail.requestByRemarks ?? "-",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
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
                requestDetail.machine?.dateOfCommissioning != null
                    ? DateFormat('dd MMM yyyy')
                        .format(requestDetail.machine!.dateOfCommissioning!)
                    : "-",
              ),
              const SizedBox(height: 7),
              _infoRow("Model", requestDetail.machine?.model),
              const SizedBox(height: 7),
              _infoRow("Make", requestDetail.machine?.make),
              const SizedBox(height: 7),
              _infoRow(
                  "Machine Cost", "INR ${requestDetail.machine?.machineCost}"),
              const SizedBox(height: 7),
              _infoRow(
                "Warranty Status",
                requestDetail.machine?.warranty == true
                    ? "🟢 In Warranty"
                    : "🔴 Out of Warranty",
                textColor: requestDetail.machine?.warranty == true
                    ? Colors.green
                    : Colors.red,
              ),
              const SizedBox(height: 20),

              singleAttachmentsContainer(
                  imageUrl: requestDetail.supportAttachment, width: width),
              const SizedBox(height: 25),

              if (userRole == '4' &&
                  roleType.any((e) => e.toLowerCase() == 'm&p cell') &&
                  requestDetail.status?.toLowerCase() == 'pending') ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: width * 0.12,
                      width: width * 0.4,
                      child: customElevatedButtonIcon(
                        bgColor: AppColors.red.withOpacity(0.1),
                        fontColor: AppColors.red,
                        border: BorderSide(color: AppColors.red, width: 1),
                        onPressed: () async {
                          await controller.condemnRequestProcess(
                            request_id: requestDetail.id ?? 0,
                            action_type: 'reject',
                            machine_id: requestDetail.machineId ?? 0,
                            request_raised_by:
                                requestDetail.requestRaisedBy ?? 0,
                          );
                          Get.back();
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
                        border: BorderSide(color: AppColors.green, width: 1),
                        onPressed: () async {
                          await controller.condemnRequestProcess(
                            request_id: requestDetail.id ?? 0,
                            action_type: 'approve',
                            machine_id: requestDetail.machineId ?? 0,
                            request_raised_by:
                                requestDetail.requestRaisedBy ?? 0,
                          );
                          Get.back();
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
                )
              ] else ...[
                Column(
                  children: [
                    Center(
                      child: smallText(
                        title: requestDetail.status?.toLowerCase() == 'approved'
                            ? "This request has been approved."
                            : requestDetail.status?.toLowerCase() == 'rejected'
                                ? "This request has been rejected."
                                : "This request is pending action.",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontColor: requestDetail.status?.toLowerCase() ==
                                'approved'
                            ? Colors.green
                            : requestDetail.status?.toLowerCase() == 'rejected'
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ),
                    // Center(
                    //   child: smallText(
                    //     title: requestDetail.actionByRemarks,
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.w500,
                    //     fontColor: requestDetail.status == 'approved'
                    //         ? Colors.green
                    //         : requestDetail.status == 'rejected'
                    //             ? Colors.red
                    //             : Colors.orange,
                    //   ),
                    // ),
                  ],
                )
              ]
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
  MachineCondemnRequestController controller =
      Get.find<MachineCondemnRequestController>();
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
          onPressed: () {},
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
