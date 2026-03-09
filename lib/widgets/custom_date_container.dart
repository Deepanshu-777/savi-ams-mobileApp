import 'package:flutter/material.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'custom_text.dart';

Widget customDateContainer({
  Color? boxColor,
  String? dayNo,
  String? month,
  String? year,
  double? width,
  EdgeInsets padding = const EdgeInsets.all(15.6),
  double? borderRadius,
  Color? textColor,
  FontWeight? dayFontWeight,
  FontWeight? yearFontWeight,
  double? dayFontSize,
  double? yearFontSize,
}) {
  return Container(
    width: width,
    padding: padding,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius ?? 8),
      color: boxColor ?? AppColors.lGrey,
    ),
    child: Column(
      children: [
        smallText(
          title: "${dayNo ?? "02"} ${month ?? "JAN"}",
          fontWeight: dayFontWeight ?? FontWeight.w600,
          fontColor: textColor ?? AppColors.black,
          fontSize: dayFontSize ?? 14,
        ),
        smallText(
          title: year ?? "2024",
          fontWeight: yearFontWeight ?? FontWeight.w700,
          fontSize: yearFontSize ?? 20,
          fontColor: textColor ?? AppColors.black,
        ),
      ],
    ),
  );
}
