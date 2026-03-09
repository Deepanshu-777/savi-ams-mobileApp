import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/response_main_view_controller.dart';
import 'package:rail_weld/theme/app_colors.dart';
import '../../../routes/img_routes.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';

Widget bottomNavigationBar({required double height}) {
  ResponseMainViewController controller =
      Get.find<ResponseMainViewController>();
  return Obx(
    () => BottomNavigationBar(
      currentIndex: controller.selectedTabIndex.value,
      selectedLabelStyle: const TextStyle(fontSize: 0),
      unselectedFontSize: 0,
      type: BottomNavigationBarType.fixed,
      onTap: (value) => controller.changeTabIndex(value),
      items: <BottomNavigationBarItem>[
        bottomNavBarItem(
          color: controller.selectedTabIndex.value == 0
              ? AppColors.navyBlue
              : AppColors.grey,
          image: ImgRoutes.HOME,
          height: height,
        ),
        bottomNavBarItem(
          color: controller.selectedTabIndex.value == 1
              ? AppColors.navyBlue
              : AppColors.grey,
          image: ImgRoutes.MACHINE,
          height: height,
        ),
        const BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: SizedBox.shrink(),
          label: "",
        ),
        bottomNavBarItem(
          color: controller.selectedTabIndex.value == 3
              ? AppColors.navyBlue
              : AppColors.grey,
          image: ImgRoutes.TICKET,
          height: height,
        ),
        bottomNavBarItem(
          color: controller.selectedTabIndex.value == 4
              ? AppColors.navyBlue
              : AppColors.grey,
          image: ImgRoutes.SCHEDULEDMAINTENANCE,
          height: height,
        ),
      ],
    ),
  );
}

BottomNavigationBarItem bottomNavBarItem({
  String image = ImgRoutes.ABANDONEDMACHINES,
  Color? color = AppColors.grey,
  required double height,
}) {
  return BottomNavigationBarItem(
    label: "",
    icon: Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.025,
      ),
      child: SvgPicture.asset(
        image,
        color: color,
      ),
    ),
  );
}

Widget userDetail() {
  return Row(
    children: [
      const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage("assets/images/png_img/img.png"),
      ),
      customSizedBox(width: 14),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mediumText(
            title: "Hi",
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
          customSizedBox(height: 1.4),
          mediumText(
            title: "Piyush Kanwal",
            fontSize: 18,
            fontWeight: FontWeight.w600,
          )
        ],
      )
    ],
  );
}
