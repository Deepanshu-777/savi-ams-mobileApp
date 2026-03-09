import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/model/scc_module_models/tickets_list_model.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import 'package:rail_weld/widgets/dropdown_dialog.dart';
import '../../../../widgets/custom_sized_box.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/filter_bar .dart';
import '../../../../widgets/no_tickets.dart';
import '../../../ssc_modules/main_view/total_tickets/widget.dart';
import 'package:rail_weld/model/scc_module_models/shop_list_model.dart';

List<Widget> ticketSection({
  double width = 20,
  double height = 20,
}) {
  TicketMaintenanceController controller =
      Get.find<TicketMaintenanceController>();

  return [
    Obx(
      () => ticketFilters(
        height: height,
        width: width,
        isFilter: true,
        onDesc: () {
          controller.sortBy.value = "desc";
          Get.back();
          controller.resetPagination();
          controller.getTicketList();
        },
        onAsc: () {
          controller.sortBy.value = "asc";
          Get.back();
          controller.resetPagination();
          controller.getTicketList();
        },
        isCount: true,
        count: (controller.ticketList.value.data?.ticketsList?.total ?? 0)
            .toString(),
      ),
    ),
    customSizedBox(height: 8),
    Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.resetPagination();
          return await controller.getTicketList(
            isLoader: true,
          );
        },
        child: Obx(
          () {
            bool status = controller.isTicketsLoaded.value;
            return status
                ? Obx(
                    () {
                      RxList<Datum>? tickets = controller.selectedFilterTickets;
                      log("ABB: ${tickets?.length.toString()}");
                      return tickets?.length == 0
                          ? noTickets(height: height)
                          : ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(
                                top: 5,
                                left: width * 0.055,
                                right: width * 0.055,
                              ),
                              controller: controller.scrollController,
                              itemCount: tickets?.length ?? 0,
                              itemBuilder: (context, index) {
                                return ticketCard(
                                  ticketDetail: tickets?[index] ?? Datum(),
                                  bgColor: (index % 2 == 0)
                                      ? AppColors.white
                                      : AppColors.logCardColor,
                                  dateCardColor: index % 2 == 0
                                      ? AppColors.lGrey
                                      : AppColors.white,
                                  onTap: () {
                                    controller.getTicketDetails(
                                      ticketId: tickets?[index].id.toString(),
                                    );
                                  },
                                );
                              },
                            );
                    },
                  )
                : const SizedBox();
          },
        ),
      ),
    ),
  ];
}

