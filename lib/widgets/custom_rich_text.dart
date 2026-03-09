import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

Widget richText({
  required String title,
  required String subTitle,
  Color subTitleColor = AppColors.black,
  double titleFontSize = 13,
  double subTitleFontSize = 13,
  FontWeight? subTitleFontWeight = FontWeight.w400,
}) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: title,
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w400,
            fontFamily: "Outfit",
          ),
        ),
        TextSpan(
          text: subTitle,
          style: TextStyle(
            fontSize: subTitleFontSize,
            fontWeight: FontWeight.w400,
            fontFamily: "Outfit",
            color: subTitleColor,
          ),
        )
      ],
    ),
  );
}
