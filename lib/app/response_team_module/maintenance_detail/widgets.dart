import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/routes/app_pages.dart';

import '../../../routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';
import '../../ssc_modules/machine_details/widget.dart';

List<Widget> body({
  double? height,
}) {
  return [
    customSizedBox(height: 22),
    Expanded(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.offWhite,
                  width: 0.5,
                ),
              ),
              child: Image.asset(
                "assets/images/png_img/img.png",
                height: height! * 0.3,
                width: double.infinity,
              ),
            ),
            customSizedBox(height: 24),
            largeText(
              title:
                  "400 ampress Dual IGBT Invertor Type DC Arc Welding Machine",
              fontSize: 16,
              fontColor: AppColors.navyBlue,
            ),
            customSizedBox(height: 11),
            mediumText(
              title:
                  "Arc 200i is an IGBT based single phase portable inverter welding machine for continuous welding with 4mm electrodes.",
              fontSize: 14,
              fontWeight: FontWeight.w200,
              fontColor: AppColors.offGrey,
              height: 1.5,
            ),
            customSizedBox(height: 32),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    detailTitle(title: "Local No. : "),
                    detailTitle(title: "Maintenance Due Date : "),
                    detailTitle(title: "Vendor Name : "),
                    detailTitle(title: "Vendor Number : "),
                  ],
                ),
                customSizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      detailValue(title: "72356754781"),
                      detailValue(title: "Make: "),
                      detailValue(title: "Model: "),
                      detailValue(title: "PO Number: "),
                    ],
                  ),
                )
              ],
            ),
            customSizedBox(height: 26),
            mediumText(
              title: "Status",
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontColor: AppColors.black,
            ),
            customSizedBox(height: 9),
            GestureDetector(
              onTap: () => Get.toNamed(
                Routes.REMARK,
              ),
              child: currentTicketStatus(),
            ),
          ],
        ),
      ),
    ),
  ];
}

Widget currentTicketStatus() {
  return Container(
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
        title: "Acknowledged",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontColor: AppColors.black,
      ),
      const Spacer(),
      SvgPicture.asset(ImgRoutes.ARROWDOWN),
    ]),
  );
}
