// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/forgot_password/forgot_password_controller.dart';
import 'package:rail_weld/routes/app_pages.dart';
import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';

class OTPVerificationController extends GetxController {
  GlobalKey<FormState> otpKey = GlobalKey();

  late TextEditingController OTPController;
  ForgotPasswordController forgotPasswordController =
      Get.find<ForgotPasswordController>();
  Timer? timer;
  RxInt start = 60.obs;
  RxBool isEnable = false.obs;
  String email = Get.arguments;

  void startTimer() {
    const oneSec = Duration(seconds: 1);

    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start.value--;
        }
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
    OTPController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    OTPController.dispose();
  }

  Future<void> otpVerification() async {
    final response = await NetworkRequester().post(
      api: () async {
        await otpVerification();
      },
      path: Urls.OTPVERIFICATION,
      data: {
        "email": email,
        "otp": OTPController.value.text.trim(),
      },
    );
    if (response != null) {
      String res = jsonEncode(response);

      if (jsonDecode(res)["success"] == true) {
        Get.toNamed(
          Routes.CHANGEPASSWORD,
          arguments: email,
        );
      }
    }
  }
}
