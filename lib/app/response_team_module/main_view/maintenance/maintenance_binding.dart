import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/maintenance/maintenance_controller.dart';

class MaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceController>(
      () => MaintenanceController(),
    );
  }
}
