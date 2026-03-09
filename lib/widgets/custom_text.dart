import 'package:flutter/material.dart';
import 'package:rail_weld/theme/app_colors.dart';

Widget largeText({
  required String title,
  Color fontColor = AppColors.white,
  double fontSize = 28,
  TextAlign? textAlign = TextAlign.start,
  FontWeight? fontWeight = FontWeight.w600,
  double? letterSpacing,
  TextDecoration? decoration,
}) {
  return Text(
    title,
    overflow: TextOverflow.ellipsis,
    maxLines: 20,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: "Outfit",
      color: fontColor,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      decoration: decoration,
    ),
  );
}

Widget mediumText({
  required String title,
  Color fontColor = AppColors.white,
  double fontSize = 16,
  String? fontFamily = "Outfit",
  FontWeight? fontWeight = FontWeight.w400,
  double height = 1,
  TextAlign? textAlign = TextAlign.start,
  int? maxLines = 100,
  bool? softWrap,
  List<Shadow>? shadows,
  double? letterSpacing,
}) {
  return Text(
    title,
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    softWrap: softWrap,
    style: TextStyle(
      fontFamily: fontFamily,
      color: fontColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
      height: height,
      letterSpacing: letterSpacing,
    ),
  );
}

Widget smallText({
  required String title,
  double fontSize = 14,
  String? fontFamily = "Outfit",
  FontWeight? fontWeight = FontWeight.w400,
  Color fontColor = AppColors.white,
  TextAlign textAlign = TextAlign.start,
  int? maxLines = null,
  TextDecoration? decoration,
}) {
  return Text(
    title,
    textAlign: textAlign,
    style: TextStyle(
      fontFamily: fontFamily,
      color: fontColor,
      fontWeight: fontWeight,
      fontSize: fontSize,
      decoration: decoration,
    ),
    maxLines: maxLines,
  );
}
