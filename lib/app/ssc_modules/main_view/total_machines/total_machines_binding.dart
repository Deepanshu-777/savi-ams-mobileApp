import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/total_machines/total_machines_controller.dart';

class TotalMachinesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TotalMachinesController>(
      () => TotalMachinesController(),
    );
  }
}