Widget statusContainer({
  Color? boxColor = AppColors.white,
  required String title,
  required double hPadding,
  int statusIndex = 0,
  required int index,
  required var controller,
}) {
  return GestureDetector(
    onTap: () => controller.changeFilterIndex(index),
    child: Container(
      margin: const EdgeInsets.only(right: 9.5),
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

class FilterScreenTicket extends StatefulWidget {
  const FilterScreenTicket({super.key});

  @override
  State<FilterScreenTicket> createState() => _FilterScreenTicketState();
}

class _FilterScreenTicketState extends State<FilterScreenTicket> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<TicketMaintenanceController>(
      init: TicketMaintenanceController(),
      builder: (controller) => Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 24,
          right: 24,
          bottom: 20,
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
              /// Top Row
              Row(
                children: [
                  largeText(
                    title: "Filter",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.black,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(18.0),
                      child: SvgPicture.asset(ImgRoutes.CROSS),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              mediumText(
                title: "Search By Name or Local No.",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),

              const SizedBox(height: 12),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                height: _isFocused
                    ? controller.assigneeTypes.length < 1
                        ? 100
                        : 70
                    : 50,
                child: TextFormField(
                  controller: controller.searchByNameOrItemCode,
                  focusNode: _focusNode,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: "Enter Name or local no",
                    filled: true,
                    fillColor: AppColors.whiteBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.offWhite,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              if (controller.assigneeTypes.length > 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mediumText(
                      title: "Assignee Type",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.black,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: controller.assigneeTypes
                          .map(
                            (type) => Obx(
                              () => statusContainerTicket(
                                title: type,
                                hPadding: 23,
                                boxColor:
                                    controller.currentAssigneeType.value == type
                                        ? AppColors.navyBlue
                                        : null,
                                onTap: () =>
                                    controller.changeCurrentAssigneeType(
                                  controller.currentAssigneeType.value == type
                                      ? ""
                                      : type,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),

              shopListing(
                height: height,
                width: width,
              ),

              const SizedBox(height: 24),

              /// Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customElevatedButton(
                    onPressed: () {
                      controller.shopIds = <int>[].obs;
                      controller.shopTitles = <String>[].obs;
                      controller.searchByNameOrItemCode.text = "";
                      Get.back();
                      controller.resetPagination();
                      controller.getTicketList(isReset: true);
                    },
                    title: "Reset",
                    bgColor: AppColors.offBlue,
                    fontColor: AppColors.navyBlue,
                    fontSize: 14,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: width * 0.17,
                    ),
                    fontWeight: FontWeight.w800,
                  ),
                  customElevatedButton(
                    onPressed: () async {
                      Get.back();
                      controller.resetPagination();
                      await controller.getTicketList(isReset: true);
                    },
                    title: "Apply",
                    bgColor: AppColors.navyBlue,
                    fontColor: AppColors.white,
                    fontSize: 14,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: width * 0.17,
                    ),
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

Widget shopListing({
  double height = 20,
  double width = 20,
}) {
  TicketMaintenanceController controller =
      Get.find<TicketMaintenanceController>();
  return Obx(
    () {
      List<ShopList>? shopList = controller.shopList.value.data?.shopList;
      return dialogList(
        dialogLabel: "Select Shop",
        height: height,
        fontWeight: FontWeight.w600,
        width: width,
        title: "Location",
        hintText: "Select",
        length: shopList?.length ?? 0,
        textFieldTitle: smallText(
          title: controller.shopIds.length == 0
              ? "Select location"
              : controller.shopIds.length == 1
                  ? "${controller.shopTitles[0]}"
                  : "${controller.shopTitles[0]} + ${controller.shopIds.length - 1}",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontColor: shopList?.length == 0 ? AppColors.red : AppColors.black,
        ),
        list: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => shopCard(
                  title: "${shopList?[index].name}",
                  isSuffix: true,
                  count: shopList?[index].machineCount ?? 0,
                  onTap: () {
                    controller.changeShopIds(shopList?[index].id ?? -1);
                    controller.changeShopTitle(shopList?[index].name ?? "");
                  },
                  isSelected: controller.shopIds.contains(shopList?[index].id)
                      ? true
                      : false,
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget shopCard({
  bool isSelected = true,
  String title = "Shop 001",
  void Function()? onTap,
  bool isSuffix = false,
  num count = 0,
}) {
  Color unSelectedColor = Color(0xFF8B909A);
  Color unSelectedBoxColor = Color(0xFFF8F8F8);
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: 9),
      // width: Get.width * 0.9,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF6F7FF) : unSelectedBoxColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 0.5,
          color: isSelected ? AppColors.navyBlue : unSelectedColor,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            isSelected ? ImgRoutes.TICKCHECKBOX : ImgRoutes.UNTICKCHECKBOX,
            height: 14,
            width: 14,
          ),
          customSizedBox(width: 16),
          Expanded(
            child: smallText(
              title: title,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontColor: isSelected ? AppColors.navyBlue : unSelectedColor,
            ),
          ),
          // isSuffix
          //     ? smallText(
          //         title: "( ${count.toString()} )",
          //         fontSize: 12,
          //         fontWeight: FontWeight.w600,
          //         fontColor: isSelected ? AppColors.navyBlue : unSelectedColor,
          //       )
          //     : const SizedBox(),
        ],
      ),
    ),
  );
}

Widget statusContainerTicket({
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
