import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/analytics/analytics.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_tickets/total_tickets.dart';
import 'package:rail_weld/app/ssc_modules/main_view/widget.dart';
import '../../../routes/app_pages.dart';
import '../../../routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import 'main_view_controller.dart';

class MainView extends GetView<MainViewController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: bottomNavigationBar(width: height),
          body: Obx(
            () => controller.selectedTabIndex.value == 0
                ? const HomeView()
                : controller.selectedTabIndex.value == 1
                    ? WillPopScope(
                        onWillPop: () async {
                          controller.changeTabIndex(0);
                          return false;
                        },
                        child: const TotalMachinesView(),
                      )
                    : controller.selectedTabIndex.value == 3
                        ? WillPopScope(
                            onWillPop: () async {
                              controller.changeTabIndex(0);
                              return false;
                            },
                            child: const TotalTicketsView(),
                          )
                        : WillPopScope(
                            onWillPop: () async {
                              controller.changeTabIndex(0);
                              return false;
                            },
                            child: const AnalyticsView(),
                          ),
          ),
        ),
        Positioned(
          bottom: height * 0.04,
          left: width * 0.43,
          child: GestureDetector(
            onTap: () => Get.toNamed(
              Routes.BARCODESCANNER,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.navyBlue,
                borderRadius: BorderRadius.circular(15),
              ),
              height: width * 0.14,
              width: width * 0.14,
              child: SvgPicture.asset(
                ImgRoutes.BARCODE,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
