import 'package:flutter/material.dart';
import '../app/ssc_modules/main_view/widget.dart';
import '../theme/app_colors.dart';
import 'custom_back_button.dart';

Widget customAppBar({
  bool isBackButton = true,
  void Function()? onBackPressed,
}) {
  return Container(
    padding: const EdgeInsets.only(
      right: 24,
      top: 30,
      bottom: 30,
    ),
    child: Row(
      children: [
        isBackButton
            ? customBackButton(
                color: AppColors.white,
                onTap: onBackPressed,
              )
            : const SizedBox(
                width: 24,
              ),
        userDetail(),
        // const Spacer(),
        // GestureDetector(
        //   onTap: () => Get.toNamed(Routes.SETTINGS),
        //   child: SvgPicture.asset(
        //     "assets/images/svg_img/setting_icon.svg",
        //     height: 45,
        //     width: 45,
        //   ),
        // ),
      ],
    ),
  );
}
