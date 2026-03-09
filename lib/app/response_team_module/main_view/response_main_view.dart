import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/maintenance/maintenance.dart';
import 'package:rail_weld/app/response_team_module/main_view/res_machine_list/res_machine_list.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance.dart';
import 'package:rail_weld/app/response_team_module/main_view/widget.dart';
import 'package:rail_weld/routes/app_pages.dart';
import 'package:rail_weld/routes/img_routes.dart';
import '../../../theme/app_colors.dart';
import 'home/response_home.dart';
import 'response_main_view_controller.dart';

class ResponseMainView extends GetView<ResponseMainViewController> {
  const ResponseMainView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          bottomNavigationBar: bottomNavigationBar(height: height),
          body: Obx(
            () => controller.selectedTabIndex.value == 0
                ? const ResponseHomeView()
                : controller.selectedTabIndex.value == 1
                    ? WillPopScope(
                        onWillPop: () async {
                          controller.changeTabIndex(0);
                          return false;
                        },
                        child: const ResMachineListView(),
                      )
                    : controller.selectedTabIndex.value == 3
                        ? WillPopScope(
                            onWillPop: () async {
                              controller.changeTabIndex(0);
                              return false;
                            },
                            child: const TicketMaintenanceView(),
                          )
                        : WillPopScope(
                            onWillPop: () async {
                              controller.changeTabIndex(0);
                              return false;
                            },
                            child: const MaintenanceView(),
                          ),
          ),
        ),
        Positioned(
          bottom: height * 0.04,
          left: width * 0.43,
          child: GestureDetector(
            onTap: () => Get.toNamed(
              Routes.RESBARCODESCANNER,
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
