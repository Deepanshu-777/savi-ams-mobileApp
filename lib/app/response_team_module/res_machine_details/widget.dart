import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_controller.dart';
import 'package:rail_weld/routes/urls.dart';
import 'package:rail_weld/widgets/attachment_viewer.dart';
import 'package:rail_weld/widgets/common_single_attachment_container.dart';
import 'package:rail_weld/widgets/common_three_input.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import 'package:rail_weld/widgets/custom_popup.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/widgets/vertical_rich_text.dart';

import '../../../data/strings.dart';
import '../../../model/scc_module_models/machine_details.dart';
import '../../../routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_date_container.dart';
import '../../../widgets/custom_rich_text.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/sheet_topbar.dart';
import '../../../widgets/surety_dialog.dart';

List<Widget> body({
  double height = 10,
  double width = 20,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  return [
    customSizedBox(height: 10),
    Obx(
      () {
        MachineDetails? machineDetails =
            controller.machineDetail.value.data?.machineDetails;
        return Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: width * 0.055,
                    right: width * 0.055,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () async {
                            await controller.getMachineDetailToEdit();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 9,
                            ),
                            child: SvgPicture.asset(
                              ImgRoutes.EDITMACHINE,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 93,
                              width: 122,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.offWhite,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    machineDetails?.machineImage ?? "",
                                  ),
                                ),
                              ),
                            ),
                            customSizedBox(width: 11),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  machineStatusDropdown(
                                    width: width,
                                    height: height,
                                    controller: controller,
                                    machineDetails: machineDetails,
                                  ),
                                  customSizedBox(height: 9),
                                  smallText(
                                    fontColor: AppColors.navyBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                    maxLines: 1,
                                    title:
                                        "${machineDetails?.itemCode ?? ""} | ${machineDetails?.location ?? ""}",
                                  ),
                                  customSizedBox(height: 5),
                                  smallText(
                                    title: machineDetails?.underAmc ==
                                            "Warranty"
                                        ? (machineDetails?.warrantyStatus ==
                                                "In Warranty"
                                            ? "Within Warranty"
                                            : machineDetails?.warrantyStatus ??
                                                Strings.UNDERWARRANTY)
                                        : machineDetails?.underAmc == "AMC"
                                            ? Strings.UNDERAMC
                                            : machineDetails?.underAmc ==
                                                    "MW maintenance"
                                                ? Strings.UNDERMW
                                                : "",
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.black,
                                  ),
                                  customSizedBox(height: 5),
                                  statusWarranty(detail: machineDetails),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      customSizedBox(height: 16),
                      largeText(
                        title: machineDetails?.name ?? "",
                        fontSize: 18,
                        fontColor: AppColors.navyBlue,
                      ),
                      customSizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          largeText(
                            title: "Machine Details",
                            fontSize: 15,
                            fontColor: AppColors.navyBlue,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () => attachmentViewer(
                              imgPath: machineDetails?.qrCode ?? "",
                              width: width,
                              fit: BoxFit.fill,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  ImgRoutes.BARCODEICON,
                                  height: 20,
                                  width: 20,
                                ),
                                customSizedBox(height: 4),
                                smallText(
                                  title: "View QR",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  fontColor: AppColors.navyBlue,
                                  decoration: TextDecoration.underline,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      customSizedBox(height: 15),
                      Obx(
                        () => detailContainer(
                          currentIndex: 0,
                          bottomPadding:
                              controller.selectedDetailIndex.value == 0
                                  ? 5
                                  : 15,
                          detail: controller.selectedDetailIndex.value == 0
                              ? basicDetails()
                              : const SizedBox(),
                          img: controller.selectedDetailIndex.value == 0
                              ? ImgRoutes.ARROWUP
                              : ImgRoutes.ARROWDOWN,
                        ),
                      ),
                      Obx(
                        () => detailContainer(
                          currentIndex: 2,
                          title: Strings.AMCDETAILS,
                          detail: controller.selectedDetailIndex.value == 2
                              ? additionalDetails()
                              : const SizedBox(),
                          img: controller.selectedDetailIndex.value == 2
                              ? ImgRoutes.ARROWUP
                              : ImgRoutes.ARROWDOWN,
                          bottomPadding:
                              controller.selectedDetailIndex.value == 2
                                  ? 5
                                  : 15,
                        ),
                      ),
                      Obx(
                        () => detailContainer(
                          currentIndex: 1,
                          title: "Vendor Details",
                          detail: controller.selectedDetailIndex.value == 1
                              ? VenderDetails()
                              : const SizedBox(),
                          img: controller.selectedDetailIndex.value == 1
                              ? ImgRoutes.ARROWUP
                              : ImgRoutes.ARROWDOWN,
                          bottomPadding:
                              controller.selectedDetailIndex.value == 1
                                  ? 5
                                  : 15,
                        ),
                      ),
                      Obx(
                        () => detailContainer(
                          currentIndex: 6,
                          title: "Machine Test Details",
                          detail: controller.selectedDetailIndex.value == 6
                              ? machineTestDetails()
                              : const SizedBox(),
                          img: controller.selectedDetailIndex.value == 6
                              ? ImgRoutes.ARROWUP
                              : ImgRoutes.ARROWDOWN,
                          bottomPadding:
                              controller.selectedDetailIndex.value == 6
                                  ? 5
                                  : 15,
                        ),
                      ),
                      testCertificateAttachment(
                        machineDetails: machineDetails,
                        width: width,
                        controller: controller,
                      ),
                      poAndGeneralAttachments(
                        controller: controller,
                        machineDetails: machineDetails,
                        width: width,
                      ),
                      customSizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (machineDetails?.ifDcRequestRaisedFor == true &&
                              machineDetails?.requestDetails != null)
                            GestureDetector(
                              onTap: () => showCodemnRequestDetailBottomSheet(
                                Get.context!,
                                machineDetails?.requestDetails ??
                                    RequestDetails(),
                                controller.role?.value ?? "3",
                              ),
                              child: buildCondemnationRequestCard(
                                requestDetails:
                                    machineDetails?.requestDetails ??
                                        RequestDetails(),
                              ),
                            ),
                          buildTicketExpenditureCard(
                            totalExpenditure:
                                machineDetails?.totalTicketsExpenditure ?? 0,
                            totalTickets:
                                machineDetails?.totalComplaintCount ?? 0,
                            completedTickets:
                                machineDetails?.totalTicketsCompleted ?? 0,
                          ),
                          buildMaintenanceExpenditureCard(
                            totalExpenditure:
                                machineDetails?.totalMaintenanceExpenditure ??
                                    0,
                            totalMaintenance:
                                machineDetails?.totalMaintenanceExpenditure ??
                                    0,
                          ),
                        ],
                      ),
                      customSizedBox(height: 10),
                      buildMaintenanceDownloadCard(
                        width: width,
                        onDownload: () {
                          controller.getMachineMaintenanceReport(
                              id: machineDetails?.id ?? 0);
                        },
                      ),
                      customSizedBox(height: 10),
                      largeText(
                        title: "Log Details",
                        fontSize: 18,
                        fontColor: AppColors.navyBlue,
                      ),
                      customSizedBox(height: 20),
                    ],
                  ),
                ),
                tabs(
                  height: height,
                  width: width,
                ),
              ],
            ),
          ),
        );
      },
    ),
  ];
}

