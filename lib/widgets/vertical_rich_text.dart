import 'package:flutter/material.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

Widget verticalRichText({
  required String title,
  required String subTitle,
  double subTitleFontSize = 16,
  FontWeight subTitleFontWeight = FontWeight.w600,
  double vPadding = 0,
  FontWeight titleFontWeight = FontWeight.w400,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      smallText(
        title: title,
        fontColor: AppColors.black,
        fontWeight: titleFontWeight,
      ),
      customSizedBox(height: vPadding),
      smallText(
        title: subTitle,
        fontSize: subTitleFontSize,
        fontWeight: subTitleFontWeight,
        fontColor: AppColors.black,
      ),
    ],
  );
}
