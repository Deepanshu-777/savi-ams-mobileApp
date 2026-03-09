import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/remark/remark_controller.dart';

class RemarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemarkController>(
      () => RemarkController(),
    );
  }
}
