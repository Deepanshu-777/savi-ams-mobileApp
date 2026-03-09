import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/main_view_controller.dart';
import 'package:rail_weld/storage/storage.dart';
import 'package:rail_weld/theme/app_colors.dart';

import '../../../model/scc_module_models/ssc_home_model.dart' as ssc;
import '../../../routes/img_routes.dart';
import '../../../widgets/custom_image_viewer.dart';
import '../../../widgets/custom_sized_box.dart';
import '../../../widgets/custom_text.dart';

Widget bottomNavigationBar({
  required double width,
}) {
  MainViewController controller = Get.find<MainViewController>();
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
          width: width,
        ),
        bottomNavBarItem(
          color: controller.selectedTabIndex.value == 1
              ? AppColors.navyBlue
              : AppColors.grey,
          image: ImgRoutes.MACHINE,
          width: width,
        ),
        const BottomNavigationBarItem(
          backgroundColor: Colors.white,
          icon: SizedBox.shrink(),
          label: "",
        ),
        bottomNavBarItem(
          width: width,
          color: controller.selectedTabIndex.value == 3
              ? AppColors.navyBlue
              : AppColors.grey,
          image: ImgRoutes.TICKET,
        ),
        bottomNavBarItem(
          width: width,
          color: controller.selectedTabIndex.value == 4
              ? AppColors.navyBlue
              : AppColors.grey,
          image: ImgRoutes.GRAPH,
        ),
      ],
    ),
  );
}

BottomNavigationBarItem bottomNavBarItem({
  String image = ImgRoutes.ABANDONEDMACHINES,
  Color? color = AppColors.grey,
  required double width,
}) {
  return BottomNavigationBarItem(
    label: "",
    icon: Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.025),
      child: SvgPicture.asset(
        image,
        color: color,
      ),
    ),
  );
}

Widget userDetail() {
  String? role = Storage.getRole();

  if (role == "3" || role == "1") {
    return Obx(() {
      HomeController controller = Get.find<HomeController>();
      ssc.UserData? userData = controller.detail?.value.userData;
      return Row(
        children: [
          customNetworkImage(
            size: 60,
            fit: BoxFit.cover,
            imageUrl: userData?.profilePicture ?? "",
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
              customSizedBox(height: 8),
              mediumText(
                title: userData?.userName ?? "",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
            ],
          )
        ],
      );
    });
  } else {
    return Obx(() {
      ResponseHomeController responseController =
          Get.find<ResponseHomeController>();
      ssc.UserData? userData =
          responseController.detail?.value.userData ?? ssc.UserData();
      return Row(
        children: [
          customNetworkImage(
            size: 60,
            fit: BoxFit.cover,
            imageUrl: userData.profilePicture ?? "",
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
              customSizedBox(height: 8),
              mediumText(
                title: userData.userName ?? "",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
            ],
          )
        ],
      );
    });
  }
}
