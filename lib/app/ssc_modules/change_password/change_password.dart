import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/change_password/change_password_controller.dart';
import 'package:rail_weld/app/ssc_modules/change_password/widgets.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
      ),
      bottomSheet: passwordBottomSheet(
        width: width,
        height: height,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSizedBox(height: 30),
              largeText(
                title: "Change Password",
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 11),
              mediumText(
                title:
                    "Enter new password, Now track and manage all the Welding Assets with SAVI AMS.",
                height: 1.5,
                fontColor: AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