Widget statusWarranty({
  required MachineDetails? detail,
}) {
  return Row(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallText(
            title: Strings.STATUS,
            fontSize: 10,
            fontColor: AppColors.black,
          ),
          customSizedBox(height: 3),
          // smallText(
          //   title: Strings.AMC,
          //   fontSize: 10,
          //   fontColor: AppColors.black,
          // ),
        ],
      ),
      customSizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallText(
            title: ":",
            fontSize: 10,
            fontColor: AppColors.black,
          ),
          customSizedBox(height: 3),
          // smallText(
          //   title: ":",
          //   fontSize: 10,
          //   fontColor: AppColors.black,
          // ),
        ],
      ),
      customSizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          smallText(
            title: detail?.status ?? "",
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.black,
          ),
          customSizedBox(height: 3),
          // smallText(
          //   title: detail?.underAmc == "Warranty"
          //       ? (detail?.warrantyStatus == "In Warranty"
          //           ? "Within Warranty"
          //           : detail?.warrantyStatus ?? Strings.UNDERWARRANTY)
          //       : detail?.underAmc == "AMC"
          //           ? Strings.UNDERAMC
          //           : detail?.underAmc == "MW maintenance"
          //               ? Strings.UNDERMW
          //               : "",
          //   fontSize: 10,
          //   fontWeight: FontWeight.w500,
          //   fontColor: AppColors.black,
          // ),
        ],
      ),
    ],
  );
}

Widget machineStatusDropdown({
  required double width,
  required double height,
  required MachineDetails? machineDetails,
  required ResMachineDetailsController controller,
}) {
  return GestureDetector(
    // onTap: () {
    //   showDialog(
    //     context: Get.context!,
    //     builder: (context) => AlertDialog(
    //       title: Row(
    //         children: [
    //           largeText(
    //             title: "Machine Status",
    //             fontSize: 22,
    //             fontColor: AppColors.black,
    //           ),
    //           const Spacer(),
    //           GestureDetector(
    //             onTap: () => Get.back(),
    //             child: Container(
    //               color: Colors.transparent,
    //               padding: const EdgeInsets.only(
    //                 left: 18.0,
    //                 top: 18,
    //                 bottom: 18,
    //                 right: 7,
    //               ),
    //               child: SvgPicture.asset(ImgRoutes.CROSS),
    //             ),
    //           ),
    //         ],
    //       ),
    //       contentPadding: EdgeInsets.only(
    //         left: 24,
    //         right: 24,
    //         bottom: 30,
    //         top: 15,
    //       ),
    //       scrollable: false,
    //       backgroundColor: AppColors.white,
    //       surfaceTintColor: AppColors.white,
    //       content: SizedBox(
    //         width: width * 0.7,
    //         child: ListView.builder(
    //           shrinkWrap: true,
    //           physics: AlwaysScrollableScrollPhysics(),
    //           itemCount: 1,
    //           itemBuilder: (context, index) {
    //             return Column(
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 shopCard(
    //                   title: "Active",
    //                   onTap: () {
    //                     controller.updateMachineStatus(
    //                       status: "1",
    //                     );
    //                   },
    //                   isSelected: machineDetails?.status == "Active",
    //                 ),
    //                 // shopCard(
    //                 //   title: "Out of Order",
    //                 //   onTap: () {
    //                 //     controller.updateMachineStatus(
    //                 //       status: "2",
    //                 //     );
    //                 //   },
    //                 //   isSelected:
    //                 //       machineDetails?.status ==
    //                 //           "In-active",
    //                 // ),
    //                 shopCard(
    //                   title: "Condemned",
    //                   onTap: () {
    //                     Get.back();
    //                     abandoned(
    //                       ticketId: "",
    //                       height: height,
    //                       width: width,
    //                     );
    //                   },
    //                   isSelected: machineDetails?.status == "Condemned",
    //                 ),
    //               ],
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //   );
    // },

    child: Obx(
      () {
        MachineDetails? machineDetails =
            controller.machineDetail.value.data?.machineDetails;
        return machineStatusCard(
          status: machineDetails?.status == "Condemned"
              ? "Condemned"
              : machineDetails?.status == "In-active"
                  ? "Out of Order"
                  : machineDetails?.status ?? "Active",
          padding: const EdgeInsets.only(
            left: 6,
            right: 7,
          ),
          height: 20,
          isDropdown: false,
          bgColor: machineDetails?.status == "Condemned"
              ? AppColors.red
              : machineDetails?.status == "In-active"
                  ? AppColors.yellow
                  : AppColors.green,
          borderColor: AppColors.white,
        );
      },
    ),
  );
}

Widget machineStatusCard({
  String status = "Active",
  EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 3,
  ),
  double? height,
  Color? bgColor,
  Color? borderColor,
  bool isDropdown = false,
}) {
  return Container(
    padding: padding,
    height: height,
    width: status == "Active" ? 100 : 130,
    decoration: BoxDecoration(
      color: bgColor ?? AppColors.lightGreen,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: borderColor ?? AppColors.green,
        width: 0.38,
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 3,
          backgroundColor: AppColors.white,
        ),
        customSizedBox(width: 4),
        mediumText(
          title: status,
          fontColor: borderColor ?? AppColors.green,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
        isDropdown
            ? IntrinsicHeight(
                child: Row(
                  children: [
                    customSizedBox(width: 20),
                    VerticalDivider(
                      color: borderColor ?? AppColors.green,
                      thickness: 0.6,
                      width: 2,
                    ),
                    customSizedBox(width: 5),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      weight: 0.3,
                      size: 15,
                      color: AppColors.white,
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}

Widget detailContainer({
  String title = "Basic Details",
  Widget detail = const SizedBox(),
  int currentIndex = 0,
  String img = ImgRoutes.ARROWDOWN,
  double bottomPadding = 5,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  return GestureDetector(
    onTap: () => controller.changeSelectedDetailIndex(
      currentIndex == controller.selectedDetailIndex.value ? 5 : currentIndex,
    ),
    child: Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: EdgeInsets.only(
        top: 15,
        bottom: bottomPadding,
        right: 23,
        left: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.offWhite,
        ),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                smallText(
                  title: title,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.black,
                ),
                SvgPicture.asset(img),
              ],
            ),
            detail,
          ],
        ),
      ),
    ),
  );
}

