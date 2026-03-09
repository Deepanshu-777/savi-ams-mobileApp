import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/model/scc_module_models/profile_details_model.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/storage/storage.dart';
import 'package:rail_weld/widgets/custom_toast.dart';
import 'dart:developer';
import '../../../routes/urls.dart';
import '../../../service/network_requester.dart';
import '../../response_team_module/main_view/home/response_home_controller.dart';

class SettingsController extends GetxController {
  final ImagePicker picker = ImagePicker();
  GlobalKey<FormState> changePasswordformKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  String? userId = Storage.getUserId();

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    userIdController = TextEditingController();
    emailController = TextEditingController();
    phoneNoController = TextEditingController();
    roleController = TextEditingController();
    designationController = TextEditingController();
    shopController = TextEditingController();
    newPasswordController = TextEditingController();
    cPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    userIdController.dispose();
    emailController.dispose();
    phoneNoController.dispose();
    roleController.dispose();
    designationController.dispose();
    shopController.dispose();
    newPasswordController.dispose();
    cPasswordController.dispose();
  }

  late TextEditingController nameController;
  late TextEditingController userIdController;
  late TextEditingController emailController;
  late TextEditingController phoneNoController;
  late TextEditingController roleController;
  late TextEditingController designationController;
  late TextEditingController shopController;
  late TextEditingController newPasswordController;
  late TextEditingController cPasswordController;

  RxString base64Image = "".obs;
  RxString localImagePath = "".obs;

  void takePhoto(
    ImageSource source,
  ) async {
    final pickedImage = await picker.pickImage(
      source: source,
      imageQuality: 20,
    );
    log("Img :: ${pickedImage?.path.toString()}");
    File file = File(pickedImage?.path ?? "");
    Uint8List bytes = file.readAsBytesSync();
    base64Image.value = base64Encode(bytes);
    localImagePath.value = pickedImage?.path ?? "";
  }

  Future<void> editProfile() async {
    String? role = Storage.getRole();
    String imageBaseUrl = "data:image/png;base64,";
    log(base64Image.value);
    final response = await NetworkRequester().post(
      api: () async => await editProfile(),
      path: Urls.EDITPROFILE,
      data: {
        "user_id": Storage.getUserId(),
        "name": nameController.value.text.trim(),
        "email": emailController.value.text.trim(),
        "phone": phoneNoController.value.text.trim(),
        "profile_picture":
            base64Image.value == "" ? "" : imageBaseUrl + base64Image.value,
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        customToast(msg: "   Profile updated successfully!   ");
        if (role == "3" || role == "1") {
          if (Get.isRegistered<HomeController>()) {
            HomeController homeController = Get.find<HomeController>();
            await homeController.getHomeDetails(
              isLoader: false,
            );
          }
        } else {
          if (Get.isRegistered<ResponseHomeController>()) {
            ResponseHomeController responseHomeController =
                Get.find<ResponseHomeController>();
            await responseHomeController.getHomeDetails(
              isLoader: false,
            );
          }
        }
        base64Image.value = "";
      }
    }
  }

  Rx<ProfileDetails> profileDetails = ProfileDetails().obs;

  Future<void> getProfileDetails({
    bool isLoader = true,
    bool isEdit = false,
  }) async {
    String? userId = Storage.getUserId();
    final response = await NetworkRequester().get(
      api: () async => await getProfileDetails(),
      path: "${Urls.PROFILEDETAILS}/${userId}",
      isLoader: isLoader,
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        profileDetails.value = profileDetailsFromJson(res);
        UserData? userData = profileDetails.value.data?.userData;
        Storage.setName(profileDetails.value.data?.userData?.name);
        Storage.setPhone(profileDetails.value.data?.userData?.phone);
        Storage.setProfilePic(
            (profileDetails.value.data?.userData?.profilePicture ?? ""));
        isEdit ? () {} : Get.toNamed(Routes.SETTINGS);
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            nameController..text = userData?.name ?? "";
            emailController..text = userData?.email ?? "";
            phoneNoController..text = (userData?.phone ?? "").toString();
            roleController..text = userData?.role ?? "";
            designationController..text = userData?.department ?? "";
            shopController..text = userData?.department ?? "";
          },
        );
      }
    }
  }

  Future<void> updatePassword() async {
    final response = await NetworkRequester().post(
      api: () async => await updatePassword(),
      path: Urls.UPDATEPASSWORD,
      data: {
        "user_id": Storage.getUserId(),
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
        Get.back();
      }
    }
  }

  Future<void> logout() async {
    final response = await NetworkRequester().post(
      api: () async => await logout(),
      path: Urls.LOGOUT,
      data: {
        "user_id": Storage.getUserId(),
      },
    );
    if (response != null) {
      String res = jsonEncode(response);
      if (jsonDecode(res)["success"] == true) {
        Storage.clear();
        Get.offAllNamed(Routes.ONBOARDING);
      }
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

  RxBool isCPasswordVisible = false.obs;

  void toggleCPasswordVisibility() {
    isCPasswordVisible.value = !isCPasswordVisible.value;
  }
}
