import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/res_machine_list/res_machine_list_controller.dart';

class ResMachineListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResMachineListController>(
      () => ResMachineListController(),
    );
  }
}
