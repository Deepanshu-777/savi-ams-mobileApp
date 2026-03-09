import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/routes/app_pages.dart';
import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';
import '../../../widgets/custom_toast.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController emailController;
  GlobalKey<FormState> forgotPasswordKey = GlobalKey();
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
  }

  Future<void> forgotPassword({
    bool isResend = false,
  }) async {
    final response = await NetworkRequester().post(
      api: () async {
        await forgotPassword();
      },
      path: Urls.FORGOTPASSWORD,
      data: {
        "email": emailController.value.text.trim(),
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        isResend ? customToast(msg: "OTP Send Successfully") : () {};
        Get.toNamed(
          Routes.OTPVERIFICATION,
          arguments: emailController.value.text.trim(),
        );
      }
    }
  }

  String? validateEmail(String? value) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);

    return (value == null || value.isEmpty)
        ? "Please enter your email address ."
        : (value.length > 40)
            ? "Maximum 40 character"
            : (!regex.hasMatch(value.trim()))
                ? "Please enter a valid email address ."
                : null;
  }
}
