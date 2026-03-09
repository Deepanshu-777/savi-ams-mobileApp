import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/ticket_request/ticket_request_controller.dart';

class TicketRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TicketRequestController>(
      () => TicketRequestController(),
    );
  }
}
