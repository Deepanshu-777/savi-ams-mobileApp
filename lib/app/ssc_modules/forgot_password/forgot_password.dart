import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/forgot_password/forgot_password_controller.dart';
import 'package:rail_weld/app/ssc_modules/forgot_password/widgets.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
        width: width,
        emailController: controller.emailController,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSizedBox(height: 30),
              largeText(
                title: "Forgot Password",
                fontColor: AppColors.black,
              ),
              customSizedBox(height: 11),
              mediumText(
                title: "Reset Your Password and Get Back to What Matters.",
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
