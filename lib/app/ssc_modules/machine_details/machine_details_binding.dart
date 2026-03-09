import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/add_machine_controller.dart';
import 'package:rail_weld/app/ssc_modules/machine_details/machine_details_controller.dart';

class MachineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MachineDetailsController>(
      MachineDetailsController(),
    );
    Get.lazyPut<AddMachineController>(
      () => AddMachineController(),
    );
  }
}
