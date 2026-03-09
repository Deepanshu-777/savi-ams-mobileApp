import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/OTP_verfication/widgets.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'OTP_verfication_controller.dart';

class OTPVerificationView extends GetView<OTPVerificationController> {
  const OTPVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
      bottomSheet: loginBottomSheet(
        emailController: controller.OTPController,
        width: width,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSizedBox(height: 30),
              largeText(
                title: "Verify OTP",
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 11),
              mediumText(
                title:
                    "Almost done! To continue, enter the One-Time Password (OTP) we just sent you.",
                fontColor: AppColors.black,
                height: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
