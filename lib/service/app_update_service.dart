import 'dart:async';
import 'dart:convert';
import 'dart:developer' show log;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rail_weld/routes/urls.dart';
import 'package:rail_weld/service/network_requester.dart';
import 'package:rail_weld/widgets/custom_loader.dart';
import 'package:rail_weld/widgets/force_update_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/strings.dart';
import '../routes/app_pages.dart';
import '../storage/storage.dart';

class AppUpdateService {
  void checkIfUpdateAvailable() async {
    try {
      final forceUpdate = await appConfig();
      if (forceUpdate) {
        startForceUpdate();
      } else {
        checkUserStatus();
      }
    } catch (e, st) {
      log(st.toString());
      checkUserStatus();
    }
  }

  Future<bool> appConfig() async {
    bool forceUpdate = false;
    PackageInfo? packageInfo = await PackageInfo.fromPlatform();
    final response = await NetworkRequester().post(
      api: () async => await appConfig(),
      path: Urls.FORCE_UPDATE,
      data: {
        "build_no": packageInfo.buildNumber,
        "version": packageInfo.version,
      },
    );
    String res = jsonEncode(response);
    if ((jsonDecode(res)["forceUpdate"]) ?? false) {
      forceUpdate = true;
    }
    return forceUpdate;
  }

  void startForceUpdate() async {
    try {
      loader();
      AppUpdateInfo info = await InAppUpdate.checkForUpdate();
      Get.back();
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().then((appUpdateResult) {
          if (appUpdateResult == AppUpdateResult.userDeniedUpdate) {
            showMustUpdateDialog();
          }
        }).catchError((e) {
          debugPrint('Update failed: $e');
        });
      } else {
        showMustUpdateDialog(onUpdateNowTap: () {
          redirectUserToPlayStore();
        });
      }
    } catch (e) {
      checkUserStatus();
    }
  }

  void showMustUpdateDialog({VoidCallback? onUpdateNowTap}) {
    customDialog(
        heading: Strings.UPDATE_REQUIRED,
        subHeading: Strings.UPDATE_MANDATORY,
        onOkTap: onUpdateNowTap ?? checkIfUpdateAvailable,
        okButtonText: Strings.UPDATE_NOW);
  }

  void redirectUserToPlayStore() async {
    loader();
    await launchUrl(Uri.parse(Urls.PLAYSTOREURL));
    Get.back();
  }

  void checkUserStatus() async {
    String? token = Storage.getToken();
    String? role = Storage.getRole();
    if (token != null) {
      if (role == "3" || role == "1") {
        return Get.offAllNamed(Routes.MAINVIEW);
      } else {
        return Get.offAllNamed(Routes.RESPONSEMAINVIEW);
      }
    }
    return Get.offAllNamed(Routes.ONBOARDING);
  }
}
