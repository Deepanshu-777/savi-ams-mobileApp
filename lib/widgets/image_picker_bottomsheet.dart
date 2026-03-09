import 'package:flutter/material.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import '../theme/app_colors.dart';
import 'custom_text.dart';

Widget imagePickerBottomsheet({
  String label = "Select Profile Photo",
  required void Function()? onGallary,
  required void Function()? onCamera,
}) {
  return Container(
    color: AppColors.navyBlue,
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        smallText(
          title: label,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          fontColor: AppColors.white,
        ),
        customSizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
              ),
              onPressed: onCamera,
              icon: const Icon(
                Icons.camera,
                color: AppColors.navyBlue,
              ),
              label: smallText(
                title: "Take Photo",
                fontSize: 12,
                fontColor: AppColors.navyBlue,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 40,
                ),
              ),
              onPressed: onGallary,
              icon: const Icon(
                Icons.photo,
                color: AppColors.navyBlue,
              ),
              label: smallText(
                title: "Gallery",
                fontSize: 12,
                fontColor: AppColors.navyBlue,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
