import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_controller.dart';
import 'package:rail_weld/model/scc_module_models/login_model.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/service/network_requester.dart';
import 'package:rail_weld/storage/storage.dart';
import '../../../model/scc_module_models/refresh_token_model.dart';
import '../../../routes/urls.dart';
import '../../../service/firebase_notification.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late Dio dio;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> userLogin() async {
    String? fcmToken =
        await FirebaseNotification().firebaseMessaging.getToken();

    final response = await NetworkRequester().post(
      api: () async {
        await userLogin();
      },
      path: Urls.LOGIN,
      data: {
        "email": (emailController.value.text.trim()).toString(),
        "password": (passwordController.value.text.trim()).toString(),
        "fcm_token": fcmToken,
      },
    );
    if (response != null) {
      Login res = loginFromJson(jsonEncode(response));

      Storage.setToken(res.data?.token);
      Storage.setRole(res.data?.user?.roleId);
      Storage.setRoleType(res.data?.user?.responseTeamType);
      Storage.setUserId(res.data?.user?.id.toString());
      Storage.setUserData(res.data?.user);
      Storage.setName(res.data?.user?.name);
      Storage.setPhone(res.data?.user?.phone);
      Storage.setProfilePic((res.data?.user?.profilePicture ?? ""));

      if (res.data?.user?.roleId.toString() == "3" || res.data?.user?.roleId.toString() == "1") {
        Get.offAllNamed(Routes.MAINVIEW);
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().getHomeDetails();
        }
        if (Get.isRegistered<TotalMachinesController>()) {
          Get.find<TotalMachinesController>().resetPagination();
          Get.find<TotalMachinesController>().getMachineList();
        }
      } else {
        Get.offAllNamed(Routes.RESPONSEMAINVIEW);
        if (Get.isRegistered<ResponseHomeController>()) {
          Get.find<ResponseHomeController>().getHomeDetails();
        }
      }
      emailController.text = "";
      passwordController.text = "";
      log("Token: ${Storage.getToken()}");
    }
  }

  Future<void> refreshToken() async {
    final response = await NetworkRequester().post(
      api: () async {
        await refreshToken();
      },
      path: Urls.REFRESHTOKEN,
      data: {"user_id": Storage.getUserId()},
    );
    if (response != null) {
      RefreshTokenModel res = refreshTokenModelFromJson(jsonEncode(response));
      Storage.setToken(res.response?.token);
    }
  }

  String? validateEmail(String? value) {
    const pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    final regex = RegExp(pattern);

    return (value == null || value.isEmpty)
        ? "Please enter your email address"
        : (value.length > 40)
            ? "Maximum 40 character"
            : (!regex.hasMatch(value.trim()))
                ? "Please enter a valid email address ."
                : null;
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

  RxBool isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
