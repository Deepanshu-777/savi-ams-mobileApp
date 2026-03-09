import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/change_password/change_password_controller.dart';
import 'package:rail_weld/widgets/custom_sized_box.dart';
import 'package:rail_weld/widgets/custom_text_field.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/custom_elevated_button.dart';

Widget passwordBottomSheet({
  double width = 20,
  double height = 20,
}) {
  ChangePasswordController controller = Get.find<ChangePasswordController>();
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
          key: controller.passwordKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSizedBox(height: 9),
              Obx(
                () => customTextField(
                  controller: controller.newPasswordController,
                  hintText: "Enter new password",
                  validator: (value) => controller.validatePassword(value),
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
              customSizedBox(height: 22.5),
              Obx(
                () => customTextField(
                  controller: controller.cPasswordController,
                  hintText: "Re-enter new password",
                  validator: (value) => controller.validatePassword(value),
                  suffix: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => controller.toggleCPasswordVisibility(),
                    icon: controller.isCPasswordVisible.value
                        ? Icon(
                            Icons.visibility,
                            color: AppColors.navyBlue,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: AppColors.navyBlue,
                          ),
                  ),
                  obscureText: !controller.isCPasswordVisible.value,
                ),
              ),
              customSizedBox(height: height * 0.07),
              SizedBox(
                width: double.infinity,
                child: customElevatedButton(
                  onPressed: () async {
                    bool isPasswordMatch =
                        controller.newPasswordController.value.text ==
                            controller.cPasswordController.value.text;
                    if (controller.passwordKey.currentState!.validate()) {
                      if (!isPasswordMatch) {
                        customToast(msg: "  Password doesn't match!  ");
                      } else if (isPasswordMatch) {
                        controller.updatePassword();
                      }
                    }
                  },
                  title: "Update Password",
                  padding: EdgeInsets.symmetric(
                    vertical: 14.43,
                  ),
                ),
              ),
              customSizedBox(height: 15),
            ],
          ),
        ),
      ),
    ],
  );
}
