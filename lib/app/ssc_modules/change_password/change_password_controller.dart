import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/service/network_requester.dart';

import '../../../routes/urls.dart';
import '../../../widgets/custom_toast.dart';

class ChangePasswordController extends GetxController {
  String email = Get.arguments;
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  late TextEditingController newPasswordController;
  late TextEditingController cPasswordController;
  @override
  void onInit() {
    super.onInit();
    newPasswordController = TextEditingController();
    cPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    newPasswordController.dispose();
    cPasswordController.dispose();
  }

  String? validatePassword(String? value) {
    const pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,40}$";
    final regex = RegExp(pattern);

    return (value == null || value.isEmpty)
        ? "Please enter your password"
        : (value.length < 6)
            ? "Min 6 characters required ."
            : (value.length > 40)
                ? "Max 40 characters allowed ."
                : (!regex.hasMatch(value.trim()))
                    ? "Password invalid !"
                    : null;
  }

  Future<void> updatePassword() async {
    final response = await NetworkRequester().post(
      api: () async => await updatePassword(),
      path: Urls.UPDATEPASSWORDAFTEROTP,
      data: {
        "email": email,
        "password": newPasswordController.value.text.trim(),
        "password_confirmation": cPasswordController.value.text.trim(),
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        newPasswordController.text = "";
        cPasswordController.text = "";
        customToast(msg: "   Password updated successfully!   ");
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }

  RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  RxBool isCPasswordVisible = false.obs;

  void toggleCPasswordVisibility() {
    isCPasswordVisible.value = !isCPasswordVisible.value;
  }
}
