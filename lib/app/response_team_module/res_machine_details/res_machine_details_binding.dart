import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/res_machine_details/res_machine_details_controller.dart';
import 'package:rail_weld/app/ssc_modules/add_machine/add_machine_controller.dart';

class ResMachineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResMachineDetailsController>(
      () => ResMachineDetailsController(),
    );
    Get.lazyPut<AddMachineController>(
      () => AddMachineController(),
    );
  }
}