Widget basicDetails() {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  MachineDetails? machineDetails =
      controller.machineDetail.value.data?.machineDetails;
  return Column(
    children: [
      customSizedBox(height: 14),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detail(
            "Date of Comm. of Opr.",
            machineDetails?.dateOfCommissioning != null
                ? DateFormat("dd MMMM yyyy").format(
                    machineDetails?.dateOfCommissioning ?? DateTime.now())
                : "",
          ),
          detail("Model", machineDetails?.model ?? ""),
          detail("Make", machineDetails?.make ?? ""),
          detail("Date of Acquisition/Installation",
              machineDetails?.dateOfAcquisitionInstallation ?? ""),
          detail("COFMOW / PO No.", machineDetails?.poNumber ?? ""),
          detail("IREPS PO No.", machineDetails?.irepsPoNumber ?? ""),
          detail(
            "PO Date",
            machineDetails?.poDate != null
                ? DateFormat("dd MMMM yyyy").format(
                    machineDetails?.poDate ?? DateTime.now(),
                  )
                : "",
          ),
          detail("Gem PO No.", machineDetails?.gemPoNumber ?? ""),
          detail(
            "Gem PO Date",
            machineDetails?.gemPoDate != null
                ? DateFormat("dd MMMM yyyy").format(
                    machineDetails?.gemPoDate ?? DateTime.now(),
                  )
                : "",
          ),
          detail("Capacity", machineDetails?.capacity ?? ""),
          detail("Mc Specility", machineDetails?.mcSpecility ?? ""),
          detail("Loa Details", machineDetails?.loaDetails ?? ""),
          detail("Codal Life", "${machineDetails?.expiryLife ?? "0"} years"),
          detail(
            "Next Maintenance Date",
            machineDetails?.nextMaintenanceDate != null
                ? DateFormat("dd-MM-yyyy")
                    .format(machineDetails!.nextMaintenanceDate!)
                : "--",
          ),
          detail(
            "Warranty",
            machineDetails?.warrantyStatus == "In Warranty"
                ? "Within Warranty"
                : machineDetails?.warrantyStatus ?? "",
          ),
          detail("Stock Holder Code", machineDetails?.stockHolderCode ?? ""),
          detail("Station", machineDetails?.station ?? ""),
          detail(
              "Category Of Machine", machineDetails?.categoryOfMachine ?? ""),
          detail("No. of Shifts in Use",
              (machineDetails?.noOfShiftsUse ?? "").toString()),
          detail("Details of Improvements Date",
              machineDetails?.detailsOfImprovementsDate ?? ""),
          detail(
            "Details of Improvements Cost",
            machineDetails?.detailsOfImprovementsCost != null
                ? "INR ${machineDetails?.detailsOfImprovementsCost}"
                : "",
          ),
          detail(
              "Fund Allocation Code", machineDetails?.fundAllocationCode ?? ""),
          detail("No. of Years Machinery in Use",
              (machineDetails?.noOfYearsMachineryInUse ?? "").toString()),
          detail(
            "Rate of Depreciation",
            machineDetails?.rateOfDepreciation != null
                ? "${machineDetails?.rateOfDepreciation}%"
                : "",
          ),
          detail(
            "Accumulated Depreciation",
            machineDetails?.accumulatedDepreciation != null
                ? "INR ${machineDetails?.accumulatedDepreciation}"
                : "",
          ),
          detail(
            "Net Book Value",
            machineDetails?.netBookValue != null
                ? "INR ${machineDetails?.netBookValue}"
                : "",
          ),
          detail(
            "Current Market Value",
            machineDetails?.currentMarketValue != null
                ? "INR ${machineDetails?.currentMarketValue}"
                : "",
          ),
          detail("Condition", machineDetails?.condition ?? ""),
          detail(
              "Head Quarters UC No.", machineDetails?.headQuartersUcNo ?? ""),
          detail(
            "Whether Surplus",
            machineDetails?.whetherSurplus ?? "",
          ),
          detail(
            "${machineDetails?.machineType ?? "Machine"}  Location in shop",
            machineDetails?.machinePhysicalLocation ?? "",
          ),
          detail(
            "Pressure Vessel Number",
            machineDetails?.pressureVesselNo ?? "",
          ),
          detail(
            "Hours/Day",
            machineDetails?.hoursPerDay ?? "",
          ),
        ],
      ),
    ],
  );
}

Widget detail(
  String title,
  String val,
) {
  return (val == "")
      ? const SizedBox()
      : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: detailTitle(title: title),
            ),
            customSizedBox(width: 20),
            detailTitle(title: ": "),
            customSizedBox(width: 20),
            Expanded(
              child: detailValue(
                title: val,
              ),
            ),
          ],
        );
}

