import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/forgot_password/forgot_password_controller.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text_field.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../theme/app_colors.dart';

Widget loginBottomSheet({
  required TextEditingController emailController,
  double width = 20,
}) {
  ForgotPasswordController controller = Get.find<ForgotPasswordController>();
  return Wrap(
    children: [
      Container(
        decoration: const BoxDecoration(
          color: AppColors.navyBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 36,
          vertical: 35,
        ),
        width: width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          mediumText(
            title: "Enter email address",
          ),
          customSizedBox(height: 20),
          Form(
            key: controller.forgotPasswordKey,
            child: customTextField(
              controller: emailController,
              hintText: "Email Address",
              validator: (val) => controller.validateEmail(val),
            ),
          ),
          customSizedBox(
            height: width * 0.18,
          ),
          SizedBox(
            width: double.infinity,
            child: customElevatedButton(
              padding: const EdgeInsets.symmetric(
                vertical: 14.43,
              ),
              onPressed: () async {
                if (controller.forgotPasswordKey.currentState!.validate()) {
                  await controller.forgotPassword();
                }
              },
              title: "Send OTP",
            ),
          ),
          customSizedBox(height: 7),
        ]),
      ),
    ],
  );
}
