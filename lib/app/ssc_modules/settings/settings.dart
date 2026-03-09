import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/settings/settings_controller.dart';
import 'package:rail_weld/app/ssc_modules/settings/widgets.dart';
import 'package:rail_weld/widgets/custom_elevated_button.dart';

import '../../../theme/app_colors.dart';
import '../../../widgets/custom_back_button.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/decorated_box.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        controller.newPasswordController.text = "";
        controller.cPasswordController.text = "";
        controller.isCPasswordVisible.value = false;
        controller.isPasswordVisible.value = false;
        controller.localImagePath.value = "";
        controller.base64Image.value = "";
        return true;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          color: AppColors.white,
          margin: EdgeInsets.only(
            left: width * 0.055,
            right: width * 0.055,
          ),
          width: double.infinity,
          child: customElevatedButton(
            bgColor: AppColors.navyBlue,
            padding: const EdgeInsets.symmetric(vertical: 17),
            onPressed: () async {
              if (controller.profileFormKey.currentState!.validate()) {
                await controller.editProfile();
              }
              FocusScope.of(context).unfocus();
            },
            title: "Update Profile",
          ),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  right: 24,
                  top: 35,
                  bottom: 38,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.navyBlue,
                ),
                child: Row(
                  children: [
                    customBackButton(
                      color: AppColors.white,
                      onTap: () {
                        controller.newPasswordController.text = "";
                        controller.cPasswordController.text = "";
                        controller.isCPasswordVisible.value = false;
                        controller.isPasswordVisible.value = false;
                        controller.base64Image.value = "";
                        controller.localImagePath.value = "";
                        Get.back();
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mediumText(
                          title: "M&P LLH",
                          fontSize: 42,
                          fontFamily: "Bebas",
                          height: 0.7,
                        ),
                        smallText(
                          title: "Asset Management Tool",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Blinker",
                        ),
                      ],
                    ),
                    const Spacer(),
                    customElevatedButton(
                      onPressed: () async {
                        await controller.logout();
                      },
                      title: "Logout",
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 30,
                      ),
                    ),
                  ],
                ),
              ),
              decoratedBox(
                width: width,
                padding: EdgeInsets.only(
                  top: 5,
                  left: width * 0.055,
                  right: width * 0.055,
                  bottom: 80,
                ),
                children: [
                  customSizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      largeText(
                        title: "Settings",
                        fontSize: 26,
                        fontColor: AppColors.black,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => changePasswordBottomsheet(),
                        child: smallText(
                          title: "Change Password",
                          fontColor: AppColors.navyBlue,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  customSizedBox(height: 10),
                  textFieldColumn(width: width),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
