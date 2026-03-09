import 'package:get/get.dart';
import 'package:rail_weld/app/ssc_modules/sign_up/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(
      () => SignUpController(),
      fenix: true,
    );
  }
}