Widget additionalDetails() {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  MachineDetails? machineDetails =
      controller.machineDetail.value.data?.machineDetails;
  return Column(
    children: [
      customSizedBox(height: 14),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailTitle(title: Strings.AMCWARRANTY),
              detailTitle(title: Strings.FROM),
              detailTitle(title: Strings.TO),
              machineDetails?.warrantyFrom == null
                  ? const SizedBox()
                  : detailTitle(title: Strings.WARRANTYFROM),
              machineDetails?.warrantyTo == null
                  ? const SizedBox()
                  : detailTitle(title: Strings.WARRANTYTO),
              machineDetails?.amcFirm == null
                  ? const SizedBox()
                  : detailTitle(title: Strings.AMCFIRM),
              machineDetails?.totalAmcCost == null
                  ? const SizedBox()
                  : detailTitle(
                      title: Strings.TOTALAMCCOST,
                    ),
            ],
          ),
          customSizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailTitle(title: ": "),
              detailTitle(title: ": "),
              detailTitle(title: ": "),
              machineDetails?.warrantyFrom == null
                  ? const SizedBox()
                  : detailTitle(title: ": "),
              machineDetails?.warrantyTo == null
                  ? const SizedBox()
                  : detailTitle(title: ": "),
              machineDetails?.amcFirm == null
                  ? const SizedBox()
                  : detailTitle(title: ": "),
              machineDetails?.totalAmcCost == null
                  ? const SizedBox()
                  : detailTitle(title: ": "),
            ],
          ),
          customSizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detailValue(
                  title: machineDetails?.underAmc == "Warranty"
                      ? (machineDetails?.warrantyStatus == "In Warranty"
                          ? "Within Warranty"
                          : machineDetails?.warrantyStatus ??
                              Strings.UNDERWARRANTY)
                      : machineDetails?.underAmc == "AMC"
                          ? Strings.UNDERAMC
                          : machineDetails?.underAmc == "MW maintenance"
                              ? Strings.UNDERMW
                              : "",
                ),
                detailValue(title: machineDetails?.amcWarrantyFrom ?? ""),
                detailValue(title: machineDetails?.amcWarrantyTo ?? ""),
                machineDetails?.warrantyFrom == null
                    ? const SizedBox()
                    : detailValue(title: machineDetails?.warrantyFrom ?? ""),
                machineDetails?.warrantyTo == null
                    ? const SizedBox()
                    : detailValue(title: machineDetails?.warrantyTo ?? ""),
                machineDetails?.amcFirm == null
                    ? const SizedBox()
                    : detailValue(title: machineDetails?.amcFirm ?? ""),
                machineDetails?.totalAmcCost == null
                    ? const SizedBox()
                    : detailValue(title: machineDetails?.totalAmcCost ?? ""),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

Widget machineTestDetails() {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  MachineDetails? machineDetails =
      controller.machineDetail.value.data?.machineDetails;
  return Column(
    children: [
      customSizedBox(height: 14),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailTitle(title: "Last Tested On"),
              detailTitle(title: "Next Test Due Date"),
              detailTitle(title: "Last Calibrated On"),
              detailTitle(title: "Next Calibration On"),
            ],
          ),
          customSizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                detailValue(
                  title: machineDetails?.lastTestedOn != null
                      ? DateFormat("dd MMMM yyyy").format(
                          machineDetails?.lastTestedOn ?? DateTime.now(),
                        )
                      : "N/A",
                ),
                detailValue(
                  title: machineDetails?.nextTestDueDate != null
                      ? DateFormat("dd MMMM yyyy").format(
                          machineDetails?.nextTestDueDate ?? DateTime.now(),
                        )
                      : "N/A",
                ),
                detailValue(
                  title: machineDetails?.lastCalibratedOn != null
                      ? DateFormat("dd MMMM yyyy").format(
                          machineDetails?.lastCalibratedOn ?? DateTime.now(),
                        )
                      : "N/A",
                ),
                detailValue(
                  title: machineDetails?.nextCalibrationOn != null
                      ? DateFormat("dd MMMM yyyy").format(
                          machineDetails?.nextCalibrationOn ?? DateTime.now(),
                        )
                      : "N/A",
                ),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

Widget VenderDetails() {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  MachineDetails? machineDetails =
      controller.machineDetail.value.data?.machineDetails;
  return Column(
    children: [
      customSizedBox(height: 14),
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailTitle(title: "Vendor Name"),
              detailTitle(title: "Vendor Phone No."),
              detailTitle(title: "Vendor Email Id"),
              detailTitle(title: "Vendor Location"),
            ],
          ),
          customSizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                detailValue(title: machineDetails?.vendorName ?? ""),
                detailValue(title: machineDetails?.vendorPhoneNumber ?? ""),
                detailValue(title: machineDetails?.vendorEmailAddress ?? ""),
                detailValue(
                    title: machineDetails?.vendorDetail?.location ?? ""),
              ],
            ),
          )
        ],
      ),
    ],
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
      fontColor: const Color(0xFF757575),
      maxLines: 4,
    ),
  );
}

Widget detailValue({
  required String title,
  Color color = AppColors.black,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.7),
    child: smallText(
      title: title,
      fontSize: 13,
      fontWeight: FontWeight.w700,
      fontColor: color,
      maxLines: 10,
    ),
  );
}

