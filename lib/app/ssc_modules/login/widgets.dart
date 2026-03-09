import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/login/login_controller.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text.dart';
import 'package:rail_weld/widgets/custom_text_field.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../theme/app_colors.dart';

Widget loginBottomSheet({
  required TextEditingController emailController,
  required TextEditingController passwordController,
  double width = 20,
}) {
  LoginController controller = Get.find<LoginController>();
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
        child: Form(
          key: controller.loginFormKey,
          child: Column(children: [
            customTextField(
              controller: emailController,
              hintText: "Email Address",
              validator: (val) => controller.validateEmail(val),
            ),
            customSizedBox(height: 22.5),
            Obx(
              () => customTextField(
                controller: passwordController,
                hintText: "Password",
                validator: (val) => controller.validatePassword(val),
                suffix: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => controller.togglePasswordVisibility(),
                  icon: controller.isPasswordVisible.value
                      ? Icon(
                          Icons.visibility,
                          color: AppColors.navyBlue,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: AppColors.navyBlue,
                        ),
                ),
                obscureText: !controller.isPasswordVisible.value,
              ),
            ),
            customSizedBox(height: 14.5),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.FORGOTPASSWORD),
              child: Align(
                alignment: Alignment.centerRight,
                child: smallText(
                  title: "Forgot Password ?",
                ),
              ),
            ),
            customSizedBox(
              height: width * 0.15,
            ),
            SizedBox(
              width: double.infinity,
              child: customElevatedButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 14.43,
                ),
                onPressed: () async {
                  if (controller.loginFormKey.currentState!.validate()) {
                    controller.userLogin();
                  }
                },
                title: "Login",
              ),
            ),
            customSizedBox(height: 12),
            // GestureDetector(
            //   onTap: () => Get.offNamed(Routes.SIGNUP),
            //   child: const Text.rich(
            //     TextSpan(children: [
            //       TextSpan(
            //         text: "Don't have an account? ",
            //         style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           fontFamily: "Outfit",
            //           color: AppColors.lightBlue,
            //         ),
            //       ),
            //       TextSpan(
            //           text: "Sign Up",
            //           style: TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //             fontFamily: "Outfit",
            //             color: AppColors.white,
            //           )),
            //     ]),
            //   ),
            // ),
          ]),
        ),
      ),
    ],
  );
}
