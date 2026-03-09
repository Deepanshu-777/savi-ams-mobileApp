import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/main_view/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
      permanent: true,
    );
  }
}
