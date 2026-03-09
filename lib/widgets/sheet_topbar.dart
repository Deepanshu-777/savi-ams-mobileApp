import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/theme/app_colors.dart'; 
import '../routes/img_routes.dart';
import 'custom_text.dart';

Widget bottomSheetTopbar({
  String title="Ticket Details",
}) {
  return Row(
    children: [
      largeText(
        title: title,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontColor: AppColors.black,
      ),
      const Spacer(),
      GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(ImgRoutes.CROSS),
        ),
      ),
    ],
  );
}
