import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/routes/img_routes.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'custom_elevated_button.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

Future<dynamic> suretyDialog({
  required void Function() onYesPressed,
  required void Function() onNoPressed,
  String title = "Are you sure you want to delete this attachment?",
}) {
  return Future.delayed(
      Duration.zero,
      () => showDialog(
            context: Get.context!,
            builder: (context) => AlertDialog(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 33,
                vertical: 31,
              ),
              surfaceTintColor: AppColors.white,
              backgroundColor: AppColors.white,
              scrollable: true,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(ImgRoutes.DELETEICON),
                  customSizedBox(height: 11),
                  largeText(
                    title: "Confirmation",
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.navyBlue,
                    fontSize: 20,
                    textAlign: TextAlign.center,
                  ),
                  customSizedBox(height: 17),
                  smallText(
                    title: title,
                    fontSize: 14,
                    fontColor: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
                  customSizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      customElevatedButton(
                        onPressed: onNoPressed,
                        fontSize: 14,
                        title: "No ",
                        fontColor: AppColors.black,
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 33,
                        ),
                        bgColor: AppColors.lightNavyBlue,
                      ),
                      customElevatedButton(
                        onPressed: onYesPressed,
                        fontSize: 14,
                        title: "Yes",
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 33,
                        ),
                        bgColor: AppColors.navyBlue,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));
}
