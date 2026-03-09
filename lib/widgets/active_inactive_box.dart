import 'package:flutter/material.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';

import '../theme/app_colors.dart';
import 'custom_text.dart';

Widget activeInactiveBox({
  String status = "Active",
  EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 3,
  ),
  Color? bgColor,
  Color? borderColor,
  double? height,
  double? width,
  bool isDropdown = false,
  double fontSize = 12,
}) {
  return Container(
    width: width,
    height: height,
    padding: padding,
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
        mediumText(
          title: status,
          fontColor: borderColor ?? AppColors.green,
          fontWeight: FontWeight.w500,
          fontSize: fontSize,
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
                      color: borderColor ?? AppColors.green,
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ],
    ),
  );
}
