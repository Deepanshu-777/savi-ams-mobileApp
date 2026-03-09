import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/sign_up/sign_up_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../theme/app_colors.dart';

Widget signUpBottomsheet({
  double width = 20,
}) {
  SignUpController controller = Get.find<SignUpController>();
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
        child: Column(children: [
          customTextField(
            controller: controller.nameController,
            hintText: "Name",
          ),
          customSizedBox(height: 22.5),
          customTextField(
            controller: controller.emailController,
            hintText: "Email Address",
          ),
          customSizedBox(height: 22.5),
          customTextField(
            controller: controller.phoneController,
            hintText: "Phone Number",
          ),
          customSizedBox(height: 22.5),
          customTextField(
            controller: controller.passwordController,
            hintText: "Password",
          ),
          customSizedBox(height: 22.5),
          customTextField(
            controller: controller.confirmPasswordController,
            hintText: "Confirm Password",
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
              onPressed: () {},
              title: "Sign Up",
            ),
          ),
          customSizedBox(height: 12),
          GestureDetector(
            onTap: () => Get.offNamed(Routes.LOGIN),
            child: const Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Outfit",
                    color: AppColors.lightBlue,
                  ),
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Outfit",
                      color: AppColors.white,
                    )),
              ]),
            ),
          ),
        ]),
      ),
    ],
  );
}
