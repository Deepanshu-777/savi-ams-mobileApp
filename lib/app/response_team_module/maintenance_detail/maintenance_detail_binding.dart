import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/maintenance_detail/maintenance_detail_controller.dart';

class MaintenanceDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaintenanceDetailController>(
      () => MaintenanceDetailController(),
    );
  }
}
