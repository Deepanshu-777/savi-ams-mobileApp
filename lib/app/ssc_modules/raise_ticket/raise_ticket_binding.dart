import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/raise_ticket/raise_ticket_controller.dart';
import 'package:rail_weld/app/ssc_modules/ticket_raised/ticket_raised_controller.dart';

class RaiseTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RaiseTicketController>(
      () => RaiseTicketController(),
    );
    Get.lazyPut<TicketRaisedController>(
      () => TicketRaisedController(),
    );
  }
}
