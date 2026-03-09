import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/login/login_controller.dart';
import 'package:rail_weld/app/ssc_modules/machine_details/machine_details_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/main_view_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_controller.dart';
import 'package:rail_weld/app/ssc_modules/settings/settings_controller.dart';

import '../../response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';

class MainViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
      permanent: true,
    );
    Get.put<MainViewController>(
      MainViewController(),
      permanent: true,
    );

    Get.lazyPut<MachineDetailsController>(
      () => MachineDetailsController(),
      fenix: true,
    );
    // Get.put<TotalTicketsController>(
    //   TotalTicketsController(),
    //   permanent: true,
    // );

    Get.put<TotalMachinesController>(
      TotalMachinesController(),
      permanent: true,
    );
    // Get.lazyPut<HomeController>(
    //   () => HomeController(),
    // );
    // Get.lazyPut<ResponseHomeController>(
    //   () => ResponseHomeController(),
    // );
    Get.put<SettingsController>(
      SettingsController(),
      permanent: true,
    );
    Get.put<TicketMaintenanceController>(
      TicketMaintenanceController(),
    );
    Get.put<LoginController>(
      LoginController(),
      permanent: true,
    );
  }
}
