import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';

class TicketMaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketMaintenanceController>(
      () => TicketMaintenanceController(),
    );
  }
}
