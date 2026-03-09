import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/ticket_raised_controller.dart';

class TicketRaisedBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TicketRaisedController>(
      TicketRaisedController(),
    );
  }
}
