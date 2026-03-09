import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/filter_screen.dart';
import '../app/ssc_modules/raise_ticket/raise_ticket_controller.dart';
import '../routes/img_routes.dart';
import '../theme/app_colors.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

Widget locationDialog({
  double height = 20,
  double width = 20,
}) {
  RaiseTicketController controller = Get.find<RaiseTicketController>();
  return GestureDetector(
    onTap: () => showDialog(
      context: Get.context!,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
        child: AlertDialog(
          title: Row(
            children: [
              largeText(
                title: "Select Priority",
                fontSize: 22,
                fontColor: AppColors.black,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(18.0),
                  child: SvgPicture.asset(
                    ImgRoutes.CROSS,
                  ),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          scrollable: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          content: SizedBox(
            width: width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => shopCard(
                    title: "High",
                    onTap: () => controller.changePriorityIndex(0),
                    isSelected: controller.priorityIndex == 0 ? true : false,
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected: controller.priorityIndex == 1 ? true : false,
                    title: "Medium",
                    onTap: () => controller.changePriorityIndex(1),
                  ),
                ),
                Obx(
                  () => shopCard(
                    isSelected: controller.priorityIndex == 2 ? true : false,
                    title: "Low",
                    onTap: () => controller.changePriorityIndex(2),
                  ),
                ),
                customSizedBox(height: 15)
              ],
            ),
          ),
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mediumText(
          title: "Priority",
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
          child: Row(children: [
            Obx(
              () => smallText(
                title: controller.priorityIndex == 0
                    ? "High"
                    : controller.priorityIndex == 1
                        ? "Medium"
                        : "Low",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                fontColor: controller.priorityIndex == 0
                    ? AppColors.red
                    : controller.priorityIndex == 1
                        ? AppColors.yellow
                        : AppColors.green,
              ),
            ),
            const Spacer(),
            SvgPicture.asset(ImgRoutes.ARROWDOWN),
          ]),
        ),
        customSizedBox(height: 10),
      ],
    ),
  );
}
