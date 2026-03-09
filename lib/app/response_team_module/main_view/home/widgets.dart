
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

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
  int todayTicketAddedCount = 0,
  bool showTodayTicketAddedCount = false,
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
}) {
  return Column(
    children: [
      Row(
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
        ],
      ),
      customSizedBox(height: 24),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
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
              showTodayTicketAddedCount
                  ? Positioned(
                      left: 20,
                      top: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0, left: 6, right: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              mediumText(
                                title: "Today + ${todayTicketAddedCount}",
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                fontColor: AppColors.greenn,
                              ),
                              Icon(
                                Icons.arrow_drop_up,
                                color: AppColors.greenn,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
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
