import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/add_machine_controller.dart';

import '../raise_ticket/raise_ticket_controller.dart';

class AddMachineBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddMachineController>(
      AddMachineController(),
    );
    Get.put<RaiseTicketController>(
      RaiseTicketController(),
    );
  }
}
