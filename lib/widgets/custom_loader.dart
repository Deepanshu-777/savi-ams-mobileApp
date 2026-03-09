import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/theme/app_colors.dart';

Future<void> loader() async {
  return await Future.delayed(
    Duration.zero,
    () => showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.center,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(
              color: AppColors.navyBlue,
            ),
          ],
        ),
      ),
    ),
  );
}
