import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/widget.dart';
import 'package:rail_weld/app/ssc_modules/settings/settings_controller.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

import '../total_machines/filter_screen.dart';

Widget homeAppBar() {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 30,
    ),
    decoration: const BoxDecoration(
      color: AppColors.navyBlue,
    ),
    child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mediumText(
                title: "SAVI AMS",
                fontSize: 42,
                fontFamily: "Bebas",
                height: 0.7,
              ),
              smallText(
                title: "Asset Management Tool",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: "Blinker",
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
            child: SvgPicture.asset(
              ImgRoutes.NOTIFICATIONLOGO,
              height: 45,
              width: 45,
            ),
          ),
          customSizedBox(width: 11),
          GestureDetector(
            onTap: () => Get.find<SettingsController>().getProfileDetails(),
            child: SvgPicture.asset(
              "assets/images/svg_img/setting_icon.svg",
              height: 45,
              width: 45,
            ),
          ),
        ],
      ),
      customSizedBox(height: 30.5),
      userDetail(),
    ]),
  );
}

Widget card({
  required Color bgColor,
  required String title,
  required String subTitle,
  required String iconPath,
  required Color fontColor,
  required String count,
  double width = 20,
  void Function()? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width * 0.42,
      padding: const EdgeInsets.only(
        top: 20.5,
        bottom: 22,
        left: 24,
        right: 18,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              iconPath,
              height: 44,
              width: 44,
            ),
          ),
          mediumText(
            title: title,
            fontColor: AppColors.black,
          ),
          mediumText(
            title: subTitle,
            fontColor: AppColors.black,
          ),
          largeText(
            title: count,
            fontColor: fontColor,
            fontSize: 50,
          ),
        ],
      ),
    ),
  );
}

Widget cardSet({
  required String mainTitle,
  required String icon1,
  required String title1,
  required String subTitle1,
  required String icon2,
  required String title2,
  required String subTitle2,
  required String icon3,
  required String title3,
  required String subTitle3,
  required String icon4,
  required String title4,
  required String subTitle4,
  String icon5 = "",
  String title5 = "",
  String subTitle5 = "",
  bool isNext = false,
  double width = 20,
  required String count1,
  required String count2,
  required String count3,
  required String count4,
  String totalCount = "",
  String count5 = "0",
  void Function()? onTap1,
  void Function()? onTap2,
  void Function()? onTap3,
  void Function()? onTap4,
  void Function()? onTap5,
  bool isCalender = false,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: isCalender
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mediumText(
            title: mainTitle,
            fontSize: 26,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.black,
          ),
          customSizedBox(width: 15),
          mediumText(
            title: totalCount,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontColor: AppColors.black,
          ),
          isCalender ? dateRangePicker() : const SizedBox(),
        ],
      ),
      customSizedBox(height: 24),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          card(
            bgColor: AppColors.lightPurple,
            title: title1,
            subTitle: subTitle1,
            count: count1,
            fontColor: AppColors.navyBlue,
            iconPath: icon1,
            width: width,
            onTap: onTap1,
          ),
          card(
            width: width,
            bgColor: AppColors.lightGreen,
            title: title2,
            subTitle: subTitle2,
            count: count2,
            fontColor: AppColors.green,
            iconPath: icon2,
            onTap: onTap2,
          ),
        ],
      ),
      customSizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          card(
            bgColor: AppColors.lightYellow,
            title: title3,
            subTitle: subTitle3,
            count: count3,
            fontColor: AppColors.yellow,
            iconPath: icon3,
            width: width,
            onTap: onTap3,
          ),
          card(
            bgColor: AppColors.lightRed,
            title: title4,
            subTitle: subTitle4,
            count: count4,
            fontColor: AppColors.red,
            iconPath: icon4,
            width: width,
            onTap: onTap4,
          ),
        ],
      ),
      isNext
          ? Column(
              children: [
                customSizedBox(height: 15),
                Row(
                  children: [
                    card(
                      bgColor: Color(0xFFE8E9FF),
                      title: title5,
                      subTitle: subTitle5,
                      count: count5,
                      fontColor: AppColors.navyBlue,
                      iconPath: icon5,
                      width: width,
                      onTap: onTap5,
                    ),
                  ],
                ),
              ],
            )
          : const SizedBox(),
    ],
  );
}

Widget dateRangePicker({
  double height = 20,
  double width = 20,
}) {
  HomeController controller = Get.find<HomeController>();
  return GestureDetector(
      onTap: () => showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
              title: Row(
                children: [
                  largeText(
                    title: "Select Time Period",
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
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      shopCard(
                        title: "Today",
                        onTap: () {
                          controller.changeDateRangeIndex(0);
                          controller.days.value = "1";
                          controller.getHomeDetails();
                          Get.back();
                        },
                        isSelected:
                            controller.dateRangeIndex.value == 0 ? true : false,
                      ),
                      shopCard(
                        title: "Yesterday",
                        onTap: () {
                          controller.changeDateRangeIndex(1);
                          controller.days.value = "2";
                          controller.getHomeDetails();
                          Get.back();
                        },
                        isSelected:
                            controller.dateRangeIndex.value == 1 ? true : false,
                      ),
                      shopCard(
                        title: "Last 7 days",
                        onTap: () {
                          controller.changeDateRangeIndex(2);
                          controller.days.value = "7";
                          controller.getHomeDetails();
                          Get.back();
                        },
                        isSelected:
                            controller.dateRangeIndex.value == 2 ? true : false,
                      ),
                      shopCard(
                        title: "Last 30 days",
                        onTap: () {
                          controller.changeDateRangeIndex(3);
                          controller.days.value = "30";
                          controller.getHomeDetails();
                          Get.back();
                        },
                        isSelected:
                            controller.dateRangeIndex.value == 3 ? true : false,
                      ),
                      shopCard(
                        title: "Last Quarter",
                        onTap: () {
                          controller.changeDateRangeIndex(4);
                          controller.days.value = "90";
                          Get.back();
                        },
                        isSelected:
                            controller.dateRangeIndex.value == 4 ? true : false,
                      ),
                      shopCard(
                        title: "Custom",
                        onTap: () {
                          controller.changeDateRangeIndex(5);
                          Get.back();
                        },
                        isSelected:
                            controller.dateRangeIndex.value == 5 ? true : false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      child: Container(
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
          right: 10,
          left: 12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.5,
            color: AppColors.offWhite,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(ImgRoutes.CALENDERICON),
            customSizedBox(width: 5),
            Obx(
              () => smallText(
                title: controller.dateRangeIndex.value == 0
                    ? "Today"
                    : controller.dateRangeIndex.value == 1
                        ? "Yesterday"
                        : controller.dateRangeIndex.value == 2
                            ? "Last 7 days"
                            : controller.dateRangeIndex.value == 3
                                ? "Last 30 days"
                                : controller.dateRangeIndex.value == 4
                                    ? "Last Quarter"
                                    : "Custom",
                fontWeight: FontWeight.w500,
                fontColor: AppColors.black,
              ),
            ),
            customSizedBox(width: 15),
            SvgPicture.asset(ImgRoutes.ARROWDOWN),
          ],
        ),
      ));
}
