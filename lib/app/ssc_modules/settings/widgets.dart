import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rail_weld/app/ssc_modules/settings/settings_controller.dart';
import 'package:rail_weld/model/scc_module_models/profile_details_model.dart';
import 'package:rail_weld/theme/app_colors.dart';
import 'package:rail_weld/widgets/custom_image_viewer.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import '../../../routes/img_routes.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/image_picker_bottomsheet.dart';
import '../../../widgets/sheet_topbar.dart';
import '../../../widgets/title_text_field.dart';

SettingsController controller = Get.find<SettingsController>();

Widget imagePicker(
  double? width,
) {
  UserData? user = controller.profileDetails.value.data?.userData ?? UserData();
  return Stack(
    children: [
      GestureDetector(
        onTap: () => Get.to(
          () => customImageViewer(
            imgUrl: user.profilePicture ?? "",
            width: width ?? 20,
          ),
        ),
        child: Obx(
          () => Container(
            height: 122,
            width: 122,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.offWhite,
              image: DecorationImage(
                image: controller.localImagePath.value != ""
                    ? FileImage(
                        File(
                          controller.localImagePath.value,
                        ),
                      ) as ImageProvider
                    : NetworkImage(
                        user.profilePicture.toString(),
                      ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 15,
        child: GestureDetector(
          onTap: () => Get.bottomSheet(
            imagePickerBottomsheet(
              onCamera: () {
                controller.takePhoto(
                  ImageSource.camera,
                );
                Get.back();
              },
              onGallary: () {
                controller.takePhoto(
                  ImageSource.gallery,
                );
                Get.back();
              },
            ),
          ),
          child: SvgPicture.asset(
            ImgRoutes.IMAGEPICKER,
            height: 30,
            width: 30,
          ),
        ),
      ),
    ],
  );
}

Widget textFieldColumn({
  double? width,
}) {
  return Expanded(
    child: SingleChildScrollView(
      child: Form(
        key: controller.profileFormKey,
        child: Obx(() {
          UserData? user =
              controller.profileDetails.value.data?.userData ?? UserData();
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: imagePicker(width),
              ),
              customSizedBox(height: 30),
              titleTextField(
                controller: controller.nameController,
                hintText: "Enter Full Name",
                title: "Name",
                isSuffix: true,
              ),
              titleTextField(
                controller: controller.emailController,
                hintText: "Enter Email Address",
                title: "Email Address",
                // isSuffix: true,
                isReadOnly: true,
                // errorTextColor: AppColors.navyBlue,
                // validator: (email) => controller.validateEmail(email),
              ),
              titleTextField(
                controller: controller.phoneNoController,
                hintText: "Enter Phone No",
                title: "Phone Number",
                isSuffix: true,
                validator: (phone) {
                  return phone?.length != 10
                      ? "Enter valid phone number ."
                      : null;
                },
                errorTextColor: AppColors.navyBlue,
              ),
              titleTextField(
                controller: controller.roleController,
                hintText: "Enter your role",
                title: "Role",
                isSuffix: false,
                isReadOnly: true,
              ),
              titleTextField(
                controller: controller.designationController,
                hintText: "Enter your designation",
                title: "Designation",
                isSuffix: false,
                isReadOnly: true,
              ),
              // titleTextField(
              //   controller: controller.shopController,
              //   hintText: "Enter shop",
              //   title: "Department / Shop ",
              //   isSuffix: false,
              //   isReadOnly: true,
              // ),
            ],
          );
        }),
      ),
    ),
  );
}

Future<dynamic> changePasswordBottomsheet() {
  return showModalBottomSheet(
    context: Get.context!,
    builder: (context) => Container(
      padding: const EdgeInsets.only(
        top: 31,
        left: 24,
        right: 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
          ),
          child: Form(
            key: controller.changePasswordformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bottomSheetTopbar(title: "Change Password"),
                customSizedBox(height: 29),
                mediumText(
                  title: "New Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.black,
                ),
                customSizedBox(height: 9),
                Obx(
                  () => customTextField(
                    controller: controller.newPasswordController,
                    hintText: "Enter New Password",
                    validator: (value) => controller.validatePassword(value),
                    errorTextColor: AppColors.navyBlue,
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
                customSizedBox(height: 16),
                mediumText(
                  title: "Confirm Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.black,
                ),
                customSizedBox(height: 9),
                Obx(
                  () => customTextField(
                    controller: controller.cPasswordController,
                    hintText: "Re-Enter New Password",
                    validator: (value) => controller.validatePassword(value),
                    errorTextColor: AppColors.navyBlue,
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
                customSizedBox(height: 23),
                SizedBox(
                  width: double.infinity,
                  child: customElevatedButton(
                    onPressed: () async {
                      bool isPasswordMatch =
                          controller.newPasswordController.value.text ==
                              controller.cPasswordController.value.text;
                      if (controller.changePasswordformKey.currentState!
                          .validate()) {
                        if (!isPasswordMatch) {
                          customToast(msg: "  Password doesn't match!  ");
                        } else if (isPasswordMatch) {
                          controller.updatePassword();
                        }
                      }
                    },
                    title: "Update Password",
                    bgColor: AppColors.navyBlue,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
                customSizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