Widget tabs({
  double height = 10,
  double width = 20,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  MachineDetails? machineDetails =
      controller.machineDetail.value.data?.machineDetails;
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(
          left: width * 0.055,
          right: width * 0.055,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        child: TabBar(
          onTap: (value) => controller.changeTabIndex(value),
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.black,
          controller: controller.tabController,
          indicator: BoxDecoration(
            color: AppColors.navyBlue,
            borderRadius: BorderRadius.circular(30),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          tabs: const [
            Tab(
              text: "Machine History",
            ),
            Tab(
              text: "Scheduled Maintenance",
            ),
          ],
        ),
      ),
      customSizedBox(height: 30),
      Container(
        height: height * 0.5,
        child: TabBarView(
          controller: controller.tabController,
          children: [
            machineDetails?.ticketsLogHistory?.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        ImgRoutes.ZEROTICKETS,
                      ),
                      customSizedBox(height: 20),
                      smallText(
                        title: "No Ticket Raised!",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.navyBlue,
                      )
                    ],
                  )
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        logCardGroup(
                          width: width,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                right: width * 0.055,
                                left: width * 0.055,
                              ),
                              child: mediumText(
                                title:
                                    'Total Complaints: ${machineDetails?.totalComplaintCount ?? ""}',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: width * 0.055,
                                left: width * 0.055,
                              ),
                              child: mediumText(
                                title:
                                    'Total Tickets Expenditure: ₹${machineDetails?.totalTicketsExpenditure ?? ""}',
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  maintainenceCardGroup(
                    width: width,
                    height: height,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.055,
                          left: width * 0.055,
                        ),
                        child: mediumText(
                          title:
                              'Total Maintenance: ${machineDetails?.totalMaintenanceCount ?? ""}',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.055,
                          left: width * 0.055,
                        ),
                        child: mediumText(
                          title:
                              'Total Maintenance Expenditure: ₹${machineDetails?.totalMaintenanceExpenditure ?? ""}',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget logCardGroup({
  double width = 20,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  MachineDetails? machineDetails =
      controller.machineDetail.value.data?.machineDetails;

  return Padding(
    padding: EdgeInsets.only(
      left: width * 0.055,
      right: width * 0.055,
      top: width * 0.009,
    ),
    child: ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: machineDetails?.ticketsLogHistory?.length ?? 0,
      itemBuilder: (context, index) => Column(
        children: [
          logCard(
            logHistory: machineDetails?.ticketsLogHistory?[index] ??
                TicketsLogHistory(),
          ),
          customSizedBox(height: 15),
        ],
      ),
    ),
  );
}

Widget maintainenceCardGroup({
  double width = 20,
  double height = 20,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  MachineDetails? machineDetails =
      controller.machineDetail.value.data?.machineDetails;
  ScheduledMaintenence? maintenence = machineDetails?.scheduledMaintenence;
  return Padding(
    padding: EdgeInsets.only(
      left: width * 0.055,
      right: width * 0.055,
    ),
    child: Column(
      children: [
        maintainenceCard(
          currentStatus: (maintenence?.dueDaysCount ?? 0) > 0
              ? "Due Maintenance"
              : "Upcoming Maintenance ${maintenence?.dueDaysCount}",
          fontColor: (maintenence?.dueDaysCount ?? 0) > 0
              ? AppColors.red
              : AppColors.yellow,
          dayNo: maintenence?.upcomingMaintenenceDay ?? "",
          month: maintenence?.upcomingMaintenenceMonth ?? "",
          year: maintenence?.upcomingMaintenenceYear ?? "",
          itemCode: machineDetails?.itemCode ?? "12455",
          isTime: false,
          location: machineDetails?.location ?? "",
        ),
        customSizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: maintenence?.completedMaintenenceList?.length,
          itemBuilder: (context, index) {
            CompletedMaintenenceList? complete = machineDetails
                ?.scheduledMaintenence?.completedMaintenenceList?[index];
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    controller.getMaintenanceReport(
                      id: complete?.id ?? 0,
                    );
                  },
                  child: maintainenceCard(
                    currentStatus: "Completed Maintenance",
                    fontColor: AppColors.green,
                    dayNo: complete?.maintenenceDay ?? "",
                    month: complete?.maintenenceMonth ?? "",
                    year: complete?.maintenenceYear ?? "",
                    itemCode: machineDetails?.itemCode ?? "12455",
                    time: complete?.maintenenceTime.toString() ?? "",
                  ),
                ),
                customSizedBox(height: 15),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget logCard({
  String currentStatus = "Resolved",
  Color fontColor = AppColors.green,
  required TicketsLogHistory logHistory,
}) {
  TicketMaintenanceController detailController =
      Get.find<TicketMaintenanceController>();
  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: Get.context!,
        builder: (context) => Container(
          padding: const EdgeInsets.only(
            top: 31,
            left: 24,
            right: 24,
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
                bottomSheetTopbar(),
                customSizedBox(height: 33),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailTitle(title: "Local No. : "),
                        detailTitle(title: "Issue Raised at : "),
                        detailTitle(title: "Issue Raised remark : "),
                        logHistory.status == "Issue Raised"
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  detailTitle(
                                      title: "Issue Acknowledged Date : "),
                                  if (logHistory.issueAcknowledgedRemark !=
                                          null &&
                                      ("${logHistory.issueAcknowledgedRemark ?? ""}")
                                          .isNotEmpty)
                                    detailTitle(
                                        title: "Issue Acknowledged Remark : "),
                                  logHistory.status == "Acknowledged"
                                      ? const SizedBox()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            detailTitle(
                                                title:
                                                    "Issue Resolved Date : "),
                                            if (logHistory
                                                        .issueResolvedRemark !=
                                                    null &&
                                                ("${logHistory.issueResolvedRemark ?? ""}")
                                                    .isNotEmpty)
                                              detailTitle(
                                                  title:
                                                      "Issue Resolved Remark : "),
                                            detailTitle(title: "Time Taken : "),
                                            detailTitle(
                                                title: "Verification : "),
                                          ],
                                        ),
                                ],
                              ),
                      ],
                    ),
                    customSizedBox(width: 17),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          detailValue(title: logHistory.itemCode ?? ""),
                          detailValue(title: logHistory.issueRaisedAt ?? ""),
                          detailValue(
                              title: logHistory.issueRaisedRemark ?? ""),
                          if (logHistory.status != "Issue Raised")
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                detailValue(
                                    title:
                                        logHistory.issueAcknowledgedDate ?? ""),
                                if (logHistory.issueAcknowledgedRemark !=
                                        null &&
                                    ("${logHistory.issueAcknowledgedRemark ?? ""}")
                                        .isNotEmpty)
                                  detailValue(
                                      title:
                                          logHistory.issueAcknowledgedRemark ??
                                              ""),
                                if (logHistory.status != "Acknowledged")
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      detailValue(
                                          title: logHistory.issueResolvedDate ??
                                              ""),
                                      if (logHistory.issueResolvedRemark !=
                                              null &&
                                          ("${logHistory.issueResolvedRemark ?? ""}")
                                              .isNotEmpty)
                                        detailValue(
                                            title: logHistory
                                                .issueResolvedRemark!),
                                      detailValue(
                                          title: logHistory.timeTaken ?? ""),
                                      detailValue(
                                        color:
                                            logHistory.verification == "Pending"
                                                ? AppColors.red
                                                : AppColors.green,
                                        title: logHistory.verification ?? "",
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                customSizedBox(height: 18),
                verticalRichText(
                  title: "Remark:",
                  subTitle: logHistory.description ?? "",
                  subTitleFontSize: 14,
                  subTitleFontWeight: FontWeight.w300,
                  vPadding: 10,
                  titleFontWeight: FontWeight.w600,
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       detailController.getTicketDetails(
                //         ticketId: logHistory.id.toString(),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.navyBlue,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 16,
                //         vertical: 12,
                //       ),
                //     ),
                //     child: Text(
                //       "View Full Details",
                //       style: TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w600,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
                customSizedBox(height: 52),
              ],
            ),
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
            BoxShadow(
              color: AppColors.grey.withOpacity(0.3),
              blurRadius: 2,
              offset: Offset(1, 2),
            ),
            BoxShadow(
              color: AppColors.grey.withOpacity(0.3),
              offset: Offset(-1, 2),
              blurRadius: 2,
            ),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              top: 16,
              left: 8,
              right: 19,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    customDateContainer(
                      boxColor: AppColors.logCardColor,
                      dayNo: logHistory.ticketDate ?? "",
                      month: logHistory.ticketMonth ?? "",
                      year: logHistory.ticketYear ?? "",
                      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                      dayFontSize: 14,
                      dayFontWeight: FontWeight.w500,
                      yearFontSize: 18,
                      yearFontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                        color: logHistory.statusIndex == "0"
                            ? AppColors.darkNavyBlue
                            : logHistory.statusIndex == "1"
                                ? AppColors.yellow
                                : logHistory.statusIndex == "2"
                                    ? AppColors.greenn
                                    : logHistory.statusIndex == "3"
                                        ? AppColors.green
                                        : logHistory.statusIndex == "5"
                                            ? AppColors.darkNavyBlue
                                            : logHistory.statusIndex == "6"
                                                ? AppColors.red
                                                : fontColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.circle, // Bullet point
                            size: 5,
                            color: Colors.white,
                          ),
                          SizedBox(width: 2),
                          smallText(
                            title: logHistory.status ?? "",
                            fontColor: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 9,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                customSizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      mediumText(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        title: "#${logHistory.ticketNumber ?? ""}",
                        fontColor: AppColors.black,
                      ),
                      customSizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.navyBlue.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: smallText(
                              title: logHistory.issueCodes != null &&
                                      logHistory.issueCodes!.isNotEmpty
                                  ? logHistory.issueCodes?.first.issueCode ?? ""
                                  : (logHistory.issueCode ?? "N/A"),
                              fontColor: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (logHistory.issueCodes != null &&
                              logHistory.issueCodes!.length > 1)
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: smallText(
                                title:
                                    "+${logHistory.issueCodes!.length - 1} more issues",
                                fontColor: AppColors.navyBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                      customSizedBox(height: 12),
                      mediumText(
                        title: logHistory.description ?? "",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontColor: AppColors.blackL,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  ImgRoutes.VIEWMORE,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          if (logHistory.statusIndex != "0")
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: logHistory.statusIndex == "0"
                    ? AppColors.darkNavyBlue
                    : logHistory.statusIndex == "1"
                        ? AppColors.yellow
                        : logHistory.statusIndex == "2"
                            ? AppColors.greenn
                            : logHistory.statusIndex == "3"
                                ? AppColors.green
                                : logHistory.statusIndex == "5"
                                    ? AppColors.darkNavyBlue
                                    : logHistory.statusIndex == "6"
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
                    if (logHistory.statusIndex == "1")
                      Row(
                        children: [
                          smallText(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            title: "Raised on: ${logHistory.issueRaisedDate}",
                            fontColor: AppColors.white,
                          ),
                        ],
                      ),
                    if (logHistory.statusIndex == "2")
                      Row(
                        children: [
                          smallText(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            title: "Raised on: ${logHistory.issueRaisedDate}",
                            fontColor: AppColors.white,
                          ),
                          smallText(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              title: " | "),
                          smallText(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            title:
                                "Acknowledged On: ${logHistory.issueAcknowledgedDate}",
                            fontColor: AppColors.white,
                          ),
                        ],
                      ),
                    if (logHistory.statusIndex == "3")
                      smallText(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        title: "Approved on: ${logHistory.issueApprovedDate}",
                        fontColor: AppColors.white,
                      ),
                    if (logHistory.statusIndex == "4")
                      smallText(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        title: "Rejected on: ${logHistory.issueUnverifiedDate}",
                        fontColor: AppColors.white,
                      ),
                    if (logHistory.statusIndex == "5")
                      smallText(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        title: "Re-Opened on: ${logHistory.issueReopenedDate}",
                        fontColor: AppColors.white,
                      ),
                    if (logHistory.statusIndex == "6")
                      smallText(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        title: "Cancelled on: ${logHistory.issueCancelledDate}",
                        fontColor: AppColors.white,
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

Widget ticketStatus({
  Color fontColor = AppColors.green,
  String currentStatus = "Resoved",
}) {
  return Row(
    children: [
      CircleAvatar(
        radius: 7,
        backgroundColor: fontColor,
      ),
      customSizedBox(width: 5),
      mediumText(
        title: currentStatus,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontColor: fontColor,
      )
    ],
  );
}

Widget maintainenceCard({
  String currentStatus = "",
  Color fontColor = AppColors.green,
  String itemCode = "",
  String time = "",
  String location = "",
  String dayNo = "",
  String month = "",
  String year = "",
  bool isTime = true,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  return Container(
    padding: const EdgeInsets.only(
      bottom: 10,
      top: 10,
      left: 10,
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
          dayNo: dayNo,
          month: month,
          year: year,
        ),
        customSizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ticketStatus(
                currentStatus: currentStatus,
                fontColor: fontColor,
              ),
              customSizedBox(height: 10),
              richText(
                title: "Local No. : ",
                subTitle: itemCode,
              ),
              customSizedBox(height: 5),
              isTime
                  ? richText(
                      title: "Time : ",
                      subTitle: time,
                    )
                  : richText(
                      title: "Location : ",
                      subTitle: location,
                    ),
            ],
          ),
        ),
        // SvgPicture.asset(
        //   ImgRoutes.VIEWMORE,
        // ),
      ],
    ),
  );
}

Widget status() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      smallText(
        title: "Issue Code: ",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontColor: AppColors.black,
      ),
      smallText(
        title: "21235042",
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontColor: AppColors.black,
      ),
    ],
  );
}

Widget tabBarButton({
  required String title,
  EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(
    horizontal: 41,
    vertical: 9,
  ),
  Color? buttonColor = AppColors.navyBlue,
  Color titleColor = AppColors.black,
}) {
  return Container(
    padding: padding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: buttonColor,
    ),
    child: Center(
      child: smallText(
        title: title,
        fontWeight: FontWeight.w500,
        fontColor: titleColor,
      ),
    ),
  );
}

Future abandoned({
  required String ticketId,
  double height = 20,
  double width = 20,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  return Future.delayed(
    Duration.zero,
    () => popUp(
      height: height,
      width: width,
      isRemark: true,
      imageRoute: ImgRoutes.ACKNOWLEDGED,
      isButton: true,
      isAttachment: true,
      title: "Machine Verification",
      content: "Please upload the verification document",
      buttonTitle: "Submit",
      remarkController: controller.abondenedRemark,
      isMachineDetail: true,
      base64Image: controller.abandonedAttachment,
      localImagePath: controller.localImagePath,
      onPressed: () async {
        controller.updateMachineStatus(
          status: "3",
          remark: controller.abondenedRemark.text,
        );
      },
    ),
  );
}

Widget removeAttachment() {
  return GestureDetector(
    onTap: () {},
    child: Positioned(
      right: 2,
      top: 2,
      child: Icon(
        Icons.disabled_by_default_rounded,
        color: AppColors.navyBlue,
      ),
    ),
  );
}

Widget testCertificateAttachment({
  required MachineDetails? machineDetails,
  required ResMachineDetailsController controller,
  double width = 20,
}) {
  final attachment = machineDetails?.testCertificate;

  if (attachment == null || attachment.isEmpty) return const SizedBox();

  return Obx(
    () => detailContainer(
      bottomPadding: 15,
      currentIndex: 5,
      title: "Test Certificate",
      detail: controller.selectedDetailIndex.value == 5
          ? Column(
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => attachmentViewer(
                    width: width,
                    imgPath: attachment,
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
                        image: NetworkImage(attachment),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox(),
      img: controller.selectedDetailIndex.value == 5
          ? ImgRoutes.ARROWUP
          : ImgRoutes.ARROWDOWN,
    ),
  );
}

Widget poAndGeneralAttachments({
  required MachineDetails? machineDetails,
  required ResMachineDetailsController controller,
  double width = 20,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      (machineDetails?.poAttachments?.length == 0)
          ? const SizedBox()
          : Obx(
              () => detailContainer(
                bottomPadding: 15,
                currentIndex: 3,
                title: "PO Attachments",
                detail: controller.selectedDetailIndex.value == 3
                    ? Column(
                        children: [
                          customSizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 15,
                            spacing: 10,
                            children: List<Widget>.generate(
                              machineDetails?.poAttachments?.length ?? 0,
                              (index) {
                                List<Attachment>? poAttachments =
                                    machineDetails?.poAttachments;
                                return Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () => attachmentViewer(
                                        width: width,
                                        imgPath: machineDetails
                                                ?.poAttachments?[index].name ??
                                            "",
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                          right: 10,
                                        ),
                                        height: 100,
                                        width: width * 0.3,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            width: 0.7,
                                            color: AppColors.black,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              poAttachments?[index].name ?? "",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          suretyDialog(
                                            onNoPressed: () => Get.back(),
                                            onYesPressed: () {
                                              controller.deleteAttachment(
                                                  endpoint:
                                                      Urls.DELETEPOATTACHMENT,
                                                  machineId:
                                                      machineDetails?.id ?? 0,
                                                  id: poAttachments?[index]
                                                          .id
                                                          .toString() ??
                                                      "");
                                            },
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          ImgRoutes.DELETE,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              growable: true,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                img: controller.selectedDetailIndex.value == 3
                    ? ImgRoutes.ARROWUP
                    : ImgRoutes.ARROWDOWN,
              ),
            ),
      (machineDetails?.generalAttachments?.length == 0)
          ? const SizedBox()
          : Obx(
              () => detailContainer(
                bottomPadding: 15,
                currentIndex: 4,
                title: "General Attachments",
                detail: controller.selectedDetailIndex.value == 4
                    ? Column(
                        children: [
                          customSizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            runSpacing: 15,
                            spacing: 10,
                            children: List<Widget>.generate(
                              machineDetails?.generalAttachments?.length ?? 0,
                              (index) => GestureDetector(
                                onTap: () => attachmentViewer(
                                  width: width,
                                  imgPath: machineDetails
                                          ?.generalAttachments?[index].name ??
                                      "",
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        right: 10,
                                      ),
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
                                            machineDetails
                                                    ?.generalAttachments?[index]
                                                    .name ??
                                                "",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          suretyDialog(
                                            onNoPressed: () => Get.back(),
                                            onYesPressed: () {
                                              controller.deleteAttachment(
                                                  endpoint: Urls
                                                      .DELETEGENERALATTACHMENT,
                                                  machineId:
                                                      machineDetails?.id ?? 0,
                                                  id: machineDetails
                                                          ?.generalAttachments?[
                                                              index]
                                                          .id
                                                          .toString() ??
                                                      "");
                                            },
                                          );
                                        },
                                        child: SvgPicture.asset(
                                          ImgRoutes.DELETE,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              growable: true,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                img: controller.selectedDetailIndex.value == 4
                    ? ImgRoutes.ARROWUP
                    : ImgRoutes.ARROWDOWN,
              ),
            ),
    ],
  );
}

Widget buildCondemnationRequestCard({
  required RequestDetails requestDetails,
}) {
  String status = requestDetails.status?.toLowerCase() ?? 'Pending';
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.statusApproved.withOpacity(0.4);
      case 'rejected':
        return AppColors.statusDeclined.withOpacity(0.4);
      case 'pending':
      default:
        return AppColors.statusPending.withOpacity(0.4);
    }
  }

  Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.statusApproved.withOpacity(0.9);
      case 'rejected':
        return AppColors.statusDeclined.withOpacity(0.9);
      case 'pending':
      default:
        return AppColors.statusPending.withOpacity(0.9);
    }
  }

  String capitalize(String s) =>
      s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;

  return Container(
    margin: const EdgeInsets.symmetric(vertical: 16),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF2B2E63)),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumText(
                title: "Condemnation Requested",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              const SizedBox(height: 4),
              smallText(
                title: requestDetails.createdAtFormatted ?? "",
                fontColor: AppColors.black,
                fontSize: 11.5,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: getStatusColor(status),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            capitalize(status),
            style: TextStyle(
              color: getStatusTextColor(status),
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildTicketExpenditureCard({
  required int totalTickets,
  required int completedTickets,
  required int totalExpenditure,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRowItem(
          icon: Icons.local_activity,
          iconColor: AppColors.totalTicketsIconColor,
          bgColor: AppColors.totalTicketsBgColor,
          title: "Total Tickets",
          value: totalTickets.toString(),
        ),
        _buildDivider(),
        _buildRowItem(
          icon: Icons.check_circle_outline,
          iconColor: AppColors.completedTicketsIconColor,
          bgColor: AppColors.completedTicketsBgColor,
          title: "Completed Tickets",
          value: completedTickets.toString(),
        ),
        _buildDivider(),
        _buildRowItem(
          icon: Icons.account_balance_wallet_outlined,
          iconColor: AppColors.expenditureIconColor,
          bgColor: AppColors.expenditureBgColor,
          title: "Total Expenditure",
          value: "₹${totalExpenditure.toString()}",
        ),
      ],
    ),
  );
}

Widget buildMaintenanceExpenditureCard({
  required int totalMaintenance,
  required int totalExpenditure,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRowItem(
          icon: Icons.build_circle_outlined,
          iconColor: AppColors.totalMaintenanceIconColor,
          bgColor: AppColors.totalMaintenanceBgColor,
          title: "Total Maintenance",
          value: totalMaintenance.toString(),
        ),
        _buildDivider(),
        _buildRowItem(
          icon: Icons.account_balance_wallet_outlined,
          iconColor: AppColors.expenditureIconColor,
          bgColor: AppColors.expenditureBgColor,
          title: "Total Expenditure",
          value: "₹${totalExpenditure.toString()}",
        ),
      ],
    ),
  );
}

Widget _buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    width: double.infinity,
    height: 1,
    color: Colors.grey.shade300,
  );
}

Widget _buildRowItem({
  required IconData icon,
  required Color iconColor,
  required Color bgColor,
  required String title,
  required String value,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 18,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 10),
          mediumText(
            title: title,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontColor: Colors.black,
          ),
        ],
      ),
      mediumText(
        title: value,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontColor: Colors.black,
      ),
    ],
  );
}

void showCodemnRequestDetailBottomSheet(
  BuildContext context,
  RequestDetails requestDetails,
  String userRole,
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
      ResMachineDetailsController controller =
          Get.find<ResMachineDetailsController>();
      log("userRole == '4' && requestDetails.status == 'pending' ${userRole} ${requestDetails.status}");
      return Padding(
        padding: const EdgeInsets.all(23),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- [Request Info] ---
              _infoRow("Requested By", requestDetails.requestRaisedByName),
              const SizedBox(height: 7),
              _infoRow(
                  "Status", controller.capitalize(requestDetails.status ?? "")),
              const SizedBox(height: 7),
              _infoRow("Date", requestDetails.createdAtFormatted),
              // const SizedBox(height: 7),
              // _infoRow("Remarks", requestDetails.requestByRemarks ?? "—"),
              const SizedBox(height: 20),

              mediumText(
                title: "Reason for Codemnation",
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              const SizedBox(height: 6),
              mediumText(
                title: requestDetails.requestByRemarks ?? "-",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              const SizedBox(height: 20),

              singleAttachmentsContainer(
                  imageUrl: requestDetails.supportAttachment, width: width),
              const SizedBox(height: 25),

              if (userRole == '4' &&
                  requestDetails.status?.toLowerCase() == 'pending') ...[
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
                            request_id: requestDetails.id ?? 0,
                            action_type: 'reject',
                            machine_id: requestDetails.machineId ?? 0,
                            request_raised_by:
                                requestDetails.requestRaisedBy ?? 0,
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
                            request_id: requestDetails.id ?? 0,
                            action_type: 'approve',
                            machine_id: requestDetails.machineId ?? 0,
                            request_raised_by:
                                requestDetails.requestRaisedBy ?? 0,
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
                        title: requestDetails.status?.toLowerCase() ==
                                'approved'
                            ? "This request has been approved."
                            : requestDetails.status?.toLowerCase() == 'rejected'
                                ? "This request has been rejected."
                                : "This request is pending action.",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontColor: requestDetails.status?.toLowerCase() ==
                                'approved'
                            ? Colors.green
                            : requestDetails.status?.toLowerCase() == 'rejected'
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ),
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

Widget _infoRow(String label, String? value) {
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

Widget buildMaintenanceDownloadCard({
  required VoidCallback onDownload,
  required double width,
}) {
  ResMachineDetailsController controller =
      Get.find<ResMachineDetailsController>();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Maintenance Report",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ThreeDateInputFields(
                initialDay: controller.fromDay.value,
                initialMonth: controller.fromMonth.value,
                initialYear: controller.fromYear.value,
                onChanged: (day, month, year) {
                  controller.fromDay.value = day;
                  controller.fromMonth.value = month;
                  controller.fromYear.value = year;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: mediumText(
                title: "to",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black.withOpacity(0.7),
              ),
            ),
            Expanded(
              child: ThreeDateInputFields(
                initialDay: controller.toDay.value,
                initialMonth: controller.toMonth.value,
                initialYear: controller.toYear.value,
                onChanged: (day, month, year) {
                  controller.toDay.value = day;
                  controller.toMonth.value = month;
                  controller.toYear.value = year;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        /// New Single-choice Checkbox Group
        Obx(() {
          List<String> options = ["Both", "Preventive", "Breakdown"];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: options.map((option) {
              bool isSelected = controller.selectedReportType.value == option;
              return GestureDetector(
                onTap: () {
                  controller.selectedReportType.value = option;
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        isSelected
                            ? ImgRoutes.TICKCHECKBOX
                            : ImgRoutes.UNTICKCHECKBOX,
                        height: 20,
                        width: 20,
                      ),
                      customSizedBox(width: 7),
                      smallText(
                        title: option,
                        fontColor: AppColors.navyBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 16),

        /// Existing Detailed Report Checkbox
        Obx(() {
          return GestureDetector(
            onTap: () {
              controller.toggleReportType();
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  controller.isReportDetailed.value
                      ? ImgRoutes.TICKCHECKBOX
                      : ImgRoutes.UNTICKCHECKBOX,
                  height: 20,
                  width: 20,
                ),
                customSizedBox(width: 7),
                smallText(
                  title: "Detailed Report",
                  fontColor: AppColors.navyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.055,
            ),
            width: double.infinity,
            child: customElevatedButton(
              bgColor: AppColors.navyBlue,
              padding: const EdgeInsets.symmetric(vertical: 17),
              onPressed: onDownload,
              title: "Download",
            ),
          ),
        ),
      ],
    ),
  );
}
