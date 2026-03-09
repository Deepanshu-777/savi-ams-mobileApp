import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/widget.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';
import '../../../../model/scc_module_models/shop_list_model.dart';
import '../../../../routes/img_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/custom_sized_box.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/dropdown_dialog.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<TotalMachinesController>(
      init: TotalMachinesController(),
      builder: (controller) => Container(
        padding: const EdgeInsets.only(
          top: 20,
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
              customSizedBox(height: 20),
              mediumText(
                title: "Search By Name or Local No.",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 13),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                // height: _isFocused ? 200 : 50,
                child: TextFormField(
                  controller: controller.searchByNameOrItemCode,
                  // focusNode: _focusNode,
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  ),
                ),
              ),
              customSizedBox(height: 21),
              mediumText(
                title: "Machine Condition",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 13),
              Row(
                children: [
                  Obx(
                    () => statusContainer(
                        title: "Active",
                        hPadding: 23,
                        statusIndex: 0,
                        boxColor: controller.currentConditionIndex.value == 0
                            ? AppColors.navyBlue
                            : null,
                        onTap: () {
                          controller.currentConditionIndex.value == 0
                              ? controller.changeCurrentMachineStatusIndex(5)
                              : () {};
                          controller.changeCurrentConditionIndex(
                            controller.currentConditionIndex.value == 0 ? 5 : 0,
                          );
                        }),
                  ),
                  customSizedBox(width: 11.2),
                  Obx(
                    () => statusContainer(
                        title: "Condemned",
                        boxColor: controller.currentConditionIndex.value == 2
                            ? AppColors.navyBlue
                            : null,
                        hPadding: 14.5,
                        statusIndex: 2,
                        onTap: () {
                          controller.changeCurrentMachineStatusIndex(5);
                          controller.changeCurrentConditionIndex(
                              controller.currentConditionIndex.value == 2
                                  ? 5
                                  : 2);
                        }),
                  )
                ],
              ),
              customSizedBox(height: 30),

              Obx(
                () => controller.currentConditionIndex.value == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumText(
                            title: "Active Machine",
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColors.black,
                          ),
                          customSizedBox(height: 13),
                          Row(
                            children: [
                              Obx(
                                () => statusContainer(
                                  title: "Working",
                                  hPadding: 23,
                                  statusIndex: 0,
                                  boxColor: controller.currentMachineStatusIndex
                                              .value ==
                                          0
                                      ? AppColors.navyBlue
                                      : null,
                                  onTap: () => controller
                                      .changeCurrentMachineStatusIndex(
                                    controller.currentMachineStatusIndex
                                                .value ==
                                            0
                                        ? 5
                                        : 0,
                                  ),
                                ),
                              ),
                              customSizedBox(width: 11.2),
                              Obx(
                                () => statusContainer(
                                  title: "Out of Order",
                                  boxColor: controller.currentMachineStatusIndex
                                              .value ==
                                          1
                                      ? AppColors.navyBlue
                                      : null,
                                  hPadding: 14.5,
                                  statusIndex: 1,
                                  onTap: () => controller
                                      .changeCurrentMachineStatusIndex(
                                    controller.currentMachineStatusIndex
                                                .value ==
                                            1
                                        ? 5
                                        : 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          customSizedBox(height: 30),
                        ],
                      )
                    : const SizedBox(),
              ),

              mediumText(
                title: "Warranty",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 13),
              Row(
                children: [
                  Obx(
                    () => statusContainer(
                      title: "Within Warranty",
                      hPadding: 23,
                      statusIndex: 0,
                      boxColor: controller.currentWarrantyIndex.value == 0
                          ? AppColors.navyBlue
                          : null,
                      onTap: () => controller.changeCurrentWarrantyIndex(
                        controller.currentWarrantyIndex.value == 0 ? 5 : 0,
                      ),
                    ),
                  ),
                  customSizedBox(width: 11.2),
                  Obx(
                    () => statusContainer(
                      title: "Out of Warranty",
                      boxColor: controller.currentWarrantyIndex.value == 1
                          ? AppColors.navyBlue
                          : null,
                      hPadding: 14.5,
                      statusIndex: 1,
                      onTap: () => controller.changeCurrentWarrantyIndex(
                        controller.currentWarrantyIndex.value == 1 ? 5 : 1,
                      ),
                    ),
                  ),
                ],
              ),
              customSizedBox(height: 30),
              mediumText(
                title: "Upcoming Maintenance",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 13),
              Row(
                children: [
                  Obx(
                    () => statusContainer(
                      title: "In 7 Days",
                      hPadding: 23,
                      statusIndex: 0,
                      boxColor: controller.currentTimeIndex.value == 0
                          ? AppColors.navyBlue
                          : null,
                      onTap: () => controller.changeCurrentTimeIndex(
                        controller.currentTimeIndex.value == 0 ? 5 : 0,
                      ),
                    ),
                  ),
                  customSizedBox(width: 11.2),
                  Obx(
                    () => statusContainer(
                      title: "In 15 Days",
                      boxColor: controller.currentTimeIndex.value == 1
                          ? AppColors.navyBlue
                          : null,
                      hPadding: 14.5,
                      statusIndex: 1,
                      onTap: () => controller.changeCurrentTimeIndex(
                        controller.currentTimeIndex.value == 1 ? 5 : 1,
                      ),
                    ),
                  ),
                  customSizedBox(width: 11.2),
                  Obx(
                    () => statusContainer(
                      title: "In 30 Days",
                      boxColor: controller.currentTimeIndex.value == 2
                          ? AppColors.navyBlue
                          : null,
                      hPadding: 14.5,
                      statusIndex: 2,
                      onTap: () => controller.changeCurrentTimeIndex(
                        controller.currentTimeIndex.value == 2 ? 5 : 2,
                      ),
                    ),
                  )
                ],
              ),
              customSizedBox(height: 30),
              shopListing(
                height: height,
                width: width,
              ),
              // locationDialog(
              //   height: height,
              //   width: width,
              // ),
              customSizedBox(height: 23),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customElevatedButton(
                    onPressed: () {
                      controller.shopIds = <int>[].obs;
                      controller.shopTitles = <String>[].obs;
                      controller.currentMachineStatusIndex.value = 5;
                      controller.currentWarrantyIndex.value = 5;
                      controller.currentTimeIndex.value = 5;
                      controller.currentConditionIndex.value = 5;
                      controller.searchByNameOrItemCode.text = "";
                      Get.back();
                      controller.resetPagination();
                      controller.getMachineList(isReset: true);
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
                      await controller.getMachineList();
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
              customSizedBox(height: 40),
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
  TotalMachinesController controller = Get.find<TotalMachinesController>();
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

Widget locationDialog({
  double height = 20,
  double width = 20,
}) {
  return GestureDetector(
    onTap: () => showDialog(
      context: Get.context!,
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.1),
        child: AlertDialog(
          actions: [
            customElevatedButton(
              padding: EdgeInsets.symmetric(
                vertical: 11,
                horizontal: width * 0.27,
              ),
              onPressed: () {
                Get.back();
              },
              title: "Apply",
              bgColor: AppColors.navyBlue,
            ),
          ],
          title: Row(
            children: [
              largeText(
                title: "Select Shop",
                fontSize: 22,
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 10,
          ),
          scrollable: true,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shopCard(),
              shopCard(isSelected: false),
              shopCard(isSelected: false),
              shopCard(),
              shopCard(),
              shopCard(isSelected: false),
              shopCard(),
              shopCard(),
              shopCard(isSelected: false),
              shopCard(isSelected: false),
              shopCard(),
              shopCard(),
              shopCard(isSelected: false),
              shopCard(),
            ],
          ),
        ),
      ),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 21,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.offWhite,
        ),
      ),
      child: Row(children: [
        smallText(
          title: "Select",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.black,
        ),
        const Spacer(),
        SvgPicture.asset(ImgRoutes.ARROWDOWN),
      ]),
    ),
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
              maxLines: 1,
            ),
          ),
          isSuffix
              ? smallText(
                  title: "( ${count.toString()} )",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontColor: isSelected ? AppColors.navyBlue : unSelectedColor,
                )
              : const SizedBox(),
        ],
      ),
    ),
  );
}
