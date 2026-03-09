import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rail_weld/data/strings.dart';
import '../theme/app_colors.dart';

customDialog({
  required String heading,
  required String subHeading,
  required VoidCallback onOkTap,
  VoidCallback? onCancelTap,
  String? okButtonText,
}) {
  return Get.dialog(
      barrierDismissible: false,
      Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(subHeading),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (onCancelTap != null) ...[
                      GestureDetector(
                        onTap: onCancelTap,
                        child: Container(
                            color: AppColors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              Strings.no,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.navyBlue,
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                    GestureDetector(
                      onTap: onOkTap,
                      child: Container(
                          color: AppColors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            okButtonText ?? Strings.yes,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.navyBlue,
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
}
