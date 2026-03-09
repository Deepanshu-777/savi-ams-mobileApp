import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/on_boarding/on_boarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(
      () => OnBoardingController(),
      fenix: true,
    );
  }
}
