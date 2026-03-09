import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/maintenance/maintenance_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/res_machine_list/res_machine_list_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/response_main_view_controller.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';
import 'package:rail_weld/app/ssc_modules/settings/settings_controller.dart';
import '../../ssc_modules/login/login_controller.dart';

class ResponseMainViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ResponseMainViewController>(
      ResponseMainViewController(),
    );
    Get.put<TicketMaintenanceController>(
      TicketMaintenanceController(),
    );
    Get.put<ResMachineListController>(
      ResMachineListController(),
    );
    Get.put<SettingsController>(
      SettingsController(),
      permanent: true,
    );
    Get.lazyPut<ResponseHomeController>(
      () => ResponseHomeController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put<LoginController>(
      LoginController(),
      permanent: true,
    );
    Get.lazyPut<MaintenanceController>(
      () => MaintenanceController(),
    );
  }
}
