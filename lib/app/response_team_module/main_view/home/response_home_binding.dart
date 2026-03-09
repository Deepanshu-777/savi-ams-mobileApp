import 'package:get/get.dart';
import 'package:rail_weld/app/response_team_module/main_view/home/response_home_controller.dart';

class ResponseHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponseHomeController>(
      () => ResponseHomeController(),
    );
  }
}
