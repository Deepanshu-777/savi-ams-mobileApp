import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/ticket_maintenance/ticket_maintenance_controller.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_tickets/total_tickets_controller.dart';

class TotalTicketsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TotalTicketsController>(
      TotalTicketsController(),
      permanent: true,
    );
    Get.put<TicketMaintenanceController>(
      TicketMaintenanceController(),
    );
  }
}
