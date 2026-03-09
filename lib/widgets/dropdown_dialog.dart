import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/raise_ticket_controller.dart';

import '../app/ssc_modules/main_view/total_machines/filter_screen.dart';
import '../routes/img_routes.dart';
import '../theme/app_colors.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

Widget dialogList({
  double height = 20,
  double width = 20,
  String dialogLabel = "Select Priority",
  String title = "",
  String hintText = "",
  required int length,
  FontWeight? fontWeight = FontWeight.w500,
  required Widget? Function(BuildContext, int) list,
  required Widget textFieldTitle,
  double titleFontSize = 16,
  bool isExpanded = false,
  bool hasborder = true,
  bool hasTitle = true,
  Color bgColor = AppColors.transparent,
  EdgeInsets padding = const EdgeInsets.symmetric(
    horizontal: 21,
    vertical: 18,
  ),
}) {
  return GestureDetector(
    onTap: () => showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            largeText(
              title: dialogLabel,
              fontSize: 22,
              fontColor: AppColors.black,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(
                  left: 18.0,
                  top: 18,
                  bottom: 18,
                  right: 7,
                ),
                child: SvgPicture.asset(ImgRoutes.CROSS),
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 30,
          top: 15,
        ),
        scrollable: false,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        content: SizedBox(
          width: width * 0.7,
          child: ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: length,
            itemBuilder: list,
          ),
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasTitle)
          mediumText(
            title: title,
            fontWeight: fontWeight,
            fontSize: titleFontSize,
            fontColor: AppColors.black,
          ),
        customSizedBox(height: 10),
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            border: hasborder
                ? Border.all(
                    color: AppColors.offWhite,
                    width: 1.5,
                  )
                : null,
          ),
          child: Row(
            children: [
              isExpanded ? Expanded(child: textFieldTitle) : textFieldTitle,
              isExpanded ? const SizedBox() : const Spacer(),
              SvgPicture.asset(ImgRoutes.ARROWDOWN),
            ],
          ),
        ),
        customSizedBox(height: 10),
      ],
    ),
  );
}

Widget selectStatus({
  double height = 20,
  double width = 20,
  String dialogLabel = "Machine Status",
  String title = "",
  String hintText = "",
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();
  return GestureDetector(
    onTap: () => showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            largeText(
              title: dialogLabel,
              fontSize: 22,
              fontColor: AppColors.black,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(
                  left: 18.0,
                  top: 18,
                  bottom: 18,
                  right: 7,
                ),
                child: SvgPicture.asset(ImgRoutes.CROSS),
              ),
            ),
          ],
        ),
        contentPadding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 30,
          top: 15,
        ),
        scrollable: false,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        content: SizedBox(
          width: width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => shopCard(
                  title: "Working",
                  onTap: () {
                    controller.changeCurrentMachineStatus(0);
                    controller.changeMachineStatus("Working");
                  },
                  isSelected:
                      controller.currentMachineStatus.value == 0 ? true : false,
                ),
              ),
              Obx(
                () => shopCard(
                  title: "Working with defect",
                  onTap: () {
                    controller.changeCurrentMachineStatus(1);
                    controller.changeMachineStatus("Working with defect");
                  },
                  isSelected:
                      controller.currentMachineStatus.value == 1 ? true : false,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: title,
          fontWeight: FontWeight.w500,
          fontColor: AppColors.black,
        ),
        customSizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 21,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.offWhite,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Obx(
                () => smallText(
                  title: controller.machineStatus.value == ""
                      ? "Select machine status"
                      : controller.machineStatus.value,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontColor: controller.machineStatus.value == ""
                      ? AppColors.red
                      : AppColors.black,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(ImgRoutes.ARROWDOWN),
            ],
          ),
        ),
        customSizedBox(height: 10),
      ],
    ),
  );
}
