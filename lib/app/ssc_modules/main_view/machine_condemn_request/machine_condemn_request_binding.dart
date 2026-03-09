import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/machine_condemn_request/machine_condemn_request_controller.dart';

class MachineCondemnRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MachineCondemnRequestController>(
      () => MachineCondemnRequestController(),
    );
  }
}
