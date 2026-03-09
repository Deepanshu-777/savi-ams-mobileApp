import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/maintenance/widgets.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/routes/app_pages.dart';
import '../app/response_team_module/main_view/ticket_maintenance/widgets.dart';
import '../app/ssc_modules/main_view/total_machines/sort_screen.dart';
import '../routes/img_routes.dart';
import '../theme/app_colors.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

Widget filterBar({
  String title = "Total Machines",
  String count = "0",
  bool isFilter = true,
  bool isSort = true,
  bool isRequestCard = false,
  int ticketRequestCount = 0,
  bool isCount = false,
  bool isFromTicket = false,
  void Function()? onAsc,
  void Function()? onDesc,
}) {
  final showAllThree = isRequestCard && isSort && isFilter;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          largeText(
            title: title,
            fontSize: 20,
            fontColor: AppColors.black,
          ),
          isCount
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customSizedBox(width: 5),
                    largeText(
                      title: "( $count )",
                      fontSize: 16,
                      fontColor: AppColors.black,
                    ),
                  ],
                )
              : const SizedBox(),
          const Spacer(),
          if (isRequestCard)
            requestCard(
              title: "New Requests",
              count: ticketRequestCount,
              onTap: () {
                Get.toNamed(Routes.TICKETREQUESTS);
              },
            ),
          if (isRequestCard) const SizedBox(width: 5),
          if (isSort)
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: Get.context!,
                builder: (context) => SortBottomSheet(
                  onAsc: onAsc,
                  onDesc: onDesc,
                ),
              ),
              child: SvgPicture.asset(ImgRoutes.SORT),
            ),
          if (isSort) const SizedBox(width: 5),
          // Show filter inline only if not showing all three
          if (isFilter && !showAllThree)
            GestureDetector(
              onTap: () => showModalBottomSheet(
                context: Get.context!,
                isScrollControlled: true,
                builder: (context) => isFromTicket
                    ? const FilterScreenTicket()
                    : const FilterScreenMaintenance(),
              ),
              child: SvgPicture.asset(
                ImgRoutes.FILTER,
                height: 35,
                width: 35,
              ),
            ),
        ],
      ),
      if (showAllThree)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: GestureDetector(
            onTap: () => showModalBottomSheet(
              context: Get.context!,
              isScrollControlled: true,
              builder: (context) => isFromTicket
                  ? const FilterScreenTicket()
                  : const FilterScreenMaintenance(),
            ),
            child: SvgPicture.asset(
              ImgRoutes.FILTER,
              height: 35,
              width: 35,
            ),
          ),
        ),
    ],
  );
}

Widget requestCard({
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
        borderRadius: BorderRadius.circular(5.6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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

Widget ticketFilters({
  double width = 20,
  double height = 20,
  bool isFilter = true,
  void Function()? onAsc,
  void Function()? onDesc,
  String count = "0",
  bool isCount = false,
  bool isRequestCard = false,
  int ticketRequestCount = 0,
}) {
  TicketMaintenanceController controller =
      Get.find<TicketMaintenanceController>();
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          left: width * 0.055,
          right: width * 0.055,
        ),
        child: filterBar(
          title: "Total Tickets",
          isFilter: isFilter,
          onAsc: onAsc,
          onDesc: onDesc,
          count: count,
          isCount: isCount,
          isFromTicket: true,
          isRequestCard: isRequestCard,
          ticketRequestCount: ticketRequestCount,
        ),
      ),
      customSizedBox(height: 10),
      SizedBox(
        height: 31,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(
            left: width * 0.055,
          ),
          shrinkWrap: true,
          children: [
            Obx(
              () => statusContainer(
                controller: controller,
                title: "New",
                hPadding: 31,
                index: 0,
                boxColor: controller.currentFilterIndex.value == 0
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
            Obx(
              () => statusContainer(
                controller: controller,
                title: "Acknowledged",
                hPadding: 31,
                index: 1,
                boxColor: controller.currentFilterIndex.value == 1
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
            Obx(
              () => statusContainer(
                controller: controller,
                title: "Resolved",
                hPadding: 31,
                index: 2,
                boxColor: controller.currentFilterIndex.value == 2
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
            Obx(
              () => statusContainer(
                controller: controller,
                title: "Approved",
                hPadding: 31,
                index: 3,
                boxColor: controller.currentFilterIndex.value == 3
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
            // Obx(
            //   () => statusContainer(
            //     controller: controller,
            //     title: "Rejected",
            //     hPadding: 31,
            //     index: 4,
            //     boxColor: controller.currentFilterIndex.value == 4
            //         ? AppColors.navyBlue
            //         : null,
            //   ),
            // ),
            Obx(
              () => statusContainer(
                controller: controller,
                title: "Cancelled",
                hPadding: 31,
                index: 6,
                boxColor: controller.currentFilterIndex.value == 6
                    ? AppColors.navyBlue
                    : null,
              ),
            ),
          ],
        ),
      ),
      customSizedBox(height: 10),
    ],
  );
}
