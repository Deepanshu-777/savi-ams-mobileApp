import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_controller.dart';
import 'package:rail_weld/model/scc_module_models/machine_list_model.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/active_inactive_box.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

import '../../../../routes/app_pages.dart';

Widget machineCard({
  Color bgColor = AppColors.lightGreen,
  Color borderColor = AppColors.green,
  required Data machineDetail,
}) {
  return Column(
    children: [
      GestureDetector(
        onTap: () async {
          Get.toNamed(
            Routes.MACHINEDETAILS,
            arguments: {
              "machineId": machineDetail.id ?? 0,
            },
          );
        },
        child: Container(
          margin: EdgeInsets.all(5),
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 15,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: AppColors.offWhite,
            ),
            boxShadow: [
              BoxShadow(
                color: machineDetail.status == "Condemned"
                    ? AppColors.redShadow.withOpacity(0.2)
                    : (machineDetail.status == "Active" &&
                            machineDetail.workingStatus == "Out of order")
                        ? AppColors.yellowShadow.withOpacity(0.3)
                        : AppColors.greenShadow.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
              BoxShadow(
                color: machineDetail.status == "Condemned"
                    ? AppColors.redShadow.withOpacity(0.2)
                    : (machineDetail.status == "Active" &&
                            machineDetail.workingStatus == "Out of order")
                        ? AppColors.yellowShadow.withOpacity(0.3)
                        : AppColors.greenShadow.withOpacity(0.3),
                blurRadius: 2,
                offset: Offset(1, 2),
              ),
              BoxShadow(
                color: machineDetail.status == "Condemned"
                    ? AppColors.redShadow.withOpacity(0.2)
                    : (machineDetail.status == "Active" &&
                            machineDetail.workingStatus == "Out of order")
                        ? AppColors.yellowShadow.withOpacity(0.3)
                        : AppColors.greenShadow.withOpacity(0.3),
                offset: Offset(-1, 2),
                blurRadius: 2,
              ),
            ],
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: smallText(
                    title: machineDetail.itemCode ?? "",
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                    maxLines: 1,
                  ),
                ),
                // const Spacer(),
                Row(
                  children: [
                    smallText(
                      title: "Maintenance on :   ",
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.black,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 0.5,
                          color: AppColors.offWhite,
                        ),
                      ),
                      child: mediumText(
                        title: machineDetail.manumaineceOn ?? "",
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            customSizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: 70,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: AppColors.offWhite,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            machineDetail.machineImage ?? "",
                          ),
                        ),
                      ),
                    ),
                    customSizedBox(height: 10),
                    activeInactiveBox(
                      width: 100,
                      bgColor: machineDetail.status == "Condemned"
                          ? AppColors.lightRed
                          : machineDetail.status == "In-active"
                              ? AppColors.lightYellow
                              : bgColor,
                      borderColor: machineDetail.status == "Condemned"
                          ? AppColors.red
                          : machineDetail.status == "In-active"
                              ? AppColors.yellow
                              : borderColor,
                      padding: EdgeInsets.symmetric(vertical: 4),
                      status: machineDetail.status.toString() == "Condemned"
                          ? "Condemned"
                          : machineDetail.status.toString() == "In-active"
                              ? "Out of Order"
                              : machineDetail.status.toString(),
                    ),
                  ],
                ),
                customSizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      mediumText(
                        title: machineDetail.name ?? "",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.black,
                        maxLines: 6,
                        height: 1.5,
                      ),
                      customSizedBox(height: 13),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              detailTitle(title: "Location   :  "),
                              detailTitle(title: "Warranty  :  "),
                              detailTitle(title: "Status         :  "),
                            ],
                          ),
                          customSizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                detailValue(
                                    title: machineDetail.location ?? ""),
                                detailValue(
                                    title: machineDetail.warrantyStatus ==
                                            "In Warranty"
                                        ? "Within Warranty"
                                        : machineDetail.warrantyStatus ?? ""),
                                detailValue(
                                  title: machineDetail.workingStatus ?? "",
                                  color: (machineDetail.workingStatus ==
                                              "Working" ||
                                          machineDetail.workingStatus == null ||
                                          machineDetail.workingStatus == "")
                                      ? AppColors.green
                                      : AppColors.red,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
      customSizedBox(height: 17),
    ],
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
  TotalMachinesController controller = Get.find<TotalMachinesController>();
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(ImgRoutes.NOMACHINEFOUND),
        customSizedBox(height: 20),
        smallText(
          title: "No Machine Found!",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontColor: AppColors.navyBlue,
        ),
        customSizedBox(height: 20),
        customElevatedButton(
          onPressed: () {
            controller.shopIds = <int>[].obs;
            controller.shopTitles = <String>[].obs;
            controller.currentMachineStatusIndex.value = 5;
            controller.currentWarrantyIndex.value = 5;
            controller.currentTimeIndex.value = 5;
            controller.currentConditionIndex.value = 5;
            Get.back();
            controller.getMachineList(isReset: true);
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

Widget condemnRequestCard({
  required String title,
  required int count,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            ImgRoutes.CONDEMNICON,
            width: 12,
            height: 16,
          ),
          const SizedBox(width: 6),
          smallText(
            title: title,
            fontColor: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: smallText(
              title: count.toString(),
              fontColor: AppColors.navyBlue,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
